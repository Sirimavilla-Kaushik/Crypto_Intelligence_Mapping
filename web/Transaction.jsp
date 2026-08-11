<%@page import="java.sql.ResultSet"%>
<%@page import="connection.Dbconnection"%>
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
      
        <script src="https://cdn.jsdelivr.net/npm/web3@1.10.0/dist/web3.min.js"></script>
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
                <a href="Transaction.jsp" class="nav-item nav-link active">Transaction</a>
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


        
        <%
            Integer id = (Integer) session.getAttribute("id");
            String name = (String) session.getAttribute("Email");

            if (id != null && name != null) {
                try {
                    Dbconnection db = new Dbconnection();
                    ResultSet userResult = db.Select("SELECT * FROM user_registration WHERE U_Id='" + id + "' AND Email='" + name + "'");
                    if (userResult.next()) {
                        String userName = userResult.getString("User_Name");
                        String Mobile_Number = userResult.getString("Mobile_Number");

        %>

        <h2 class="header-title">Send Transaction</h2>

<div class="formbold-main-wrapper">
    <div class="formbold-form-wrapper">
        <form id="txnForm" action="Transaction" method="POST">

            <!-- Hidden User Id -->
            <input type="hidden" name="User_Id" value="<%=id%>" readonly />

            <!-- User Name -->
            <div class="formbold-mb-3">
                <label for="username" class="formbold-form-label">User Name:</label>
                <input type="text" id="username" name="Username" 
                       value="<%=userName%>" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Email -->
            <div class="formbold-mb-3">
                <label for="email" class="formbold-form-label">Email:</label>
                <input type="email" id="email" name="Email" 
                       value="<%=name%>" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Contact -->
            <div class="formbold-mb-3">
                <label for="contact" class="formbold-form-label">Contact Number:</label>
                <input type="tel" id="contact" name="Contact" 
                       value="<%=Mobile_Number%>" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Sender -->
            <div class="formbold-mb-3">
                <label for="sender" class="formbold-form-label">Sender (from MetaMask):</label>
                <input type="text" id="sender" name="sender" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Receiver -->
            <div class="formbold-mb-3">
                <label for="accountsDropdown" class="formbold-form-label">Receiver (Ganache Accounts):</label>
                <select id="accountsDropdown" name="receiver" class="formbold-form-input" required>
                    <option value="">Loading accounts...</option>
                </select>
            </div>

            <!-- USD Amount -->
            <div class="formbold-mb-3">
                <label for="usdAmount" class="formbold-form-label">Amount in USD:</label>
                <input type="number" id="usdAmount" name="usdAmount" step="0.01" 
                       placeholder="e.g., 100.00" 
                       class="formbold-form-input" required />
            </div>

            <!-- Equivalent ETH -->
            <div class="formbold-mb-3">
                <label for="ethAmount" class="formbold-form-label">Equivalent ETH:</label>
                <input type="text" id="ethAmount" name="ethAmount" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Gas Fee -->
            <div class="formbold-mb-3">
                <label for="gasFee" class="formbold-form-label">Gas Fee (Estimated in ETH):</label>
                <input type="text" id="gasFee" name="gasFee" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Purpose -->
            <div class="formbold-mb-3">
                <label for="purpose" class="formbold-form-label">Transaction Purpose:</label>
                <textarea id="purpose" name="purpose" rows="2" 
                          class="formbold-form-input"></textarea>
            </div>

            <!-- Date & Time -->
            <div class="formbold-mb-3">
                <label for="txnDateTime" class="formbold-form-label">Transaction Date & Time:</label>
                <input type="text" id="txnDateTime" name="DateTime" 
                       class="formbold-form-input" readonly />
            </div>

            <!-- Hidden field for TxHash -->
            <input type="hidden" id="txnHash" name="TxnHash" />

            <!-- Buttons -->
            <div class="formbold-mb-3">
                <button type="button" class="formbold-btn mb-10" onclick="sendTransaction()">Send Transaction</button><br><br>
                <button type="reset" class="formbold-btn">Clear</button>
            </div>
        </form>
    </div>
</div>


        <!-- Status div for feedback -->
        <div id="status"></div>

        <script>
    let web3;
    const USD_PER_ETH = 4074.8558; // Example fixed rate, replace with API later

    async function init() {
        if (window.ethereum) {
            web3 = new Web3(window.ethereum);
            try {
                const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
                document.getElementById("sender").value = accounts[0];
            } catch (err) {
                alert("User denied MetaMask access");
            }
        } else {
            alert("MetaMask not installed!");
        }
        

        // Load Ganache accounts
        const ganacheWeb3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
        try {
            const accounts = await ganacheWeb3.eth.getAccounts();
            const dropdown = document.getElementById("accountsDropdown");
            dropdown.innerHTML = "";
            accounts.forEach(acc => {
                const option = document.createElement("option");
                option.value = acc;
                option.textContent = acc;
                dropdown.appendChild(option);
            });
        } catch (err) {
            alert("Error fetching Ganache accounts: " + err);
        }
    }

    // Auto calculate ETH and gas fee when USD is entered
    document.getElementById("usdAmount").addEventListener("input", () => {
        const usdAmount = parseFloat(document.getElementById("usdAmount").value);
        if (!isNaN(usdAmount) && usdAmount > 0) {
            const ethAmount = usdAmount / USD_PER_ETH;
            document.getElementById("ethAmount").value = ethAmount.toFixed(6);

            // Gas fee (rough estimate)
            const gasFee = 21000 * 10e-9; // ~0.00021 ETH (simplified)
            document.getElementById("gasFee").value = gasFee.toFixed(6);
        } else {
            document.getElementById("ethAmount").value = "";
            document.getElementById("gasFee").value = "";
        }
    });

   async function sendTransaction() {
    const userId = document.querySelector("input[name='User_Id']").value;
    const sender = document.getElementById("sender").value;
    
    const receiver = document.getElementById("accountsDropdown").value;
    const usdAmount = parseFloat(document.getElementById("usdAmount").value);

    if (!receiver || isNaN(usdAmount) || usdAmount <= 0) {
        alert("Receiver and valid USD amount are required");
        return;
    }
    
  

    // ? Step 1: Check backend if user is flagged
    let check = await fetch("CheckFlagServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "User_Id=" + encodeURIComponent(userId)
    });
    let status = await check.text();

    if (status === "FLAGGED") {
        document.getElementById("status").innerHTML =
            "? User flagged as phishing. Transaction blocked.";
        return; // ? STOP ? do not call MetaMask
    }

    // ? Step 2: Only safe users reach MetaMask
    try {
        const ethAmount = usdAmount / USD_PER_ETH;
        const weiValue = web3.utils.toWei(ethAmount.toString(), "ether");

        const balanceWei = await web3.eth.getBalance(sender);
        const balanceEth = parseFloat(web3.utils.fromWei(balanceWei, "ether"));
        if (ethAmount > balanceEth) {
            alert("Insufficient ETH balance");
            return;
        }

        const txHash = await ethereum.request({
            method: 'eth_sendTransaction',
            params: [{
                from: sender,
                to: receiver,
                value: web3.utils.toHex(weiValue)
            }]
        });

        document.getElementById("status").innerHTML =
            "? Transaction sent! Tx Hash: " + txHash;
        document.getElementById("txnHash").value = txHash;
        document.getElementById("txnDateTime").value = getCurrentDateTime();

        // Confirmation + form submission
        let receipt = null;
        while (receipt === null) {
            receipt = await web3.eth.getTransactionReceipt(txHash);
            await new Promise(r => setTimeout(r, 2000));
        }

        // Append block number
        let blockInput = document.createElement("input");
        blockInput.type = "hidden";
        blockInput.name = "blockNumber";
        blockInput.value = receipt.blockNumber;
        document.getElementById("txnForm").appendChild(blockInput);

        document.getElementById("txnForm").submit();

 


        } catch (err) {
            console.error("Transaction Error:", err);
            document.getElementById("status").innerText = "? Error: " + err.message;
        }
    }

    function getCurrentDateTime() {
        const now = new Date();
        return now.getFullYear() + "-" +
            String(now.getMonth() + 1).padStart(2, '0') + "-" +
            String(now.getDate()).padStart(2, '0') + " " +
            String(now.getHours()).padStart(2, '0') + ":" +
            String(now.getMinutes()).padStart(2, '0') + ":" +
            String(now.getSeconds()).padStart(2, '0');
    }

    // ? Init and set current time
    window.addEventListener("load", () => {
        init();
        document.getElementById("txnDateTime").value = getCurrentDateTime();
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