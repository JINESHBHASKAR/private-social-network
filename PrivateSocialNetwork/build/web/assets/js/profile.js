$(function () {
    
   /* $("form#edit-Profile-form").submit(function (event) {

        event.preventDefault();
        
        var data = new FormData($("#edit-Profile-form")[0]);
        
        for (var value of data.values()) {
            console.log(value); 
        }

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "UpdateProfile",
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

    });*/
    
    $("#updateProfilePic").submit(function (event) {
        event.preventDefault();
        
        var data = new FormData($(this)[0]);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "UpdateProfilePic",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (response) {
                    if (response.status === "success") {
                        $("#update-profilepic").modal("hide");
                        location.reload();
                    }
                    alert(response.message);  
            },
            error: function (e) {
                   alert("Unable to update... Please try again...");
            }
        });
    });

    
    $("#edit-profile").submit(function (event) {
        event.preventDefault();
        

        let fullName = $("#edit-fullname").val();
        let state = $("#edit-state").val();
        let city = $("#edit-city").val();
        let street = $("#edit-street").val();
        let pinCode = $("#edit-pincode").val();
        let birthYear = $("#edit-birth-year").val();

        $.post("UpdateProfile", {
            "fullname": fullName,
            "state": state,
            "city": city,
            "street": street,
            "pincode": pinCode,
            "birthyear": birthYear
        })
            .done(function (response) {
                if (response.status === "success") {
                    $("#closeButton").click();
                    alert(response.message);

                } else {
                    alert(response.message);

                }

            })
            .fail(function () {
                alert("Unable to update profile!!");

            });

    })
});