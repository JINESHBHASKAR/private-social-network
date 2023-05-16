<%
    if(session.getAttribute("loggedInUser") != null) {
        response.sendRedirect("Home");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Happy Society</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="assets/js/jquery.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Login Script File -->
    <script src="assets/js/loginregister.js"></script>

</head>
<body>
<div id="wrapper">
    <div class="container">
        <div class="col-md-6 col-xs-12"></div>
        <div class="col-md-6 col-xs-12 login down">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Log In</a></li>
                <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Sign Up</a></li>
            </ul>



            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="home">
                    <!--<img src="assets/images/logo1.png" alt="logo">-->
                    <h1>Welcome to Happy Society</h1>
                    <form action="AuthUser" method="POST">
                        <input type="text" id="loginMessage" class="hidden" disabled>
                        <input id="email" type="text" name="email" placeholder="Email" pattern="[a-z0-9._+\]+@[a-z0-9.\-]+\.[a-z]{2,3}"><br>
                        <input id="password" type="password" name="password" placeholder="Password"><br>
                        <input id="signin" type="submit" value="Sign In">
                    </form>
                    <!--<a id="loginBtn">Sign In</a>-->

                </div>
                <div role="tabpanel" class="tab-pane" id="profile">
                    <form id="registerform" action="RegisterUser" method="post" role="form">
                        <div class="form-group">
                            <input type="text" id="registerMessage" class="form-control hidden" disabled>
                        </div>
                        <div class="form-group">
                            <input type="text" name="fullname" id="register-full-name" tabindex="1"
                                   class="form-control" placeholder="Full Name" required>
                        </div>
                        <div class="form-group">
                            <input type="email" name="registeremail" id="register-email" tabindex="3"
                                   class="form-control" placeholder="Email Address" value=""  pattern="[a-z0-9._+\]+@[a-z0-9.\-]+\.[a-z]{2,3}" required>
                        </div>
                        <div class="form-group">
                            <input type="password" name="registerpassword" id="registerpassword" tabindex="4"
                                   class="form-control" placeholder="Password"  pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
                        </div>
                        <div class="form-group">
                            <input type="password" name="confirmpassword"
                                   id="confirmpassword" tabindex="5" class="form-control"
                                   placeholder="Confirm Password" required>
                        </div>
                        <div class="form-group form-inline">
                            <select class="form-control" tabindex="6" id="register-state"
                                    name="state">
                                <option value="">------------Select State------------</option>
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
                            <input type="text" name="city" id="register-city" tabindex="7" class="form-control" placeholder="City" value="" required>
                            <input type="text" name="street" id="register-street" tabindex="8" class="form-control" placeholder="Street" value="" required>
                            <input type="text" name="pincode" pattern="[0-9]{6}" title="Pin code must contain exactly 6 digits" id="register-zip" tabindex="8" class="form-control" placeholder="PIN Code" value="" required>
                        </div>
                        <div class="form-group">
                            <label for="register-dob">Birth Year</label>
                            <input type="text" name="birthyear"
                                   id="register-dob" pattern="\d{4}" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <div class="radio-inline">
                                <label><input type="radio" tabindex="10" name="gender" value="Male" required checked>Male</label>
                            </div>
                            <div class="radio-inline">
                                <label><input type="radio" tabindex="11" name="gender" value="Female" required>Female</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="submit" name="register-submit" id="registerBtn"
                                           tabindex="12" class="form-control btn btn-register"
                                           value="Register Now">
                                </div>
                            </div>
                        </div>
                    </form>


                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>