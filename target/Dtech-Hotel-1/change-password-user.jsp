<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            tr,td{
                padding: 10px;
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
            <c:if test = "${errorMsgs != null}" >
                <div class="alert alert-${color} alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${errorMsgs}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>
        
        <div class="d-flex justify-content-center">
            <form action="change_password" method="POST">
                <h1>Change Password</h1>
                <input type="hidden" name="accountid" value="${account.id}">
                <table>
                    <tr>
                        <td> Current Password: </td>
                        <td> <input type="password" name="cpassword"> </td>
                    </tr>

                    <tr>
                        <td> New Password: </td>
                        <td> <input type="password" name="password1" > </td>
                    </tr>

                    <tr>
                        <td> Retype Password: </td>
                        <td> <input type="password" name="password2" > </td>
                    </tr>

                    <tr>
                        <td>  </td>
                        <td class="text-end"> <input type="submit" name="submit" value="Update" class="btn btn-outline-primary"> </td>
                    </tr>

                </table>
            </form>
        </div>
        <jsp:include page="include/footer.jsp"/>
        
        
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
