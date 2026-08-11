
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public final class RiskEngine {

    public static class RiskResult {
        public int score;
        public List<String> reasons = new ArrayList<>();
        public boolean flagged() { return score >= 70; }
    }



    public static RiskResult score(
        Connection con,
        int userId,
        String sender, String receiver,
        double usdAmount, double ethAmountCalculated,
        Long chainId, java.time.Instant now,
        java.math.BigInteger gasPriceWei,
        java.math.BigInteger gasUsed,
        Double ethAmountOnChain // nullable until confirm
    ) throws Exception {

        RiskResult r = new RiskResult();

        // 1) blacklist
        if (exists(con, "SELECT 1 FROM addr_blacklist WHERE address = ?", receiver)) {
            r.score += 100; r.reasons.add("Receiver in blacklist");
        }

        // 2) first time paying this receiver
        if (!exists(con, "SELECT 1 FROM transactions WHERE User_Id=? AND Receiver_Address=? LIMIT 1", userId, receiver)) {
            r.score += 15; r.reasons.add("First-time receiver for user");
        }

        // 3) velocity (10 minutes)
        if (count(con,
            "SELECT COUNT(*) FROM transactions WHERE User_Id=? AND Date_Time >= NOW() - INTERVAL 10 MINUTE", userId) >= 3) {
            r.score += 20; r.reasons.add("Velocity spike (10 min)");
        }
        // daily velocity
        if (count(con,
            "SELECT COUNT(*) FROM transactions WHERE User_Id=? AND DATE(Date_Time)=CURRENT_DATE()", userId) >= 10) {
            r.score += 20; r.reasons.add("Velocity spike (24h)");
        }

        // 4) amount outlier (mean + 3σ over last 30 tx)
        Double[] stats = meanStd(con,
          "SELECT USD_Amount FROM transactions WHERE User_Id=? ORDER BY T_Id DESC LIMIT 30", userId);
        if (stats != null) {
            double mean = stats[0], std = stats[1];
            if (std > 0 && usdAmount > mean + 3*std) {
                r.score += 25; r.reasons.add("USD amount outlier (>3σ)");
            }
        }

        // 5) gas price anomaly (compare to 7-day median for user)
        if (gasPriceWei != null) {
            java.math.BigDecimal median = medianGas(con, userId);
            if (median != null && median.signum() > 0) {
                java.math.BigDecimal gp = new java.math.BigDecimal(gasPriceWei);
                if (gp.compareTo(median.multiply(new java.math.BigDecimal("4"))) >= 0) {
                    r.score += 15; r.reasons.add("Gas price anomaly (>=4× median)");
                }
            }
        }

        // 6) unexpected chain
       if (chainId != null && 
    !new HashSet<>(Arrays.asList(1L, 5L, 11155111L, 1337L, 5777L, 31337L))
        .contains(chainId)) {
    
    r.score += 20; 
    r.reasons.add("Unexpected chainId " + chainId);
}


        // 7) USD→ETH mismatch when receipt is known
        if (ethAmountOnChain != null) {
            double diffPct = Math.abs(ethAmountOnChain - ethAmountCalculated) / ethAmountCalculated;
            if (diffPct > 0.05) {
                r.score += 25; r.reasons.add("ETH amount mismatch (>5%)");
            }
        }

        return r;
    }

    // helpers
    private static boolean exists(Connection con, String sql, Object... params) throws Exception {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i=0;i<params.length;i++) ps.setObject(i+1, params[i]);
            try (java.sql.ResultSet rs = ps.executeQuery()) { return rs.next(); }
        }
    }
    private static int count(Connection con, String sql, Object... params) throws Exception {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i=0;i<params.length;i++) ps.setObject(i+1, params[i]);
            try (java.sql.ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }
    private static Double[] meanStd(Connection con, String sql, Object... params) throws Exception {
        List<Double> vals = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i=0;i<params.length;i++) ps.setObject(i+1, params[i]);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) vals.add(rs.getDouble(1));
            }
        }
        if (vals.isEmpty()) return null;
        double mean = vals.stream().mapToDouble(x->x).average().orElse(0);
        double var = vals.stream().mapToDouble(x->(x-mean)*(x-mean)).sum() / vals.size();
        return new Double[]{ mean, Math.sqrt(var) };
    }
    private static java.math.BigDecimal medianGas(Connection con, int userId) throws Exception {
        String sql = "SELECT GasPrice_WEI FROM transactions WHERE User_Id=? AND Date_Time >= NOW() - INTERVAL 7 DAY AND GasPrice_WEI IS NOT NULL ORDER BY GasPrice_WEI";
        List<java.math.BigDecimal> vals = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) vals.add(rs.getBigDecimal(1));
            }
        }
        if (vals.isEmpty()) return null;
        int n = vals.size();
        return (n%2==1) ? vals.get(n/2) : vals.get(n/2-1).add(vals.get(n/2)).divide(new java.math.BigDecimal("2"));
    }
}
