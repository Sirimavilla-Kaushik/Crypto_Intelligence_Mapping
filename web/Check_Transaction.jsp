<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
    <style>
    .wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 50vh;   /* full screen height */
      background: #f4f6f9;
    }
    .card {
      background: #fff;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 500px;
      text-align: center;
      margin: 40px;
    }

    h2 {
      margin-bottom: 20px;
      color: #333;
    }

    input[type="text"] {
      width: 100%;
      padding: 12px 15px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 16px;
      transition: all 0.3s ease;
    }

    input[type="text"]:focus {
      border-color: #007bff;
      outline: none;
      box-shadow: 0 0 5px rgba(0,123,255,0.3);
    }

    button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 25px;
      background: #007bff;
      color: white;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    button:hover {
      background: #0056b3;
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
    /* ===== Risk Result Messages ===== */
.safe,
.moderate,
.unsafe {
    max-width: 600px;
    margin: 20px auto;
    padding: 14px 18px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    box-shadow: 0 8px 18px rgba(0,0,0,0.12);
    animation: fadeIn 0.6s ease-in-out;
}

/* SAFE - Green */
.safe {
    background: rgba(76, 175, 80, 0.15);
    color: #2e7d32;
    border-left: 6px solid #4caf50;
}

/* MODERATE - Orange */
.moderate {
    background: rgba(255, 152, 0, 0.18);
    color: #e65100;
    border-left: 6px solid #ff9800;
}

/* UNSAFE - Red */
.unsafe {
    background: rgba(244, 67, 54, 0.18);
    color: #b71c1c;
    border-left: 6px solid #f44336;
}

/* Fade animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

    </style>
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
                <a href="Transaction_History.jsp" class="nav-item nav-link">History</a>
                <a href="Transaction_Graph.jsp" class="nav-item nav-link">Graph</a>
                <a href="Check_Transaction.jsp" class="nav-item nav-link active">Spam Check</a>
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

        <div class="wrapper">
 <div class="card">
    <h2>Wallet Safety Check</h2>
    <form method="post">
      <input type="text" name="address" placeholder="Enter Ethereum Address" required />
      <button type="submit">Check</button>
    </form>
  </div>
              </div>

    <%
        String address = request.getParameter("address");
        if (address != null && !address.trim().isEmpty()) {
            try (Connection con = new Dbconnection().getConnection()) {
                String query = "SELECT Risk_Score FROM transactions WHERE Sender_Address=? ORDER BY T_Id DESC LIMIT 1";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, address);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    int score = rs.getInt("Risk_Score");

                    if (score < 50) {
                        out.println("<p class='safe'> Address is SAFE (Risk Score: " + score + ")</p>");
                    } else if (score >= 50 && score < 75) {
                        out.println("<p class='moderate'> Address is MODERATE RISK (Risk Score: " + score + ")</p>");
                    } else if (score >= 100) {
                        out.println("<p class='unsafe'>Address is NOT SAFE (Risk Score: " + score + ")</p>");
                    } else {
                        out.println("<p class='moderate'> Address is in RISK ZONE (Risk Score: " + score + ")</p>");
                    }
                } else {
                    out.println("<p>No transaction history found for this address.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            }
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