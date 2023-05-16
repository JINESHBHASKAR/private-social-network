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
    <title>Happy Society - Profile</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="assets/js/jquery.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

    <!-- Script file to manipulate users posts. -->
    <script src="assets/js/profileposts.js"></script>

    <!-- Profile Page Script Codes -->
    <script src="assets/js/profile.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>
    
    
</head>
<body id="profile-page">

<div class="modal fade" id="edit-profile" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="closeButton"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Profile</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="edit-Profile-form">
                    <div class="form-group">
                        <label for="edit-fullname" class="col-sm-2 control-label">Full Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit-fullname"
                                   placeholder="Full Name" value="${loggedInUser.fullName}" tabindex="1" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="edit-email"
                                   placeholder="Email" value="${loggedInUser.email}" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-password" class="col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="edit-password"
                                   placeholder="Password" value="${loggedInUser.password}" disabled>
                        </div>
                    </div>
                    <div class="form-group form-inline">
                        <label for="edit-state" class="col-sm-2 control-label">State</label>
                        <div class="col-sm-10">
                            <select id="edit-state" class="form-control" tabindex="2"
                                    name="register-state">
                                <option value="${loggedInUser.state}" selected="true" disabled="disabled">${loggedInUser.state}</option>
                                <option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
                                <option value="Andhra Pradesh">Andhra Pradesh</option>
                                <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                                <option value="Assam">Assam</option>
                                <option value="Bihar">Bihar</option>
                                <option value="Chandigarh">Chandigarh</option>
                                <option value="Chhattisgarh">Chhattisgarh</option>
                                <option value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</option>
                                <option value="Daman and Diu">Daman and Diu</option>
                                <option value="Delhi">Delhi</option>
                                <option value="Goa">Goa</option>
                                <option value="Gujarat">Gujarat</option>
                                <option value="Haryana">Haryana</option>
                                <option value="Himachal Pradesh">Himachal Pradesh</option>
                                <option value="Jammu and Kashmir">Jammu and Kashmir</option>
                                <option value="Jharkhand">Jharkhand</option>
                                <option value="Karnataka">Karnataka</option>
                                <option value="Kerala">Kerala</option>
                                <option value="Lakshadweep">Lakshadweep</option>
                                <option value="Madhya Pradesh">Madhya Pradesh</option>
                                <option value="Maharashtra">Maharashtra</option>
                                <option value="Manipur">Manipur</option>
                                <option value="Meghalaya">Meghalaya</option>
                                <option value="Mizoram">Mizoram</option>
                                <option value="Nagaland">Nagaland</option>
                                <option value="Orissa">Orissa</option>
                                <option value="Pondicherry">Pondicherry</option>
                                <option value="Punjab">Punjab</option>
                                <option value="Rajasthan">Rajasthan</option>
                                <option value="Sikkim">Sikkim</option>
                                <option value="Tamil Nadu">Tamil Nadu</option>
                                <option value="Tripura">Tripura</option>
                                <option value="Uttaranchal">Uttaranchal</option>
                                <option value="Uttar Pradesh">Uttar Pradesh</option>
                                <option value="West Bengal">West Bengal</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-city" class="col-sm-2 control-label">City</label>
                        <div class="col-sm-10">
                            <input type="text" name="register-city" id="edit-city" tabindex="3"
                                   class="form-control" placeholder="City" value="${loggedInUser.city}" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-street" class="col-sm-2 control-label">Street</label>
                        <div class="col-sm-10">
                            <input type="text" name="register-street" id="edit-street" tabindex="4"
                                   class="form-control" placeholder="Street" value="${loggedInUser.street}" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-pincode" class="col-sm-2 control-label">Pin Code</label>
                        <div class="col-sm-10">
                            <input type="text" name="register-pincode" id="edit-pincode" tabindex="5"
                                   class="form-control" placeholder="Pin Code" value="${loggedInUser.pinCode}"
                                   pattern="[0-9]{6}" title="PIN Code should be 6 digits" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-birth-year" class="col-sm-2 control-label">Birth Year</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit-birth-year"
                                   placeholder="YYYY" pattern="[0-9]{4}"
                                   title="Enter your 4 digit birth year" tabindex="5" value="${loggedInUser.birthYear}"
                                   required>
                        </div>
                    </div> 
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" form="edit-Profile-form">Update</button>
            </div>
        </div>
    </div>
</div>
                                   

