<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Happy Society - Home</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="assets/js/jquery.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->
    

    <!-- Script file to manipulate users posts. -->
    <script src="assets/js/homeposts.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>
</head>
<body id="main-page">
<div id="home-page">
    <div class="modal fade" id="show-profilepic" tabindex="-1">
    <div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button class="close" data-dismiss="modal" type=
			"button">×</button>
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
                <div class="row">
                    <aside class="col-md-2 sidebar-outer">
                        <div class="sidebar">
                            <div class="info">
                                <a href="Profile">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/user.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>${loggedInUser.fullName}</p>
                                        </div>
                                    </div>
                                </a>
                                <a href="messaging.jsp">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/messages.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Messages</p>
                                        </div>
                                    </div>
                                </a>     
                                <a href="notifications.jsp">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/notification.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Notifications</p>
                                        </div>
                                    </div>
                                </a>           
                                <a href="search.jsp">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/search.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Find People</p>
                                        </div>
                                    </div>
                                </a> 
                                <a href="following.jsp">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/FOLLOWING.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Following</p>
                                        </div>
                                    </div>
                                </a>         
                                <a href="followers.jsp">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/FOLLOWERS.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Followers</p>
                                        </div>
                                    </div>
                                </a>
                                
                                <a href="Logout">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/logout.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Logout</p>
                                        </div>
                                    </div>
                                </a>        
                            </div>
                        </div>
                    </aside>
                    <section class="col-md-10 col-md-offset-2">
                        <div class="newPost" id="statusUpdate">
                            <form method="POST" enctype="multipart/form-data" id="postForm">
                                <p><em>Share your thoughts with others...</em></p>
                                <textarea id="postcontent" name="postcontent" rows="5" placeholder="whats on ur mind ??"></textarea> 
                                <input type="file" id="postImage" name="postImage" class="fileinput-new" style="padding:5px;"/>
                                <input type="submit" id="btnSubmit" value="Post" class="btn btn-primary">
                            </form>
                        </div>
                        <div id="allposts">
                            <c:forEach var="singlePost" items="${requestScope.posts}">
                                <div class="posts" id="post${singlePost.id}">
                                    <div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <a data-target="#show-profilepic" data-toggle="modal" href="" id="${singlePost.userId}">
                                                    <img src="profiles&#92;${singlePost.postedByPic}">
                                                </a>
                                            </div>
                                            <div class="username">
                                                <p id="userName">${singlePost.postedBy}</p>
                                                <div class="postTime">
                                                    <p>Posted on ${singlePost.dateTime}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="userPost">
                                            <p>${singlePost.content}</p>
                                            <div class="postImage">
                                                <a data-target="#update-profilepic" data-toggle="modal" href="">
                                                    <img src="posts&#92;${singlePost.image}" alt="">
                                                </a>
                                            </div>
                                        </div>
                                        <hr/>
                                        <div class="footer">

                                            <c:choose>
                                                <c:when test="${singlePost.likedByMe.equalsIgnoreCase('true')}">
                                                    <a id="${singlePost.id}" class="likeBtn redcolor"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Unlike</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge${singlePost.id}">${singlePost.totalLikes}</span></a>&nbsp;
                                                </c:when>
                                                <c:otherwise>
                                                    <a id="${singlePost.id}" class="likeBtn"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Like</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge${singlePost.id}">${singlePost.totalLikes}</span></a>&nbsp;
                                                </c:otherwise>
                                            </c:choose>

                                            <a name="${singlePost.id}" class="viewshowcomments"><span
                                                    class="glyphicon glyphicon-comment"
                                                    aria-hidden="true"></span>
                                                Comment</a>
                                        </div>
                                        <div class="comments hidden" id="comments${singlePost.id}">

                                            <div id="commentsBox${singlePost.id}">

                                            </div>

                                            <div id="addComment">

                                                <img src="profiles&#92;${singlePost.postedByPic}" class="userProfileImage">
                                                <textarea rows="2" cols="50" id="commentText${singlePost.id}"
                                                          class="comment"
                                                          placeholder=""></textarea><a
                                                    name="${singlePost.id}"
                                                    class="btn btn-primary postComment">Comment</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>

                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>