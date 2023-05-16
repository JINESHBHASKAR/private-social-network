$(function () {

    let start = 10;
    let limit = 10;

    $(window).scroll(function () {
        if ($(window).scrollTop() == $(document).height() - $(window).height()) {
            $.get("LoadMorePosts", {"start": start, "posttype": "profile"})
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

    function ajaxFailure(xhr, status, exception) {
        alert("Unable to update...");
    }

    $(".likeBtn").on('click', updateLike);

    $(".viewshowcomments").on('click', loadComments);

    $(".postComment").on('click', postComment);

    $(".delete").on('click', deletePost);


    function updatePublishedNewPost(post) {
        post = JSON.parse(post);

        var singlePost = `<div class="posts" id="completePost` + post.id + `">
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
                                            <div title="Delete this post" class="delete" id="deletePost` + post.id + `">
                                                <a><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></a>
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
        $("#deletePost" + post.id).on('click', deletePost);

    }

    function appendNewPost(post) {
        var singlePost = `<div class="posts" id="completePost` + post.id + `">
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
                                            <div title=title="Delete this post" class="delete" id="deletePost` + post.id + `">
                                                <a><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></a>
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
        $("#deletePost" + post.id).on('click', deletePost);
    }


    function loadComments() {
        let id = this.name;

        $("#comments" + this.name).toggleClass("hidden");
        if (!$("#comments" + this.name).hasClass("hidden")) {
            $.post("LoadComments", {"post_id": id})
                .done(function (response) {
                    $("#comments" + id + " .singleComment").remove();

                    $.each(response, function (index, comment) {

                        let commentDiv = `<div id="` + comment.id + `" class="singleComment">
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
        let id = this.name;
        let comment = $("#commentText" + id).val();

        if (comment === "") {
            alert("Comments cannot be empty...");
            return;
        }

        $.post("PostComment", {"post_id": id, "comment": comment})
            .done(function (response) {
                if (response.status === "success") {
                    $("#commentText" + id).val("");

                    let comment = JSON.parse(response.message);

                    let commentDiv = `<div id="` + comment.id + `" class="singleComment">
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
                    $("#completePost" + response.post_id).remove();
                    alert(response.message);
                    
                } else {
                    alert(response.message);

                }
            })
            .fail(ajaxFailure);
    }

    function updateLike() {

        let id = this.id;
        let likeBtn = $(this);

        $.post("UpdateLike", {"post_id": id}) //here post id comes from post
            .done(function (response) { //data from LikeServlet may be json or out(success)
                if (response.status === "success" && response.message === "Liked") {
                    likeBtn.addClass("redcolor");
                    let currentLikes = parseInt($("#likeBadge" + id).text());
                    currentLikes++;
                    $("#likeBadge" + id).text(currentLikes);
                    likeBtn.find("em").text("Unlike");

                } else if (response.status === "success" && response.message === "Unliked") {
                    likeBtn.removeClass("redcolor");
                    let currentLikes = parseInt($("#likeBadge" + id).text());
                    currentLikes--;
                    $("#likeBadge" + id).text(currentLikes);
                    likeBtn.find("em").text("Like");

                } else {
                    ajaxFailure();
                }
            })
            .fail(ajaxFailure);

    }

    function deletePost() {
        let id = this.id;
        if(id.includes('deletePost')) id = id.replace('deletePost','')

        let r = confirm("Are you sure to delete this post?");
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
