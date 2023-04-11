<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Login</title>
        <%@ include file="include/import-style.jsp" %>
        
        <style>
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
        
        <div class="container">
            <c:if test="${msg != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>
        
        <div class="d-flex justify-content-center">
            <form action="login_staff" method="POST">
                <h1>Staff Login</h1>
                <table class="mt-3">
                    <tr>
                        <td> ID: </td>
                        <td> <input type="text" name="id" value="${param.username}"> </td>
                    </tr>
                    
                    <tr>
                        <td> Password: </td>
                        <td> <input type="password" name="password" value="${param.username}"> </td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td class="text-end"><input type="submit" name="submitStaff" value="Login"></td>
                    </tr>
                </table>
            </form>
        </div>
                    
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
