<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register User Page</title>
        
        <%@ include file="include/import-style.jsp" %>
        
        <style>
            td{
                text-align: end;
                padding: 10px;
            }
            body{
                font-size: 20px;
            }
            input#citizen{
                width: 20px;
                height: 20px;
            }
            body{
                padding-top: 100px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="include/navbar.jsp"/>
        
        <div class="container">
            <!--show Error if user wrongly input any information-->
            <c:forTokens var = "result" items = "${errorMsgs}" delims = "," >
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${result}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:forTokens>
        </div>
            
        <div class="d-flex justify-content-center">

            

            <form action="add_user" method="POST" autocomplete="off">
                <h1 class="text-center">Register User</h1>
                
                <div class="form-group mt-4">
                    <label>Fullname</label>
                    <input type="text" name="fullname" id="fullname" class="form-control" placeholder="Fullname" value="${param.fullname}" size="30px">
                </div>
                
                <div class="form-group mt-4">
                    <label>Email</label>
                    <input type="text" name="email" id="fullname" class="form-control" placeholder="Email" value="${param.email}" size="30px">
                </div>
                
                <div class="form-group mt-4">
                    <label>Username</label>
                    <input type="text" name="username" id="fullname" class="form-control" placeholder="Username" value="${param.username}" size="30px">
                </div>
                
                <div class="form-group mt-4">
                    <label>Phone</label>
                    <input type="text" name="phone" id="fullname" class="form-control" placeholder="Phone" value="${param.phone}" size="30px">
                </div>
                
                <div class="form-group mt-4">
                    <label>Password</label>
                    <input type="password" name="password1" id="pass1" class="form-control" placeholder="Password" size="30px">
                    <button type="button" class="btn" onclick="showPassword1();" > <i class="far fa-eye"></i> </button>
                </div>
                
                <div class="form-group mt-4">
                    <label>Confirm Password</label>
                    <input type="password" name="password2" id="pass2" class="form-control" placeholder="Confirm Password" size="30px">
                    <button type="button" class="btn" onclick="showPassword2();" > <i class="far fa-eye"></i> </button>
                </div>
                    
                <label class="mt-4">Are You a Citizen ? </label>
                <div class="form-check">
                    <input type="checkbox" name="citizen" id="citizen" class="form-check-input" onclick="showIc()">
                    <label class="form-check-label" for="citizen">Yes</label>
                </div>
                
                <div class="form-group mt-4" id="inputic" style="display: none;">
                    <label>IC</label>
                    <input type="text" name="ic" class="form-control" value="${param.ic}" placeholder="IC Number">
                </div>
                
                    
<!--                <table>
                    <tr>
                        <td> Fullname:  </td>
                        <td> <input type="text" name="fullname" value="${param.fullname}" placeholder="Enter Fullname... "> </td>
                    </tr>

                    <tr>
                        <td> Email: </td>
                        <td> <input type="email" name="email" value="${param.email}" placeholder="Enter Email... "> </td>
                    </tr>

                    <tr>
                        <td> Username: </td>
                        <td> <input type="text" name="username" value="${param.username}" placeholder="Enter Username... "> </td>
                    </tr>

                    <tr>
                        <td> Phone: </td>
                        <td> <input type="text" name="phone" value="${param.phone}" placeholder="Enter Phone... "> </td>
                    </tr>

                    <tr>
                        <td> Password: </td>
                        <td> <input type="password" name="password1" id="pass1" placeholder="Enter Password... "> </td>
                        <td> <button type="button" class="btn" onclick="showPassword1();" > <i class="far fa-eye"></i> </button> </td>
                    </tr>

                    <tr>
                        <td> Confirm Password: </td>
                        <td> <input type="password" name="password2" id="pass2" placeholder="Retype Password... "> </td>
                        <td> <button type="button" class="btn" onclick="showPassword2();" > <i class="far fa-eye"></i> </button> </td>
                    </tr>

                    <tr>
                        <td> Are you a Citizen </td>
                        <td class="text-start mx-5"> <input type="checkbox" name="citizen" id="citizen" value="yes" onclick="showIc()"> </td>
                    </tr>

                    <tr id="inputic" style="display: none;">
                        <td> IC: </td>
                        <td> <input type="text" name="ic" value="${param.ic}" placeholder="Enter IC... ">  </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td> <input type="submit" name="submit" value="Submit" class="btn btn-outline-primary"> </td>
                    </tr>

                </table>-->
                <div class="form-group mt-3 text-end">
                    <input type="submit" name="submit" value="Submit" class="btn btn-info text-white">
                </div>
                
            </form>
        </div>
                        
        <jsp:include page="include/footer.jsp"/>
        
        
        <script>
            function showIc(){
                var ic = document.getElementById("citizen");
                if (!ic.checked) {
                   document.getElementById("inputic").style.display = "none"; 
                } else {
                    document.getElementById("inputic").style.display = ""; 
                }
            }
            
            function showPassword1(){
                var pass = document.getElementById('pass1').type;
                
                if (pass == 'password') {
                   document.getElementById('pass1').type = "text"; 
                } else {
                    document.getElementById('pass1').type = "password"; 
                }
            }
            function showPassword2(){
                var pass = document.getElementById('pass2').type;
                
                if (pass == 'password') {
                   document.getElementById('pass2').type = "text"; 
                } else {
                    document.getElementById('pass2').type = "password"; 
                }
            }
            
        </script>
        
        <script>

            var nav = document.querySelector('nav'); // get nav tag

            // make a listener to change navbar color when scrolling down
            window.addEventListener('scroll', function(){
                if(window.pageYOffset > 50){
                    nav.classList.add('bg-light', 'shadow');
                }else{
                    nav.classList.remove('bg-light', 'shadow');
                }
            });
        </script>
        <%@ include file="include/import-script.jsp" %>
    </body>
</html>
