$(function(){
    $('select').on('change', function (e) {
    var optionSelected = $("option:selected", this);
    var id = this.value;
    console.log(id);
    
    $.post("LoadMessages", {"buddy_id": id})
            .done(function (response) {
                if (response.status === "success") {
                    var messages = JSON.parse(response.message);
                    $("#conversation").empty();
                    var div = `<div class="newPost" id="sendMessage">
                                    <form id="messageForm">
                                        <textarea id="messagecontent" name="messagecontent" rows="3" placeholder=""></textarea>
                                        <input type="submit" name="` + id + `" id="btnSubmit" value="Send" class="btn btn-primary sendBtn">
                                        </form>
                                </div>`;
                    $("#conversation").append(div);
                    
                    $.each(messages,function(key,message){
                        
                             div = `<div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <img src="profiles\\`+ message.sentByProfilePic + `">
                                            </div>
                                            <div class="username">
                                                <p id="userName">` + message.sentBy + `</p>
                                                <div class="postTime">
                                                    <p>Sent on ` + message.dateTime + `</p>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="userPost">
                                            <p>` + message.message + `</p>
                                        </div>
                                <div>`;
                        
                        $("#conversation").prepend(div);
                        
                        
                    });
                    
                   
                } else {
                    alert(response.message);
                }
            }).fail(function () {
                    alert("Unable to post your comment... Please try again...");

            });

    });
    
    $("#conversation").on('click','.sendBtn',function (event) {

                event.preventDefault();
                
                var id = this.name;
                var message = $("textarea").val();
                
                $.post("SendMessages", {"buddy_id": id, "message": message})
                        .done(function (response) {
                            console.log(response);
                            if (response.status === "success") {

                                var message = JSON.parse(response.message);

                                var messageDiv =    `<div class="box">
                                                        <div class="header">
                                                            <div class="userProfileImage">
                                                                <img src="profiles\\`+ message.sentByProfilePic + `">
                                                            </div>
                                                            <div class="username">
                                                                <p id="userName">` + message.sentBy + `</p>
                                                                <div class="postTime">
                                                                    <p>Sent on ` + message.dateTime + `</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="userPost">
                                                            <p>` + message.message + `</p>
                                                        </div>
                                                    <div>`;
                        
                                $("#conversation").prepend(messageDiv);

                            } else {
                                alert(response.message);
                            }
                        }).fail(function () {
                            alert("Unable to post your comment... Please try again...");

                        });
                });
});


