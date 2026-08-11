<%-- 
    Document   : Transaction_History
    Created on : 26 Aug, 2025, 12:07:52 PM
    
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="connection.Dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Crypto Analysis</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
       <link href="assets/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700&display=swap"rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/lib/animate/animate.min.css" rel="stylesheet">
    <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/form.css" rel="stylesheet">
    <link href="assets/css/view.css" rel="stylesheet">
         <style>
           /* Page title */
h2 {
    font-family: "Segoe UI", sans-serif;
    font-weight: 600;
    letter-spacing: 0.5px;
}

/* Container */
.history-table {
    width: 95%;
    margin: auto;
    overflow-x: auto;
    animation: fadeIn 0.8s ease-in-out;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    font-family: "Segoe UI", sans-serif;
}

/* Header */
th {
    background: linear-gradient(135deg, #1f3c88, #3a6cf4);
    color: #fff;
    padding: 14px;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: 0.6px;
}

/* Body cells */
td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #eee;
    font-size: 14px;
}

/* Row hover effect */
tbody tr {
    transition: all 0.3s ease;
}

tbody tr:hover {
    background: #f1f5ff;
    transform: scale(1.01);
    cursor: pointer;
}

/* Flagged status */
td.flagged {
    color: red;
    font-weight: bold;
    padding: 6px 10px;
}

/* Normal status */
td:not(.flagged) {
    color: #2e7d32;
    font-weight: 500;
}

/* No data row */
td[colspan] {
    padding: 20px;
    font-style: italic;
    color: #888;
}

