$(document).ready(function () {
    var recipient = null;
    $(document).on('click','#requestBtn',function(){
         $.get("DownloadRequest", {"recipient": recipient})
                .done(function (response) {
                    alert(response.message);
                });        
    });
    
    $(document).on('shown.bs.modal', '#show-profilepic', function (event) {
        var button = $(event.relatedTarget), // Button that triggered the modal
        content = button.find('img').clone(),
        modal = $(this);    
        content.css({'max.width': '300px', 'max-height': '200px'});
        content.attr("class","pic");
        modal.find('.modal-body').empty();
        recipient = button[0].id;
        content.appendTo(modal.find('.modal-body'));
        $.get("CheckStatus", {"recipient": recipient})
                .done(function (response) {
                    if (response.status === "success") {
                        var buttonToAdd = null;
                        switch(response.message) {
                            case '0' :  buttonToAdd = `<button disabled class="btn btn-warning pull-right" >Request yet to accept</button>`;  
                                        $("body").on("contextmenu", "img", function(e) {    return false;   });
                                        $(document).on("mouseover",".pic", function(e){ $(this).attr("src","profiles/avatar.png");  });
                                        break;
                            case '1' :  var src_url = button.find('img')[0].src;
                                        var download_url = src_url.split('/').pop()                                 
                                        buttonToAdd = `<a class="btn btn-info pull-right" role="button" href="`+src_url+`" download="`+download_url+`">Download ProfilePic</a>
                                                    <button disabled class="btn btn-success pull-right" >Request accepted</button>`;  
                                        $("body").on("contextmenu", "img", function(e) {    return true;   });
                                        $(document).on("mouseover",".pic", function(e){ return true;  });
                                        break;
                            case '2' :  buttonToAdd = `<button disabled class="btn btn-danger pull-right" >Request rejected</button>`;  
                                        $("body").on("contextmenu", "img", function(e) {    return false;   });
                                        $(document).on("mouseover",".pic", function(e){ $(this).attr("src","profiles/avatar.png");  });
                                        break;  
                            case '3' :  buttonToAdd = `<button id="requestBtn" class="btn btn-primary pull-right" >Request for Downloading</button>`;  
                                        $("body").on("contextmenu", "img", function(e) {    return false;   });
                                        $(document).on("mouseover",".pic", function(e){ $(this).attr("src","profiles/avatar.png");  });
                                        break;                                      
                        }
                        modal.find('.modal-body').append(buttonToAdd)

                    } else {
                        alert(response.message);

                    }

                });
        
    });
    
    
    $(document).keyup(function(e){
        if(e.keyCode === 44) {
            $.post("PreventPrintScreen")
                    .done(function(response){
                        alert("Cant use PrintScreen Here!!");                        
                    }).fail(function(){
                        alert("Error occured!");
                    });
            
            return false;
        }
    });
    
    //$(window).focus(function() { $(".content").show(); }).blur(function() { $(".content").hide(); alert('nonono, no donut for you!'); });

    var start = 10;
    var limit = 10;

    $(window).scroll(function () {
        if ($(window).scrollTop() == $(document).height() - $(window).height()) {
            $.get("LoadMorePosts", {"start": start, "posttype": "public"})
                .done(function (response) {
                    $.each(response, function (index, value) {
                        appendNewPost(value);
                    });
                    start += limit;

                });
        }
    });

    
    $("#btnSubmit").click(function (event) {

        event.preventDefault();
        
        console.log("POST");
        
        var form = $('#postForm')[0];
        
        var data = new FormData(form);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "SubmitPost",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (response) {
                    if (response.status === "success") {
                        $("#postImage").val("");
                        $("#postcontent").val("");
                        updatePublishedNewPost(response.post);

                    } else {
                        alert(response.message);

                    }
               
            },
            error: function (e) {
                   alert("Unable to publish your post... Please try again...");
            }
        });

    });
    
    
    $(".postComment").on('click', function(event){
        var id = this.name;
        var comment = $("#commentText" + id).val();

        if (comment === "") {
            alert("Comments cannot be empty...");
            return;
        }

        $.post("PostComment", {
            "post_id": id, "comment": comment
        }).done(function (response) {
                console.log(response);
                if (response.status === "success") {
                    $("#commentText" + id).val("");

                    var comment = JSON.parse(response.message);

                    var commentDiv = `<div id="` + comment.id + `" class="singleComment">
                                                <div class="userInfo">
                                                    <div class="userImage">
                                                        <img src="profiles\\`+ comment.postedByPic + `"
                                                             class="userProfileImage">
                                                    </div>

                                                    <div class="postedDetails">
                                                        <p>` + comment.postedBy + `</p>
                                                        <p id="postedComments">` + comment.comment + `</p>
                                                    </div>

                                                </div>

                                            </div>`;

                    $("#commentsBox" + id).append(commentDiv);

                } else if(response.status === "delete") {                    
                    $("#post" + response.post_id).remove();
                        location.reload();
                    alert(response.message);
                    
                } else if(response.status === "Negetive") {  
                    alert(response.message);                    
                }
            }).fail(function () {
                    alert("Unable to post your comment... Please try again...");

        });
        
    });

    function ajaxFailure(xhr, status, exception) {
        alert("Unable to update...");
    }

    $(".likeBtn").on('click', updateLike);

    $(".viewshowcomments").on('click', loadComments);

   // $(".postComment").on('click', postComment);

    $(".delete").on('click', deletePost);

    
    function updatePublishedNewPost(post) {
        
        post = JSON.parse(post);

        var singlePost = `<div class="posts" id="post` + post.id + `">
                                    <div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <img src="profiles\\`+ post.postedByPic + `">

                                            </div>
                                            <div class="username">
                                                <p id="userName">` + post.postedBy + `</p>
                                                <div class="postTime">
                                                    <p>Posted on ` + post.dateTime + `</p>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="userPost">
                                            <p>` + post.content + `</p>
                                            <div class="postImage">
                                                <img src="posts\\` + post.image + `" alt="">
                                            </div>
                                        </div>
                                        <hr/>

                                        <div class="footer">`;

        if (post.likedByMe === "true") {
            singlePost += `<a id="` + post.id + `" class="likeBtn redcolor"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Unlike</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        } else {
            singlePost += `<a id="` + post.id + `" class="likeBtn"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Like</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        }

        singlePost += `<a name="` + post.id + `" class="viewshowcomments" id="viewcomments` + post.id + `"><span
                                                    class="glyphicon glyphicon-comment"
                                                    aria-hidden="true"></span>
                                                Comment</a>
                                        </div>
                                        <div class="comments hidden" id="comments` + post.id + `">

                                            <div id="commentsBox` + post.id + `">

                                            </div>

                                            <div id="addComment">

                                                <img src="profiles\\`+ post.postedByPic + `" class="userProfileImage">
                                                <textarea rows="2" cols="50" id="commentText` + post.id + `" class="comment"
                                                          placeholder=""></textarea><a
                                                    name="` + post.id + `"
                                                    class="btn btn-primary postComment" id="postcomment` + post.id + `">Comment</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>`;

        $("#allposts").prepend(singlePost);

        $("#" + post.id).on('click', updateLike);
        $("#viewcomments" + post.id).on('click', loadComments);
        $("#postcomment" + post.id).on('click', postComment);

    }

    function appendNewPost(post) {
        var singlePost = `<div class="posts" id="post` + post.id + `">
                                    <div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <img src="profiles\\`+ post.postedByPic + `">

                                            </div>
                                            <div class="username">
                                                <p id="userName">` + post.postedBy + `</p>
                                                <div class="postTime">
                                                    <p>Posted on ` + post.dateTime + `</p>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="userPost">
                                            <p>` + post.content + `</p>
                                            <div class="postImage">
                                                <img src="posts\\` + post.image + `" alt="">
                                            </div>
                                        </div>
                                        <hr/>

                                        <div class="footer">`;

        if (post.likedByMe === "true") {
            singlePost += `<a id="` + post.id + `" class="likeBtn redcolor"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Unlike</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        } else {
            singlePost += `<a id="` + post.id + `" class="likeBtn"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Like</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        }

        singlePost += `<a name="` + post.id + `" class="viewshowcomments" id="viewcomments` + post.id + `"><span
                                                    class="glyphicon glyphicon-comment"
                                                    aria-hidden="true"></span>
                                                Comment</a>
                                        </div>
                                        <div class="comments hidden" id="comments` + post.id + `">

                                            <div id="commentsBox` + post.id + `">

                                            </div>

                                            <div id="addComment">

                                                <img src="profiles\\`+ post.postedByPic + `" class="userProfileImage">
                                                <textarea rows="2" cols="50" id="commentText` + post.id + `" class="comment"
                                                          placeholder=""></textarea><a
                                                    name="` + post.id + `"
                                                    class="btn btn-primary postComment" id="postcomment` + post.id + `">Comment</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>`;

        $("#allposts").append(singlePost);

        $("#" + post.id).on('click', updateLike);
        $("#viewcomments" + post.id).on('click', loadComments);
        $("#postcomment" + post.id).on('click', postComment);
    }


    function loadComments() {
        var id = this.name;

        $("#comments" + this.name).toggleClass("hidden");
        if (!$("#comments" + this.name).hasClass("hidden")) {
            $.post("LoadComments", {"post_id": id})
                .done(function (response) {
                    $("#comments" + id + " .singleComment").remove();

                    $.each(response, function (index, comment) {

                        var commentDiv = `<div id="` + comment.id + `" class="singleComment">
                                                <div class="userInfo">
                                                    <div class="userImage">
                                                        <img src="profiles\\`+ comment.postedByPic + `"
                                                             class="userProfileImage">
                                                    </div>

                                                    <div class="postedDetails">
                                                        <p>` + comment.postedBy + `</p>
                                                        <p id="postedComments">` + comment.comment + `</p>
                                                    </div>

                                                </div>

                                            </div>`;

                        $("#commentsBox" + id).prepend(commentDiv);

                    });
                })
                .fail(ajaxFailure);
        }

    }

    function postComment() {
        var id = this.name;
        var comment = $("#commentText" + id).val();

        if (comment === "") {
            alert("Comments cannot be empty...");
            return;
        }

        $.post("PostComment", {"post_id": id, "comment": comment})
            .done(function (response) {
                console.log(response);
                if (response.status === "success") {
                    $("#commentText" + id).val("");

                    var comment = JSON.parse(response.message);

                    var commentDiv = `<div id="` + comment.id + `" class="singleComment">
                                                <div class="userInfo">
                                                    <div class="userImage">
                                                        <img src="profiles\\`+ comment.postedByPic + `"
                                                             class="userProfileImage">
                                                    </div>

                                                    <div class="postedDetails">
                                                        <p>` + comment.postedBy + `</p>
                                                        <p id="postedComments">` + comment.comment + `</p>
                                                    </div>

                                                </div>

                                            </div>`;

                    $("#commentsBox" + id).append(commentDiv);

                } else {
                    alert(response.message);

                }
            })
            .fail(ajaxFailure);
    }

    function updateLike() {

        var id = this.id;
        var likeBtn = $(this);
        $.post("UpdateLike", {"post_id": id}) //here post id comes from post
            .done(function (response) { //data from LikeServlet may be json or out(success)
                if (response.status === "success" && response.message === "Liked") {
                    likeBtn.addClass("redcolor");
                    var currentLikes = parseInt($("#likeBadge" + id).text());
                    currentLikes++;
                    $("#likeBadge" + id).text(currentLikes);
                    likeBtn.find("em").text("Unlike");

                } else if (response.status === "success" && response.message === "Unliked") {
                    likeBtn.removeClass("redcolor");
                    var currentLikes = parseInt($("#likeBadge" + id).text());
                    currentLikes--;
                    $("#likeBadge" + id).text(currentLikes);
                    likeBtn.find("em").text("Like");

                } else {
                    ajaxFailure();
                }
            })
            .fail(function(){
                alert("Update failed. Plz try again")
            });

    }

    function deletePost() {
        var id = this.title;

        var r = confirm("Are you sure to delete this post?");
        if (r === true) {
            $.post("DeletePost", {"post_id": id})
                .done(function (response) {
                    if (response.status === "success") {
                        $("#completePost" + id).remove();

                    } else {
                        alert(response.message);

                    }
                }).fail(ajaxFailure);
        }
    }

});
