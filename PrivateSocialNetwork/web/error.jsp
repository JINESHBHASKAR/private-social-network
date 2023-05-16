<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Happy Society - Error</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>

<div class="container">
    <hgroup>
        <h1>Happy Society</h1>
        <h3>- Something Went Wrong -</h3>
    </hgroup>

    <article>
        <div class="alert alert-danger">
            <%
                String imageUrl = config.getInitParameter("imageUrl");
                String errorMessage = config.getInitParameter("errorMessage");
                out.println("<center><img src='" + imageUrl + "' alt='" + errorMessage + "'/>");
                out.println("<h1>Oops!...<br/>" + errorMessage + "</h1></center>");
            %>
        </div>
    </article>

    <div class="row">
        <p class="text-center">Copyright &copy; Happy Society - 2020. </p>
    </div>
</div>

</body>
</html>