/* Fade animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(15px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
      
            .nav-item{
                margin-left: 28px !important;
            }
            .navbar-nav a{
                margin-right: 0px !important;
            }
            .l li{
           margin-bottom: 10px; 
        }
        #spinner {
        transition: opacity 0.5s ease;
    }
    #spinner.hide {
        opacity: 0;
        visibility: hidden;
    }
        </style>
       
    </head>
    <body>
 
         <%
                Integer id = (Integer) session.getAttribute("id");
                String name = (String) session.getAttribute("Email");

                if (id != null && name != null) {
                    try {
                       Dbconnection db = new Dbconnection();
                        ResultSet userResult = db.Select("SELECT * FROM user_registration WHERE U_Id='" + id + "' AND Email='" + name + "'");
                        if (userResult.next()) {
                            String userName = userResult.getString("User_Name");
                           
          %>
        <div id="spinner"
     class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
        <!-- preloader end -->

        <!-- ========================= header start ========================= -->
        <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 px-4 px-lg-5">
        <a href="index1.jsp" class="navbar-brand d-flex align-items-center">
            <h2 class="m-0 text-primary">Crypto Analysis</h2>
        </a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-4 py-lg-0">
                <a href="User_Home.jsp" class="nav-item nav-link">Home</a>
                <a href="Transaction.jsp" class="nav-item nav-link">Transaction</a>
                <a href="Transaction_History.jsp" class="nav-item nav-link active">History</a>
                <a href="Transaction_Graph.jsp" class="nav-item nav-link">Graph</a>
                <a href="Check_Transaction.jsp" class="nav-item nav-link">Spam Check</a>
                <a href="User_View_Blacklist.jsp" class="nav-item nav-link">View BlackList</a>
                <a href="User_Profile.jsp" class="nav-item nav-link">Profile</a>
                <a href="index.jsp" class="nav-item nav-link">Log out</a>
            </div>
        </div>
    </nav>
        <!-- ========================= header end ========================= -->

          
             <%
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
        %>
        <script> alert("<%=msg%>");</script>
        <%
            }
            session.removeAttribute("msg");
        %>
        
      <!-- ========================= hero-section start ========================= -->
    <div class="container-fluid hero-header bg-light py-3 mb-5">
        <div class="container py-3">
            <div class="row g-5 align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 mb-3 animated slideInDown">Crypto Analysis & Intelligence Mapping Platform.</h1>
                    <p class="text-dark animated slideInDown">A blockchain analytics system capable of reconstructing cryptocurrency transaction trails and visualizing complex fund movements using spider graph representations.</p>
                    
                </div>
                <div class="col-lg-6 animated fadeIn">
                    <img class="img-fluid" src="assets/img/hero-1.png"
                        alt="">
                </div>
            </div>
        </div>
    </div>
    <!-- ========================= hero-section end ========================= -->


        <h2 style="text-align:center; margin: 20px; color: blue;">Transaction History</h2>
        <div class="history-table">
       
        <table>
            <tr>
                <th>ID</th>
                <th>Sender</th>
                <th>Receiver</th>                
                <th>Amount</th>
                <th>Date</th>               
                <th>Flagged</th>
            </tr>
            <%
                // Fetch user transactions
                ResultSet transRs = db.Select("SELECT * FROM transactions WHERE User_Id='" + id + "' ORDER BY Date_Time ASC");
                boolean hasData = false;
                while (transRs.next()) {
                    hasData = true;
                    int tId = transRs.getInt("T_Id");
                    String sender = transRs.getString("Sender_Address");
                    String receiver = transRs.getString("Receiver_Address");
                    String Tx_Hash = transRs.getString("Tx_Hash");
                    double amount = transRs.getDouble("ETH_Amount");
                    String date = transRs.getString("Date_Time");
                    String status = transRs.getString("Status");
                    int flagged = transRs.getInt("Flagged");
            %>
            <tr>
                <td><%=tId%></td>
                <td><%=sender%></td>
                <td><%=receiver%></td>                
                <td><%=amount%>ETH</td>
                <td><%=date%></td>
              
                <td class="<%= (flagged==1 ? "flagged" : "") %>">
                    <%= (flagged==1 ? "Flagged" : "Normal") %>
                </td>
            </tr>
            <%
                }
                if (!hasData) {
            %>
            <tr>
                <td colspan="7">No transactions found!</td>
            </tr>
            <%
                }
            %>
        </table>
        </div>

        <!-- ========================= footer start ========================= -->
    <div class="container-fluid bg-light footer mt-5 pt-100 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5" style="max-width: 1270px;">
            <div class="row g-4">
                <div class="col-xl-4 col-lg-4 col-md-6">
                    <h1 class="text-primary mb-40">Crypto Analysis</h1>
                    <span>An intelligence-driven platform for analyzing cryptocurrency transaction trails,
                        mapping wallet relationships, and identifying threats through graph based analysis.</span>
                    <br><br>
                    <div class="d-flex">
                        <a class="btn btn-square rounded-circle me-1" href=""><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-square rounded-circle me-1" href=""><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-square rounded-circle me-1" href=""><i class="fab fa-youtube"></i></a>
                        <a class="btn btn-square rounded-circle me-1" href=""><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-xl-2 col-lg-2 col-md-6" style="list-style: none;">
                    <h5 class="mb-60">Navigation</h5>
                    <div class="l">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">About</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="#">Team</a></li>
                            <li><a href="#">Contact</a></li>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-3 col-md-6"style="list-style: none;">
                    <h5 class="mb-60">What We Offer</h5>
                    <div class="l">
                     <li><a href="#">Transaction Trail Analysis</a></li>
                        <li><a href="#">Wallet Risk Scoring</a></li>
                        <li><a href="#">Threat Intelligence Mapping</a></li>
                        <li><a href="#">Spider Graph Visualization</a></li>
                        <li><a href="#">Admin & Threat Analysis</a></li>
                </div>
                </div>
                    <div class="col-xl-3 col-lg-3 col-md-6">
                    <h5 class="mb-60">Contact Info</h5>
                    <p>Email: support@cryptointel.com <br>
                               Phone: +91 98765 43210</p>
                    
                    <p>Address: Blockchain Research Hub, <br> Chennai, 600032.</p>
                </div>
                 
            </div>
        </div>
    </div>
    <!-- ========================= footer end ========================= -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll("tbody tr");

    rows.forEach((row, index) => {
        // stagger animation
        row.style.animation = `fadeRow 0.4s ease forwards`;
        row.style.animationDelay = `${index * 0.05}s`;

        // click highlight
        row.addEventListener("click", () => {
            rows.forEach(r => r.classList.remove("active-row"));
            row.classList.add("active-row");
        });
    });
});
</script>
     
        <%              }


} catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            } else {
                session.setAttribute("msg", "Session Out Please Login");
                response.sendRedirect("error.jsp");
            }
        %>
        

        <!-- ========================= scroll-top ========================= -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i
            class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/lib/wow/wow.min.js"></script>
    <script src="assets/lib/easing/easing.min.js"></script>
    <script src="assetslib/waypoints/waypoints.min.js"></script>
    <script src="assets/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="assets/lib/counterup/counterup.min.js"></script>
    <script src="assets/js/main.js"></script>
    </body>
</html>