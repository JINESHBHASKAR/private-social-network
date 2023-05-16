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
    <title>Happy Society - Search People</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="assets/js/jquery.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

    <!-- Script file for messaging -->
    <script src="assets/js/messaging.js"></script>

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
                <!--<h2>Messaging possible only if both parties follow each other</h2>--><br/><br/>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="buddy">Select Messenger</label>
                    <div class="col-sm-3">
                        <select class="form-control" id="buddy"">
                            <option selected="true" disabled="disabled">Choose Your Buddy</option>
        <%
        Connection conn = Database.getConnection(request, response);
        
        User user = (User) request.getSession().getAttribute("loggedInUser");
        
        try {
            String query = "SELECT DISTINCT follows.user_id, full_name FROM follows INNER JOIN users ON users.id = follows.user_id\n"+ 
                    "WHERE follows.user_id IN (SELECT follows.user_id FROM follows WHERE follow_id = ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1,user.getId());
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                %>
                            <option value="<%=rst.getString("user_id")%>"><%=rst.getString("full_name") %></option>
                                <%
            }
        } catch (SQLException sqlExc) {
            sqlExc.printStackTrace();
        }%>
                        </select>
                    </div>
                </div> <hr/><hr/>
                        
            </div>
            <div class="container" id="conversation">
                
                
            </div>
        </div>
    </div>
</div>
</body>
</html>

