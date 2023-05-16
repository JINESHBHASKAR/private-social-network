$(function(){
    $("#searchBtn").click(function(event){
        if ($("#searchName").val() === "") {
            alert("Name cannot be empty...");
            return;
        }        
        
        $.post("SearchUser",{
            "searchName":$("#searchName").val()
        }).done(function(response){
                console.log(response);
                $("#searchResults").empty();
                $("#searchName").val("");
                if(jQuery.isEmptyObject(response))
                    $("#searchResults").append(`<h3>No People Found</h3>`);
                else {
                    names=response;
                    var div;
                    $.each(names,function(key, value){
                        div = `<div class='row'>
                            <div class=\"col-sm-4\" >                               
                                <button class="btn btn-link" id="`+key+`" data-toggle="modal" data-target="#show-profile">`+value+`</button>                                
                            </div>
                            <div class=\"col-sm-1\" style=\"padding: 10px;\">
                                <button id="followBtn`+key+`" class="btn btn-primary followBtn" name="`+key+`">Follow</button>
                            </div>
                           </div>`;
                        $("#searchResults").append(div);   
                    });
                }

        }).fail(function () {
            alert("Unable to search... Please try again...");
        });
    });
    
    $("body").on("contextmenu", "img", function(e) {
        return false;
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
    
    $(document).on('shown.bs.modal', '#show-profile', function (event) {
        var button = $(event.relatedTarget), // Button that triggered the modal
            userid = button.attr("id"),
            modal = $(this);
            
        $.post("GetProfile",{"id":userid})
                .done(function(response){
                    if(response.status === "success") {
                        var details = JSON.parse(response.details);
                        var div = `<img src="profiles/`+details.profilePic+`" style="max.width: 300px; max-height: 200px;">
                    <ul class="list-group">
                        <li class="list-group-item list-group-item-info">Address: `+details.street+`, `+details.city+`, `+details.state+`, `+details.pinCode+`</li>
                        <li class="list-group-item list-group-item-warning">Gender: `+details.gender+`</li>
                        <li class="list-group-item list-group-item-danger">Birth Year: `+details.birthYear+` A.D.</li>
                    </ul>`;
                        modal.find('.modal-body').append(div);
                    } else {
                        alert("No details found");                        
                    }
                }).fail(function(){
                    alert("Error occured");
                });
        
        modal.find('.modal-body').empty();
        content.appendTo(modal.find('.modal-body'));
    });
    
    $(document).on('click','.followBtn',function() {
        $.post("Follow",{"Follow_id":$(this).attr("name")})
            .done(function(response){
                if (response.status === "success") {
                    alert(response.message);
                    $(this).value = 'Following'
                } else {
                    alert(response.message);
                }

            }).fail(function(){
                alert("Unable to update!");
            });
    });
});
