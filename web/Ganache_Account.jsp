<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ganache Accounts</title>
    <script src="https://cdn.jsdelivr.net/npm/web3@1.10.0/dist/web3.min.js"></script>
</head>
<body>
    <h2>Select Ganache Account</h2>
    <select id="accountsDropdown">
        <option value="">Loading accounts...</option>
    </select>

    <script>
        async function loadGanacheAccounts() {
            // Connect to Ganache RPC
            const web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

            try {
                const accounts = await web3.eth.getAccounts();
                const dropdown = document.getElementById("accountsDropdown");
                dropdown.innerHTML = ""; // Clear old options

                accounts.forEach(acc => {
                    const option = document.createElement("option");
                    option.value = acc;
                    option.textContent = acc;
                    dropdown.appendChild(option);
                });
            } catch (err) {
                alert("Error fetching accounts: " + err);
            }
        }

        loadGanacheAccounts();
    </script>
</body>
</html>
