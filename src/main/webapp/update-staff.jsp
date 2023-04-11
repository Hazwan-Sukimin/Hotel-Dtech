<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM staffs
    WHERE position like '%Manager%'
</sql:query>

    <sql:query var="row" dataSource="${myDatasource}">
    SELECT * FROM staffs WHERE staffid = ${param.id}
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Staff Page</title>
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
                <form action="update_staff" method="POST" class="shadow p-5" autocomplete="off">
                    <h1>Update Staff</h1>
                    <input type="hidden" name="id" value="${param.id}">
                    <div class="form-group mt-5">
                        <label>Fullname</label>
                        <input type="text" name="fullname" class="form-control" placeholder="Fullname" value="${row.rows[0]['fullname']}" size="30px">
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" placeholder="Email" value="${row.rows[0]['email']}" size="30px">
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control" placeholder="Address" value="${row.rows[0]['address']}" size="30px">
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Phone</label>
                        <input type="text" name="phone" class="form-control" placeholder="Phone" value="${row.rows[0]['phone']}" size="30px">
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Position</label>
                        <select name="position" class="form-control" id="position">
                            <c:if test="${row.rows[0]['position'] == 'Staff'}" >
                                <option value="Staff" selected>Staff</option>
                                <option value="Manager">Manager</option>
                            </c:if>
                            <c:if test="${row.rows[0]['position'] == 'Manager'}" >
                                <option value="Manager" selected>Manager</option>
                                <option value="Staff">Staff</option>
                            </c:if>
                            
                            
                        </select>
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Manager</label>
                        <select name="manager" class="form-control" id="manager">
                            <option value="0">No</option>
                            <c:forEach var="row" items="${result.rows}">
                                <option value="${row['staffid']}">${row['fullname']}</option>
                            </c:forEach> 
                        </select>
                    </div>
                    <div class="text-end">
                        <input type="submit" name="submit" class="btn btn-primary">
                    </div>
                    
                    <a href="dashboard-manager.jsp">Go Back</a>
                </form>
            </div>
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
