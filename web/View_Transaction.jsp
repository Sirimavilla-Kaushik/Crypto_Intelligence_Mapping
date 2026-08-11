<%-- 
    Document   : View_Transaction
    Created on : 10-Oct-2025, 15:36:30
    Author     : user
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.Dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
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
          
            table {
                width: 90%;
                border-collapse: collapse;                
                margin-top: 20px;
                background: white;
                box-shadow: 0px 2px 5px rgba(0,0,0,0.2);
                margin-left: 66px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ccc;
                text-align: center;
            }
            th {
                background: #0563db;
                color: white;
            }
            tr:nth-child(even) {
                background: #f9f9f9;
            }
            .flagged {
                color: red;
                font-weight: bold;
            }
            .container1{
                padding: 10px;
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
    /* ===== Alert Button ===== */
.theme-btn {
    padding: 14px 28px;
    font-size: 16px;
    font-weight: 600;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    margin-left: 55px;
    width: 400px;
    height: 60px;
}

/* ===== Light Blue Theme ===== */
.theme-btn-2 {
    background: linear-gradient(135deg, #4da3ff, #1e88e5);
    color: #ffffff;
    box-shadow: 0 6px 18px rgba(77, 163, 255, 0.45);
    
}

/* ===== Hover Effect ===== */
.theme-btn-2:hover {
    background: linear-gradient(135deg, #1e88e5, #4da3ff);
    transform: translateY(-2px) scale(1.03);
    box-shadow: 0 10px 25px rgba(30, 136, 229, 0.6);
}
        </style>
</head>

<body>
    <!-- ========================= Header Start ========================= -->
    <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 px-4 px-lg-5">
        <a href="index1.jsp" class="navbar-brand d-flex align-items-center">
            <h2 class="m-0 text-primary">Crypto Analysis</h2>
        </a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-4 py-lg-0">
                <a href="Threat_Analysis_Home.jsp" class="nav-item nav-link">Home</a>
                <a href="Transaction_List1.jsp" class="nav-item nav-link">Transaction List</a>
                <a href="View_Transaction.jsp" class="nav-item nav-link active">Alert Message List</a>
                <a href="Threat_Score.jsp" class="nav-item nav-link">Check Score</a>
                <a href="index.jsp" class="nav-item nav-link">Log out</a>
            </div>
        </div>
    </nav>
    <!-- ========================= Header End ========================= -->

    <%
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
    %>
        <script>alert("<%=msg%>");</script>
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

    <h2 class="header-title" style="text-align:center; margin: 20px;">Flagged Transactions</h2>
    <table>
        <tr>
            <th>User Name</th>
            <th>User Mail</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Status</th>
            <th>Flagged</th>
        </tr>
    <%
        Dbconnection db = new Dbconnection();
        ResultSet transRs = null;
        try {
             String query = "SELECT sm.T_Id, sm.User_Id, sm.Sender_Address, sm.Receiver_Address, sm.Tx_Hash, sm.ETH_Amount, " +
                       "sm.Date_Time, sm.Risk_Score, sm.Status, sm.Flagged, u.User_Name, u.Email " +
                       "FROM transactions sm " +
                       "JOIN user_registration u ON u.U_Id = sm.User_Id " +
                       "ORDER BY sm.Date_Time ASC";
            transRs = db.Select(query);
            boolean hasData = false;

            while (transRs.next()) {
                hasData = true;
    %>
                <tr>
                    <td><%= transRs.getString("User_Name") %></td>
                    <td><%= transRs.getString("Email") %></td>
                    <td><%= transRs.getDouble("ETH_Amount") %></td>
                    <td><%= transRs.getString("Date_Time") %></td>
                    <td><%= transRs.getString("Status") %></td>
                    <td class="<%= (transRs.getInt("Flagged") == 1 ? "flagged" : "") %>">
                        <%= (transRs.getInt("Flagged") == 1 ? "Flagged" : "Normal") %>
                    </td>
                    
                </tr>
    <%
            }
            if (!hasData) {
    %>
                <tr><td colspan="8">No flagged transactions found!</td></tr>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (transRs != null) transRs.close();
            db.close();
        }
    %>
    
    </table>
    <br><br>
  <form action="Send_Mail" method="get">
      <input type="submit" value="Send Alerts to All Users" class="theme-btn theme-btn-2 wow fadeInRight" />     
</form>

       
    

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
