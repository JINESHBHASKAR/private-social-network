$(function(){
    $("#dismissBtn").click(function(){        
       $.post("DismissBreachNotification", {"notification_id": $(this).parent().attr("id")})
        .done(function (response) {
            console.log("dismissed")
        }).fail(function () {
            alert("Unable to post your comment... Please try again...");

        }); 
    });
    
    $(document).on('click', '.approvalBtn',function(e){
        var id = null,status = null;
        if(this.id.includes('accept')){
            id = this.id.replace('accept','')
            status = 1;
        } else {
            id = this.id.replace('reject','');
            status = 2;
        }
        $.get("UpdateStatus", {"id": id,"status": status})
                .done(function (response) {
                    alert(response.message);
                    location.reload();
                }); 
        
    })
    
});


