<%-- 
    Document   : MultiHopGraph
    Created on : 19-Jan-2026, 18:13:48
    Author     : user
--%>

<%@ page import="java.sql.*, java.util.*, connection.Dbconnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
     <meta http-equiv="x-ua-compatible" content="ie=edge">
    <!-- vis.js -->
    <script src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>
       
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
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #eef2f7;
            margin: 0;
        }

        .wrapper {
            width: 96%;
            margin: 25px auto;
        }

        .chart-container {
            background: #ffffff;
            padding: 20px 25px;
            border-radius: 14px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.15);
        }

       

        .subtitle {
            text-align: center;
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
        }

        #walletNetwork {
            height: 650px;
            border: 1px solid #ccc;
            border-radius: 10px;
        }

        .legend {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 15px;
            font-size: 13px;
        }

        .legend span {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
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
                        <a href="View_Graph.jsp" class="dropdown-item">Transaction Graph</a>
                        <a href="MultiHopGraph.jsp" class="dropdown-item active">Multi-Hop Graph</a>
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
<div class="wrapper">
    <div class="chart-container">
        <h2 style="text-align:center; margin: 20px;">Multi-Hop Wallet Transaction Flow</h2>

        <%
    Dbconnection db = new Dbconnection();
    ArrayList<String> nodes = new ArrayList<>();
    ArrayList<String[]> edges = new ArrayList<>();
    HashMap<String, Integer> txCount = new HashMap<>();

    ResultSet rs = db.Select(
        "SELECT Sender_Address, Receiver_Address FROM transactions ORDER BY Date_Time ASC"
    );

    while(rs.next()) {
        String sender = rs.getString("Sender_Address");
        String receiver = rs.getString("Receiver_Address");

        // count sender
        txCount.put(sender, txCount.getOrDefault(sender, 0) + 1);
        txCount.put(receiver, txCount.getOrDefault(receiver, 0) + 1);

        if(!nodes.contains(sender)) nodes.add(sender);
        if(!nodes.contains(receiver)) nodes.add(receiver);

        edges.add(new String[]{sender, receiver});
    }

    StringBuilder nodeJson = new StringBuilder("[");
    for(int i = 0; i < nodes.size(); i++) {
        String full = nodes.get(i);
        int count = txCount.get(full);

        String label = full.length() > 10
            ? full.substring(0,6)+"..."+full.substring(full.length()-4)
            : full;

        String bgColor = "#2ecc71"; 
        String borderColor = "#27ae60";

        if(count > 3){
            bgColor = "#e74c3c";      
            borderColor = "#c0392b";
        } else if(count > 2){
            bgColor = "#f39c12";      
            borderColor = "#e67e22";
        } else if(count > 1){
            bgColor = "#3498db";      
            borderColor = "#2980b9";
        }

        nodeJson.append("{")
                .append("id:'").append(full).append("',")
                .append("label:'").append(label).append("',")
                .append("title:'").append(full)
                .append(" | Transactions: ").append(count).append("',")
                .append("color:{background:'").append(bgColor)
                .append("', border:'").append(borderColor).append("'}")
                .append("}");

        if(i < nodes.size()-1) nodeJson.append(",");
    }
    nodeJson.append("]");

    StringBuilder edgeJson = new StringBuilder("[");
    for(int i=0;i<edges.size();i++){
        edgeJson.append("{from:'")
                .append(edges.get(i)[0])
                .append("', to:'")
                .append(edges.get(i)[1])
                .append("'}");
        if(i<edges.size()-1) edgeJson.append(",");
    }
    edgeJson.append("]");
%>


        <div id="walletNetwork" style="height:650px;"></div>

        <script src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>
        <script>
            const nodes = new vis.DataSet(<%=nodeJson.toString()%>);
            const edges = new vis.DataSet(<%=edgeJson.toString()%>);

            const container = document.getElementById("walletNetwork");
            const data = { nodes, edges };

            const options = {
                nodes: { shape:'dot', size:26, font:{size:13, face:'monospace'} },
                edges: { arrows:'to', smooth:true, color:{color:'#888'} },
                physics: { enabled:true, barnesHut:{gravitationalConstant:-3000, springLength:140, springConstant:0.04} },
                interaction: { hover:true, zoomView:true, dragView:true }
            };

            const network = new vis.Network(container, data, options);
        </script>

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
