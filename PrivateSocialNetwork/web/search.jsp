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

    <!-- Script file for search -->
    <script src="assets/js/search.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>
    
</head>
<body id="main-page">
<div id="home-page">
    
    <div class="modal fade" id="show-profile" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" type="button">×</button>
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>	
    
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
                <h2>Search for people you know..</h2>
                    <div class="row">
                        <div class="col-sm-6" style="padding: 15px;">
                            <input type="text" class="form-control" id="searchName" placeholder="Enter Name"  name="searchName">
                        </div>
                        <div class="col-sm-6" style="padding: 15px;">
                            <a id="searchBtn" class="btn btn-primary">Search</a>
                        </div>
                    </div>
            </div>
            <div class="container" id="searchResults">
                
            </div>
        </div>
    </div>
</div>
</body>
</html>

