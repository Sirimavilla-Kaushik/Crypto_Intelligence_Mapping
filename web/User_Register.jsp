<%-- 
    Document   : User_Register
    Created on : 20 Aug, 2025, 3:54:15 PM
    
--%>


<%@page import="java.net.InetAddress"%>
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
        
        <script src="https://api.tomtom.com/maps-sdk-for-web/cdn/5.x/5.64.0/services/services-web.min.js"></script>
    <script src="js/location.js"></script>  
    </head>
    <body>
       
        <!-- Spinner Start -->
<div id="spinner"
     class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
    <!-- Spinner End -->

    <style>
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
    <!-- Navbar Start -->
    <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 px-4 px-lg-5">
        <a href="index1.jsp" class="navbar-brand d-flex align-items-center">
            <h2 class="m-0 text-primary">Crypto Analysis</h2>
        </a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-4 py-lg-0">
                <a href="index.jsp" class="nav-item nav-link">Home</a>
                <a href="User_Register.jsp" class="nav-item nav-link active">User Register</a>
                <a href="User_Login.jsp" class="nav-item nav-link">User Login</a>
                <a href="Threat_Analysis_Log.jsp" class="nav-item nav-link">Threat Analysis</a>
                 <a href="Admin_Log.jsp" class="nav-item nav-link">Admin Login</a>
            </div>
        </div>
    </nav>
    <!-- Navbar End -->


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


    
        <h2 class="header-title">USER REGISTER</h2>
        <div class="formbold-main-wrapper">
            <div class="formbold-form-wrapper">
                <form action="User_Register" method="POST" enctype="multipart/form-data">
                    <!-- User Name -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="name" class="formbold-form-label">User Name:</label>
                            <input type="text" id="name" name="User_Name" placeholder="Enter your name" class="formbold-form-input" required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="email" class="formbold-form-label">Email:</label>
                            <input type="email" id="email" name="Email" placeholder="Enter your email" class="formbold-form-input" required>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="password" class="formbold-form-label">Password:</label>
                            <input type="password" id="password" name="Password" placeholder="Enter your password" class="formbold-form-input" required>
                        </div>
                    </div>

                    <!-- Contact Number -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="contact" class="formbold-form-label">Contact Number:</label>
                            <input type="text" id="contact" name="Contact" placeholder="Enter your contact number" class="formbold-form-input" required>
                        </div>
                    </div>
                    
                    <div class="formbold-mb-3">
                    <label for="gender" class="formbold-form-label">Gender:</label>
                    <select id="gender" name="Gender" class="formbold-form-input" required>
                        <option value="" disabled selected>Select your gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                    <!-- State -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="state" class="formbold-form-label">State:</label>
                            <input type="text" id="state" name="State" placeholder="Enter your State" class="formbold-form-input" required>
                        </div>
                    </div>

                    <!-- City -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="city" class="formbold-form-label">City:</label>
                            <input type="text" id="city" name="City" placeholder="Enter your City" class="formbold-form-input" required>
                        </div>
                    </div>

                    <!-- Address -->
                    <div class="formbold-mb-3">
                        <div>
                                <label for="firstname" class="formbold-form-label"> Address</label>
                                <input type="text" value="" name="address" id="loc1"  placeholder="Enter your Address" class="formbold-form-input" required />
                            </div>
                    </div>
                    <input type="hidden" name="lat" id="lat" />
                    <input type="hidden" name="long" id="lan"/>
                    
                     <div class="formbold-mb-3">
                        <div>
                            <label for="city" class="formbold-form-label">Ip Address:</label>
                           <input type="text" class="form-control" name="ipaddress"  id="firstname" placeholder="ipaddress" class="formbold-form-input" value="<%=InetAddress.getLocalHost().getHostAddress() %>" readonly><br>
                        </div>
                    </div>
                    <!-- Profile Picture -->
                    <div class="formbold-mb-3">
                        <div>
                            <label for="profile" class="formbold-form-label">Profile Picture:</label>
                            <input type="file" id="profile" name="image" class="formbold-form-file">
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="formbold-btn">Create Account</button>
                </form>
            </div>
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
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i
            class="bi bi-arrow-up"></i></a>

        <!-- ========================= JS here ========================= -->
      <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/lib/wow/wow.min.js"></script>
    <script src="assets/lib/easing/easing.min.js"></script>
    <script src="assetslib/waypoints/waypoints.min.js"></script>
    <script src="assets/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="assets/lib/counterup/counterup.min.js"></script>
    <script src="assets/js/main.js"></script>
        
        
                         <script  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBOU-GKNx-YL5o-b8cvlqgyn0rso6iQtUk&callback=showlocation"
  type="text/javascript"></script>   
    </body>
</html>

