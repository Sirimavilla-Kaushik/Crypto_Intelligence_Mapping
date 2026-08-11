<%-- 
    Document   : User_Profile
    Created on : 29 Aug, 2025
--%>

<%@page import="java.sql.SQLException"%>
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
        String email = (String) session.getAttribute("Email");

        if (id != null && email != null) {
            try {
                Dbconnection db = new Dbconnection();
                ResultSet rs = db.Select("SELECT * FROM user_registration WHERE U_Id='" + id + "'");
                if (rs.next()) {
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
                <a href="Transaction_History.jsp" class="nav-item nav-link">History</a>
                <a href="Transaction_Graph.jsp" class="nav-item nav-link">Graph</a>
                <a href="Check_Transaction.jsp" class="nav-item nav-link">Spam Check</a>
                <a href="User_View_Blacklist.jsp" class="nav-item nav-link">View BlackList</a>
                <a href="User_Profile.jsp" class="nav-item nav-link active">Profile</a>
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
<!--  <h2 class="header-title">Edit Your Profile</h2>
<div class="formbold-main-wrapper">
    <div class="formbold-form-wrapper">
        <form action="UpdateUserProfile" method="POST">
            
             Hidden User ID 
            <input type="hidden" name="U_Id" value="<%=rs.getInt("U_Id")%>">

             User Name 
            <div class="formbold-mb-3">
                <div>
                    <label for="name" class="formbold-form-label">User Name:</label>
                    <input type="text" id="name" name="User_Name" 
                           value="<%=rs.getString("User_Name")%>" 
                           class="formbold-form-input" required>
                </div>
            </div>

             Email 
            <div class="formbold-mb-3">
                <div>
                    <label for="email" class="formbold-form-label">Email:</label>
                    <input type="email" id="email" name="Email" 
                           value="<%=rs.getString("Email")%>" 
                           class="formbold-form-input" readonly>
                </div>
            </div>

             Password 
            <div class="formbold-mb-3">
                <div>
                    <label for="password" class="formbold-form-label">Password:</label>
                    <input type="password" id="password" name="Password" 
                           value="<%=rs.getString("Password")%>" 
                           class="formbold-form-input" required>
                </div>
            </div>

             Address 
            <div class="formbold-mb-3">
                <div>
                    <label for="address" class="formbold-form-label">Address:</label>
                    <input type="text" id="address" name="Address" 
                           value="<%=rs.getString("Address")%>" 
                           class="formbold-form-input" required>
                </div>
            </div>

             Mobile Number 
            <div class="formbold-mb-3">
                <div>
                    <label for="mobile" class="formbold-form-label">Mobile Number:</label>
                    <input type="number" id="mobile" name="Mobile" 
                           value="<%=rs.getString("Mobile_Number")%>" 
                           class="formbold-form-input" required>
                </div>
            </div>

             Submit Button 
            <button type="submit" class="formbold-btn">Update Profile</button>
        </form>
    </div>
</div>-->

<!-- Display User Details in Read-Only Mode -->
<div class="formbold-main-wrapper" id="profileView">
    <h2 class="header-title">Your Profile</h2>
    <div class="formbold-form-wrapper">
        <p><strong>User Name:</strong> <%=rs.getString("User_Name")%></p>
        <p><strong>Email:</strong> <%=rs.getString("Email")%></p>
        <p><strong>Password:</strong> ******</p>
        <p><strong>Address:</strong> <%=rs.getString("Address")%></p>
        <p><strong>Mobile Number:</strong> <%=rs.getString("Mobile_Number")%></p>
        <button class="formbold-btn" onclick="showEditForm()">Edit Profile</button>
    </div>
</div>

<!-- Edit Form (Initially Hidden) -->
<div class="formbold-main-wrapper" id="editForm" style="display:none;">
    <h2 class="header-title">Edit Your Profile</h2>
    <div class="formbold-form-wrapper">
        <form action="UpdateUserProfile" method="POST">
            <input type="hidden" name="U_Id" value="<%=rs.getInt("U_Id")%>">

            <div class="formbold-mb-3">
                <label for="name" class="formbold-form-label">User Name:</label>
                <input type="text" id="name" name="User_Name" value="<%=rs.getString("User_Name")%>" class="formbold-form-input" required>
            </div>

            <div class="formbold-mb-3">
                <label for="email" class="formbold-form-label">Email:</label>
                <input type="email" id="email" name="Email" value="<%=rs.getString("Email")%>" class="formbold-form-input" readonly>
            </div>

            <div class="formbold-mb-3">
                <label for="password" class="formbold-form-label">Password:</label>
                <input type="password" id="password" name="Password" value="<%=rs.getString("Password")%>" class="formbold-form-input" required>
            </div>

            <div class="formbold-mb-3">
                <label for="address" class="formbold-form-label">Address:</label>
                <input type="text" id="address" name="Address" value="<%=rs.getString("Address")%>" class="formbold-form-input" required>
            </div>

            <div class="formbold-mb-3">
                <label for="mobile" class="formbold-form-label">Mobile Number:</label>
                <input type="number" id="mobile" name="Mobile" value="<%=rs.getString("Mobile_Number")%>" class="formbold-form-input" required>
            </div>

            <button type="submit" class="formbold-btn">Update Profile</button>
            <button type="button" class="formbold-btn" style="background:#aaa;margin-top:10px;" onclick="cancelEdit()">Cancel</button>
        </form>
    </div>
</div>

<script>
    function showEditForm() {
        document.getElementById('profileView').style.display = 'none';
        document.getElementById('editForm').style.display = 'block';
    }

    function cancelEdit() {
        document.getElementById('editForm').style.display = 'none';
        document.getElementById('profileView').style.display = 'block';
    }
</script>
               
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