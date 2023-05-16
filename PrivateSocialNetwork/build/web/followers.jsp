<%@page import="java.sql.ResultSet"%>
<%@page import="model.User"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.Database"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Happy Society - Search People</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="assets/js/jquery.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

    <!--Google Map Api--->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCd-ipzIa-0P6g9jycRCEfwPIXttyC5024"
            async defer></script>

    <!-- Script file to manipulate users posts. -->
    <script src="assets/js/homeposts.js"></script>

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
        <div id="content">
<div class="container">
  <h2>People Following You..</h2>
  <div class="container-fluid">
  <%
      Connection con = Database.getConnection(request, response);
      
      User user = (User) request.getSession().getAttribute("loggedInUser");
      
      String loggedInUser = user.getId();
      
      try {
            String sql = "SELECT full_name FROM follows INNER JOIN users ON users.id = follows.user_id WHERE follows.follow_id = ? LIMIT 10";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, loggedInUser);

            ResultSet result = ps.executeQuery();
            String name = "";

            while(result.next()) {
                name = result.getString("full_name");%>
                <div class="row">
                    <div class="col-sm-12" style="padding: 35px;">
                        <h3><%=name%></h3>
                    </div>
                    
                </div>
            <%}

        } catch (Exception e) {
            e.printStackTrace();
        }
      

      %>
  </div>
</div>
        </div>
    </div>
        </div>
    </body>
</html>

