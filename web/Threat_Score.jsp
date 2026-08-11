<%-- 
    Document   : Threat_Score
    Created on : 20-Jan-2026, 11:53:32
    Author     : user
--%>

<%@ page import="java.sql.*, connection.Dbconnection" %>
<!DOCTYPE html>
<html>
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
        .wrapper {
            width: 100%;
            display: flex;
            justify-content: center;
            margin-top: 50px;
        }
        .card {
            background: #fff;
            width: 420px;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.15);
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 15px 0;
        }
        button {
            padding: 10px 20px;
            background: #0563db;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .safe { color: green; font-weight: bold; }
        .moderate { color: orange; font-weight: bold; }
        .unsafe { color: red; font-weight: bold; }
        .risk { color: darkred; font-weight: bold; }
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
    </style>
</head>

<body>
<div id="spinner"
     class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
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
                <a href="Threat_Analysis_Home.jsp" class="nav-item nav-link">Home</a>
                <a href="Transaction_List1.jsp" class="nav-item nav-link">Transaction List</a>
                <a href="View_Transaction.jsp" class="nav-item nav-link">Alert Message List</a>
                <a href="Threat_Score.jsp" class="nav-item nav-link active">Check Score</a>
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
<div class="wrapper">
    <div class="card">
        <h2>Analyze Wallet Risk</h2>
        <form method="post">
            <input type="text" name="address" placeholder="Enter Ethereum Address" required>
            <button type="submit">Analyze</button>
        </form>

        <%
            String address = request.getParameter("address");
            if (address != null && !address.trim().isEmpty()) {

                try (Connection con = new Dbconnection().getConnection()) {

                    
                    String query = "SELECT Risk_Score, Flagged FROM transactions " +
                                   "WHERE Sender_Address=? OR Receiver_Address=? " +
                                   "ORDER BY T_Id DESC LIMIT 1";

                    PreparedStatement ps = con.prepareStatement(query);
                    ps.setString(1, address);
                    ps.setString(2, address);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        int score = rs.getInt("Risk_Score");
                        int flagged = rs.getInt("Flagged");

                        out.println("<hr>");
                        out.println("<p><b>Wallet:</b> " + address + "</p>");
                        out.println("<p><b>Risk Score:</b> " + score + "</p>");

                        if (score < 50) {
                            out.println("<p class='safe'>SAFE WALLET</p>");
                        } 
                        else if (score >= 50 && score < 75) {
                            out.println("<p class='moderate'>MODERATE RISK</p>");
                        } 
                        else if (score >= 75 && score < 100) {
                            out.println("<p class='risk'>HIGH RISK ZONE</p>");
                        } 
                        else {
                            out.println("<p class='unsafe'>NOT SAFE - MALICIOUS WALLET</p>");
                        }

                        if (flagged == 1) {
                            out.println("<p class='unsafe'>Flagged due to suspicious behavior</p>");
                        }

                    } else {
                        out.println("<p>No transaction history found for this wallet.</p>");
                    }

                } catch (Exception e) {
                    out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</div>
    <br><br><br>
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