<div class="modal fade" id="update-profilepic" tabindex="-1">
    <div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button class="close" data-dismiss="modal" type=
			"button">×</button>
 
			<h4 class="modal-title" id="myModalLabel">Choose Your best
			picture for your Profile.</h4>
		</div>
 
		<form method="POST" enctype="multipart/form-data" id="updateProfilePic">
			<div class="modal-body">
				<div class="form-group">
					<div class="rows">
						<div class="col-md-12">
							<div class="rows">
								<div class="col-md-8">
									<input id=
									"upload_file" name="upload_file" type=
									"file">
								</div>
 
								<div class="col-md-4"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
 
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" type=
				"button">Close</button> <button class="btn btn-primary"
				name="savephoto" type="submit" form="updateProfilePic">Save Photo</button>
			</div>
		</form>
	</div>
    </div>
</div>	                                   

<div id="profile">
    <div class="container">
        <div class="row">
            <header>
                <div class="col-md-12 col-xs-12 back">
                    <a href="Home"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span></a>
                    <p>@<span>${loggedInUser.fullName}</span></p>


                </div>
            </header>
            <div id="profileInfo">
                <div class="col-md-12 col-xs-12">
                    <div class="profileImage">
                        <a data-target="#update-profilepic" data-toggle="modal" href="">
                            <img src="profiles&#92;${loggedInUser.profilePic}">
                        </a>
                        <p id="profileName" class="prof-pic">${loggedInUser.fullName}</p>
                    </div>
                    
                </div>
                    
            </div>
            <div class="col-md-4 col-xs-4" id="profilePageInfo">
                <div class="panel panel-primary">
                    <div class="panel-body bg-success">
                        <h3>
                            ${loggedInUser.fullName}
                            <button class="pull-right btn-sm btn-link" data-toggle="modal"
                                    data-target="#edit-profile"><span
                                    class="glyphicon glyphicon-edit" aria-hidden="true"></span> &nbsp;Edit
                            </button>
                        </h3>
                    </div>
                    <ul class="list-group">
                        <li class="list-group-item list-group-item-info">Address: ${loggedInUser.address}</li>
                        <li class="list-group-item list-group-item-warning">Gender: ${loggedInUser.gender}</li>
                        <li class="list-group-item list-group-item-danger">Birth Year: ${loggedInUser.birthYear} A.D.
                        </li>
                        <li class="list-group-item list-group-item-info">Email: ${loggedInUser.email}</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-8 col-xs-8">
                <div class="newPost" id="statusUpdate">
                    <form method="POST" enctype="multipart/form-data" id="postForm">
                            <p><em>Share your thoughts with others...</em></p>
                            <textarea id="postcontent" name="postcontent" rows="5" placeholder="whats on ur mind ??"></textarea> 
                            <input type="file" id="postImage" name="postImage" style="padding:5px;"/>
                            <input type="submit" id="btnSubmit" value="Post" class="btn btn-primary">
                    </form>
                </div>

                <div id="allposts">

                    <c:forEach var="singlePost" items="${requestScope.posts}">
                        <div class="posts" id="completePost${singlePost.id}">
                            <div class="box">
                                <div class="header">
                                    <div class="userProfileImage">
                                        <img src="profiles&#92;${singlePost.postedByPic}">

                                    </div>
                                    <div class="username">
                                        <p id="userName">${singlePost.postedBy}</p>
                                        <div class="postTime">
                                            <p>Posted on ${singlePost.dateTime} </p>
                                        </div>

                                    </div>
                                    <div id="${singlePost.id}" title="Delete Post" class="delete">
                                        <a><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></a>
                                    </div>
                                </div>
                                <div class="userPost">
                                            <p>${singlePost.content}</p>
                                            <div class="postImage">
                                                <img src="posts&#92;${singlePost.image}" alt="">
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
                                                        id="likeBadge${singlePost.id}">${singlePost.totalLikes}</span></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a id="${singlePost.id}" class="likeBtn"><span
                                                    class="glyphicon glyphicon-heart"
                                                    aria-hidden="true"></span>
                                                <em>Like</em>&nbsp;<span
                                                        class="badge"
                                                        id="likeBadge${singlePost.id}">${singlePost.totalLikes}</span></a>
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
                                        <textarea rows="2" cols="50" id="commentText${singlePost.id}" class="comment"
                                                  placeholder=""></textarea><a
                                            name="${singlePost.id}"
                                            class="btn btn-primary postComment">Comment</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>