<%@page import="java.sql.SQLException"%>
<%@page import="model.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.Database"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Happy Society - Notifications</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-theme.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="assets/js/jquery.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

    <!-- Script file for messaging -->
    <script src="assets/js/notifications.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>
    
</head>
<body id="main-page">
<div id="home-page">
    <div class="container-fluid">
        <header>
            <div class="col-md-4 col-xs-12 home">
                <a href="Home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>&nbsp; Home</a>
            </div>
            <div class="col-md-4 col-xs-12 logo">
                <h1>Happy Society</h1>
            </div>
            <div class="col-md-4 col-xs-12 profile">
                <a href="Profile">Profile&nbsp; <span class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
            </div>
        </header>
  <%
      Connection con = Database.getConnection(request, response);
      
      User user = (User) request.getSession().getAttribute("loggedInUser");
      
      String loggedInUser = user.getId();
      
      try {
            String sql = "SELECT notifications.id,full_name,type FROM notifications INNER JOIN users ON users.id = notifications.sender_id WHERE recipient_id = ? AND status = 0 LIMIT 5";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, loggedInUser);

            ResultSet result = ps.executeQuery();
            String name = "",id = "",type="";

            if(result.next()) {
                name = result.getString("full_name");
                id = result.getString("id");
                type = result.getString("type");%>

        <div class="alert alert-info alert-dismissible" style="margin-top: 150px;" role="alert" id="<%=id%>">
            <button type="button" class="close" data-dismiss="alert" id="dismissBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
            </button>
            <%if(type.equals("brech")){%>
                <strong>User <%=name%> has downloaded your profile pic and tried to upload it. </strong>
                <%} else{%>
                <strong>User <span style="color: black"><%=name%></span> has made a request to download your profile pic. </strong>
                <button class="btn btn-link approvalBtn" id="accept<%=id%>"><span style="color: green" ><span class="glyphicon glyphicon-ok"></span></span></button>
                <button class="btn btn-link approvalBtn" id="reject<%=id%>"><span style="color: red" ><span class="glyphicon glyphicon-remove"></span></span></button>
                
        <%}%>
        </div>
            <%} else {%>
        <div class="alert alert-info alert-dismissible" style="margin-top: 150px;" role="alert">
                <strong>No new notifications </strong></a>
        </div>
            <%}

        } catch (Exception e) {
            e.printStackTrace();
        }%>
    </div>

</div>
</body>
</html>

