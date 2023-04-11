<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM facilities WHERE facilityid = ${param.id}
</sql:query>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/import-style.jsp"/>
    </head>
    
    <body>
        <div class="container mt-5">
            <!--show Error if user wrongly input any information-->
            <c:forTokens var = "result1" items = "${errorMsgs}" delims = "," >
            <div class="alert alert-${color} alert-dismissible fade show" role="alert">
                <i class="fal fa-exclamation-circle"></i> | ${result1}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            </c:forTokens>
            
            <div class="d-flex justify-content-center ">
                <form action="update_facility" class="p-5 m-5 shadow" method="POST" autocomplete="off">
                    <input type="hidden" name="id" value="${param.id}">
                    <h1>Register New Facility</h1>
                    <div class="form-group mt-5">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Name" value="${result.rows[0]['name']}" size="30px">
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Type</label>
                        <input type="text" name="type" class="form-control" placeholder="Type" value="${result.rows[0]['type']}" size="30px">
                        <small>Example: entertainment, kitchen</small>
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Icon</label>
                        <input type="text" name="icon" class="form-control" placeholder="Icon" value='${result.rows[0]["icon"]}' size="30px">
                        <small>Format: Please goto this website</small><br>
                        <small>Example: <br>&emsp;&lt;i class="far fa-trash-alt"&gt;&lt;/i&gt; <br>&emsp;&lt;i class="fas fa-shower"&gt;&lt;/i&gt; </small>
                    </div>
                    
                    <div class="text-end">
                        <input type="submit" class="btn btn-primary" name="submit" value="Update">
                    </div>
                    
                    <a href="dashboard-manager.jsp">Go Back</a>
                </form>      
            </div>
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
