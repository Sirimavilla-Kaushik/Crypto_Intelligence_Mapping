<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Disable caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IP Blocked</title>
    <script>
        (function () {
            // Push state multiple times to "fill" history
            for (let i = 0; i < 55; i++) {
                history.pushState(null, "", location.href);
            }

            // Trap back button
            window.onpopstate = function () {
                history.pushState(null, "", location.href);
                alert("Your IP is blocked. You cannot go back.");
            };
        })();
    </script>
</head>
<body>
    <h1>Your IP Address is Blocked</h1>
    <p>You cannot access this website.</p>
</body>
</html>
