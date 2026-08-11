<%-- 
    Document   : View_Graph
    Created on : 11-Oct-2025, 10:40:08
    Author     : user
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="connection.Dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crypto Analysis</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    .chart-container {
        width: 85%;
        max-width: 1000px;
        margin: 40px auto;
        background: linear-gradient(135deg, #ffffff 0%, #f5f7fa 100%);
        padding: 25px 30px;
        border-radius: 18px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        transition: all 0.3s ease-in-out;
    }

    .chart-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    }
    canvas {
        width: 100% !important;
        height: 450px !important;
    }
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

</head>
<body>    
    
     <div id="spinner"
     class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<%
    try {
        Dbconnection db = new Dbconnection();

        ArrayList<String> labels = new ArrayList<String>();
        ArrayList<Integer> counts = new ArrayList<Integer>();

        // 🔥 Only flagged transactions
        ResultSet graphRs = db.Select(
            "SELECT DATE(Date_Time) as TxDate, COUNT(*) as TxCount " +
            "FROM transactions " +
            "WHERE Flagged = 1 " +
            "GROUP BY DATE(Date_Time) ORDER BY DATE(Date_Time) ASC"
        );

        while (graphRs.next()) {
            labels.add(graphRs.getString("TxDate"));
            counts.add(graphRs.getInt("TxCount"));
        }

        // Convert to JSON arrays
        StringBuilder labelJson = new StringBuilder("[");
        for (int i = 0; i < labels.size(); i++) {
            labelJson.append("\"").append(labels.get(i)).append("\"");
            if (i < labels.size() - 1) labelJson.append(",");
        }
        labelJson.append("]");

        StringBuilder countJson = new StringBuilder("[");
        for (int i = 0; i < counts.size(); i++) {
            countJson.append(counts.get(i));
            if (i < counts.size() - 1) countJson.append(",");
        }
        countJson.append("]");
%>   
 
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
                <a href="User_Approval.jsp" class="nav-item nav-link">User Approval</a>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">List</a>
                    <div class="dropdown-menu shadow-sm m-0">
                        <a href="Transaction_List.jsp" class="dropdown-item">Transaction List</a>
                        <a href="View_Blacklist.jsp" class="dropdown-item">BlackList Transaction</a>
                    </div>
                </div>
                  <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Graph</a>
                    <div class="dropdown-menu shadow-sm m-0">
                        <a href="View_Graph.jsp" class="dropdown-item active">Transaction Graph</a>
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


<h2 style="text-align:center; margin: 20px;">Flagged Transaction Graph</h2>
<div class="chart-container">
    <canvas id="transactionChart"></canvas>
</div>      

   
<script>
    const labels = <%=labelJson.toString()%>;
    const data = <%=countJson.toString()%>;

    new Chart(document.getElementById('transactionChart'), {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Flagged Transactions',
            data: data,
            backgroundColor: 'rgba(255, 0, 0, 0.5)',
            borderColor: '#FF0000',
            borderWidth: 2,
            borderRadius: 6, // Rounded bar edges
            barPercentage: 0.6, // Controls bar thickness (1 = full width, smaller = thinner)
            categoryPercentage: 0.7 // Controls spacing between bars
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false, // Allows full height usage
        plugins: {
            legend: { display: true },
            title: { display: true, text: 'Flagged Transactions Over Time' }
        },
        scales: {
            x: {
                title: { display: true, text: 'Date' },
                ticks: { font: { size: 14 } },
                grid: { color: '#ddd' }
            },
            y: {
                title: { display: true, text: 'Number of Transactions' },
                beginAtZero: true,
                ticks: { font: { size: 14 } },
                grid: { color: '#eee' }
            }
        }
    }
});

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

     
        <%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
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
