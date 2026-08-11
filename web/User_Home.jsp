<%-- 
    Document   : User_Home
    Created on : 21 Aug, 2025, 6:23:10 PM 

--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.net.Inet4Address"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.NetworkInterface"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.Dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Crypto Intelligence Mapping</title>
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
        
         <script>
            async function connectMetaMask() {
                if (typeof window.ethereum !== 'undefined') {
                    try {
                        // Request account access
                        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
                        console.log("Connected account:", accounts[0]);

                        // Display connected account
                        document.getElementById("metaMaskStatus").innerHTML = "Connected: " + accounts[0];
                    } catch (error) {
                        console.error("Error connecting to MetaMask:", error);
                        document.getElementById("metaMaskStatus").innerHTML = "Connection failed!";
                    }
                } else {
                    alert("MetaMask is not installed. Please install MetaMask and try again.");
                    document.getElementById("metaMaskStatus").innerHTML = "MetaMask not detected!";
                }
            }

            // Connect MetaMask on page load/refresh
            window.onload = connectMetaMask;
        </script>
    </head>
    <body>
        <!-- Spinner Start -->
<div id="spinner"
     class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
    <!-- Spinner End -->
        <style>
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
                <a href="User_Home.jsp" class="nav-item nav-link active">Home</a>
                <a href="Transaction.jsp" class="nav-item nav-link">Transaction</a>
                <a href="Transaction_History.jsp" class="nav-item nav-link">History</a>
                <a href="Transaction_Graph.jsp" class="nav-item nav-link">Graph</a>
                <a href="Check_Transaction.jsp" class="nav-item nav-link">Spam Check</a>
                <a href="User_View_Blacklist.jsp" class="nav-item nav-link">View BlackList</a>
                <a href="User_Profile.jsp" class="nav-item nav-link">Profile</a>
                <a href="index.jsp" class="nav-item nav-link">Log out</a>
            </div>
        </div>
    </nav>
        <!-- ========================= header end ========================= -->
    <!-- Header Start -->
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
    <!-- Header End -->
          
             <%
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
        %>
        <script> alert("<%=msg%>");</script>
        <%
            }
            session.removeAttribute("msg");
        %>
        
      

      <!-- ========================= about-section start ========================= -->
    <div class="container-xxl py-3">
    <div class="container" style="max-width:1250px;">
        <div class="row align-items-center gx-4">  

            <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
                <img class="img-fluid" style="max-height:400px;margin-left: 6px;" 
                     src="assets/img/g.png" alt="not">
            </div>

            <div class="col-lg-6 wow fadeInUp ps-lg-2" data-wow-delay="0.5s">
                <div>
                    <h1 class="display-6 mb-2">About Us</h1>
                    <p class="text-dark fs-5 mb-3">
                        We are a crypto intelligence and threat analysis platform designed to map, trace, 
                        and analyze Ethereum transaction networks. Our system focuses on uncovering hidden 
                        relationships between wallets through graph-based intelligence mapping.
                    </p>
                    <a class="btn btn-primary py-2 px-4" href="#">
                        Explore More
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>
    <!-- ========================= about-section end ========================= -->

        <%
            // Function to get user IP address
            String userIP = "Unknown";
            try {
                Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
                while (interfaces.hasMoreElements()) {
                    NetworkInterface iface = interfaces.nextElement();
                    Enumeration<InetAddress> addresses = iface.getInetAddresses();
                    while (addresses.hasMoreElements()) {
                        InetAddress addr = addresses.nextElement();
                        if (!addr.isLoopbackAddress() && addr instanceof Inet4Address) {
                            userIP = addr.getHostAddress();
                            break;
                        }
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            // Database connection
           

            try {
                String query = "SELECT 1 FROM block WHERE ip = ? LIMIT 1"; // check if IP exists
                PreparedStatement ps = db.connection.prepareStatement(query);
                ps.setString(1, userIP);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) { // If a record exists
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);

                    response.sendRedirect("IP_Block.jsp"); // redirect to block page
                }

                rs.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
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
    <!-- Footer End -->
 <%              }


} catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            } else {
                session.setAttribute("msg", "Session Out Please Login");
                response.sendRedirect("error.jsp");
            }
        %>

    <!-- Back to Top -->
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