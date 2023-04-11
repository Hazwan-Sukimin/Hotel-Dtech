<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
        <%@ include file="include/import-style.jsp" %>
        
        <style>
            a,ul,li{
                font-size: 20px;
                margin-right: 10px;
            }
            td{
                padding: 10px;
            }
            body{
                padding-top: 100px;
            }
        </style>
        
    </head>
    
    <body>
        <jsp:include page="include/navbar.jsp"/>
        
        <div class="container mt-5">
            
            <!--show Error if user wrongly input any information-->
            <c:forTokens var = "result" items = "${errorMsgs}" delims = "," >
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fal fa-exclamation-circle"></i> | ${result}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            </c:forTokens>

            <div class="d-flex justify-content-center">
                
                <div class="login-content">
                    <form action="login_user" method="POST">
                    <h1>User Login</h1>
                    <table class="mt-3">
                        <tr>
                            <td>Username:</td>
                            <td><input type="text" name="username" value="${param.username}"></td>
                        </tr>

                        <tr>
                            <td>Password:</td>
                            <td><input type="password" name="password" value="${param.password}"></td>
                        </tr>

                        <tr>
                            <td> </td>
                            <td class="text-end"><input type="submit" name="submitUser" value="Login" ></td>
                        </tr>
                    </table>
                        <p><a href="register-user.jsp">Register New Account</a></p>
                    </form>
                </div>
                        
            </div>
            
                    
        </div>
        <script>

            var nav = document.querySelector('nav'); // get nav tag

            // make a listener to change navbar color when scrolling down
            window.addEventListener('scroll', function(){
                if(window.pageYOffset > 100){
                    nav.classList.add('bg-light', 'shadow');
                }else{
                    nav.classList.remove('bg-light', 'shadow');
                }
            });

        </script>          
        <jsp:include page="include/footer.jsp"/>
        
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
