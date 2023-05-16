$(function(){
   $("#followList").on('click','.unfollowBtn',function(){
       var id = this.name;
        $.post("Unfollow",{"Follow_id":id})
            .done(function(response){
                if (response.status === "success") {
                    alert(response.message);
                    this.value = 'Follow'

                } else {
                    alert(response.message);
                }

            }).fail(function(){
                alert("Unable to update!");
            });
   }); 
});

