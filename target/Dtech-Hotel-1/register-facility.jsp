<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<sql:setDataSource var="myDatasource" 
                   driver="oracle.jdbc.OracleDriver" 
                   url="jdbc:oracle:thin:@localhost:1521:XE" 
                   user="Hazwan" 
                   password="123"
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM facilities
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Facility Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            tr,td{
                padding: 0px;
                width: 50px;
                font-size: 25px;
            }
        </style>
    </head>
    
    <body>
        
    
        <div class="container mt-5">
            <!--show Error if user wrongly input any information-->
            <c:forTokens var = "result1" items = "${errorMsgs}" delims = "," >
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fal fa-exclamation-circle"></i> | ${result1}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            </c:forTokens>
            
            <div class="d-flex justify-content-center ">
                <form action="add_facility" class="p-5 m-5 shadow" method="POST" autocomplete="off">
                    
                    <h1>Register New Facility</h1>
                    <div class="form-group mt-5">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Name" value="${param.name}" size="30px">
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Type</label>
                        <input type="text" name="type" class="form-control" placeholder="Type" value="${param.type}" size="30px">
                        <small>Example: entertainment, kitchen</small>
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Icon</label>
                        <input type="text" name="icon" class="form-control" placeholder="Icon" value="${param.icon}" size="30px">
                        <small>Format: Please goto this website</small><br>
                        <small>Example: <br>&emsp;&lt;i class="far fa-trash-alt"&gt;&lt;/i&gt; <br>&emsp;&lt;i class="fas fa-shower"&gt;&lt;/i&gt; </small>
                    </div>
                    
                    <div class="text-end">
                        <input type="submit" class="btn btn-primary" name="submit" value="Add">
                    </div>
                    
                    <a href="dashboard-manager.jsp">Go Back</a>
                </form>
                        
                <table class=" table table-hover">
                    <!-- column headers -->
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Icon</th>
                    </tr>
                    <!-- column data -->
                    <c:forEach var="row" items="${result.rows}" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>${row['name']}</td>
                            <td>${row['type']}</td>
                            <td>${row['icon']}</td>
                        </tr>
                    </c:forEach>
                </table>        
            </div>

                
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
