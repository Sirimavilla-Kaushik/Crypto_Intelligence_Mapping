<%-- 
    Document   : User_Approval
    Created on : 28 Aug, 2025, 3:13:34 PM
    
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
       
    </head>
    <body>
        <style>
            .nav-item a{
                font-size: 15px !important;
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
                <a href="Admin_Home.jsp" class="nav-item nav-link">Home</a>
                <a href="User_Approval.jsp" class="nav-item nav-link active">User Approval</a>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">List</a>
                    <div class="dropdown-menu shadow-sm m-0">
                        <a href="Transaction_List.jsp" class="dropdown-item">Transaction List</a>
                        <a href="View_Blacklist.jsp" class="dropdown-item">BlackList Transaction</a>
                    </div>
                </div>
                  <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Graph</a>
                    <div class="dropdown-menu shadow-sm m-0">
                        <a href="View_Graph.jsp" class="dropdown-item">Transaction Graph</a>
                        <a href="MultiHopGraph.jsp" class="dropdown-item">Multi-Hop Graph</a>
                    </div>
                </div>
                  <a href="User_Details.jsp" class="nav-item nav-link">User Details</a>
                <a href="index.jsp" class="nav-item nav-link">Log Out</a>
                 
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

 
    <h2 class="header-title" style="text-align:center; margin: 20px;">User Approval</h2>
 <%
    Dbconnection db = null;
    ResultSet rs = null;

    try {
        db = new Dbconnection();
        String query = "SELECT * FROM user_registration WHERE Status='NO'";
        rs = db.Select(query);

        if (rs != null) {
            boolean hasRecords = false;
            while (rs.next()) {
                hasRecords = true;
%>
                <div class="card1">
                    <div class="card1-image">
                        <img src="User_Img.jsp?name=<%= rs.getInt("U_Id") %>"
                             class="card-img-top" alt="Profile Picture"
                             width="200px" height="250px">
                    </div>
                    <div class="card1-content">
                        <p class="card-text">
                            <strong>Consumer Name: </strong><%= rs.getString("User_Name") %><br>
                            <strong>Email: </strong><%= rs.getString("Email") %><br>
                            <strong>Contact: </strong><%= rs.getString("Mobile_Number") %><br>
                            <strong>Address: </strong><%= rs.getString("Address") %><br>
                        </p>
                        <a href="Request1.jsp?U_Id=<%= rs.getString("U_Id") %>" class="btn btn-success">Approved</a><br><br>
                        <a href="Request2.jsp?U_Id=<%= rs.getString("U_Id") %>" class="btn btn-danger">Rejected</a>
                    </div>
                </div>
<%
            }
            if (!hasRecords) {
                out.println("<p style='color:white; text-align:center;'>No pending users for approval.</p>");
            }
        } else {
            out.println("<p style='color:red; text-align:center;'>Error: Query returned no results. Check database connection.</p>");
        }
    } catch (Exception e) {
        // Log to server console
        e.printStackTrace();

        // Also show user-friendly message on page
        out.println("<p style='color:red; text-align:center;'>Something went wrong while fetching user data.</p>");
        out.println("<p style='color:gray; font-size:12px; text-align:center;'>(" + e.getMessage() + ")</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignore) {}
        if (db != null) db.close();
    }
%>


      
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