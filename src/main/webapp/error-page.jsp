<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <jsp:include page="include/import-style.jsp"/>
    </head>
    <body>
        <div class="container">
            <h1 class="text-danger">Failed</h1>
           

            <h3 class="text-danger">
                Unsuccessfully Registered <i class="far fa-times-circle"></i>
            </h3>
            
            <br>
            ${status}

            <a href="${link}">Back</a>
        </div>
        
    </body>
</html>
