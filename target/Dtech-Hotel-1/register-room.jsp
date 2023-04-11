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
    SELECT * FROM categories
</sql:query>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Room Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            td{
            padding: 10px;
        }
        </style>
    </head>
    
    <body>
        <div class="container">
            <!--show Error if user wrongly input any information-->
            <c:forTokens var = "result1" items = "${errorMsgs}" delims = "," >
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fal fa-exclamation-circle"></i> | ${result1}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            </c:forTokens>
                
            
            <div class="d-flex justify-content-center">
                <form action="add_room" class="shadow p-5 mt-5" method="POST">
                    <h1>Add Room</h1>
                    <div class="form-group">
                        <label>Room No</label>
                        <input type="text" name="roomno" id="roomno" class="form-control" placeholder="Room No" value="${param.roomno}" size="30px">
                        <label><small>6 character, Example:SPS001</small></label>
                    </div>
                        
                    <div class="form-group mt-3">
                        <label for="standard-select">Category</label>

                        <div class="select" style="padding-right: 450px">
                            <select name="category" style="margin-right: 420px">
                                <c:forEach var="row" items="${result.rows}">
                                    <option value="${row['CATEGORYID']}"> ${row['NAME']} </option>
                                </c:forEach>
                            </select>
                            <span class="focus"></span>
                        </div>
                    </div>
                        
                    <div class="form-group mt-3">
                        <label for="standard-select">Status</label>

                        <div class="select" style="padding-right: 450px">
                            <select name="status" id="standard-select" style="margin-right: 420px">
                                <option value="Available">Available</option>
                                <option value="Maintenance">Maintenance</option>
                                <option value="Close">Close</option>
                            </select>
                            <span class="focus"></span>
                        </div>
                    </div>
                        
                    <div class="form-group mt-3 text-end">
                        <input type="submit" name="submit" value="Save" class="btn btn-info">
                    </div>
                    <a href="dashboard-manager.jsp">Go Back</a>
                </form>
            </div>
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
