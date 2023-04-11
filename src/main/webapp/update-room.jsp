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

<sql:query var="room" dataSource="${myDatasource}">
    SELECT * FROM rooms WHERE roomid = ${param.id}
</sql:query>
    
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Room Page</title>
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
                <form action="update_room" method="POST" class="shadow p-5" autocomplete="off">
                    <h1>Update Room</h1>
                    <input type="hidden" name="id" value="${param.id}">
                    <div class="form-group mt-5">
                        <label>Room No</label>
                        <input type="text" name="roomno" class="form-control" placeholder="Roomno" value="${room.rows[0]['roomno']}" size="30px">
                    </div>
                    
                    <div class="form-group mt-3">
                        <label for="standard-select">Status</label>

                        <div class="select" style="padding-right: 450px">
                            <select name="status" id="standard-select" style="margin-right: 420px">
                                <c:forEach var="i" items="${room.rows}">
                                    <c:if test="${i['status'] == 'Available'}">
                                        <option value="Available" selected>Available</option>
                                        <option value="Maintenance">Maintenance</option>
                                        <option value="Close">Close</option>
                                    </c:if>
                                    <c:if test="${i['status'] == 'Maintenance'}">
                                        <option value="Available" >Available</option>
                                        <option value="Maintenance" selected>Maintenance</option>
                                        <option value="Close">Close</option>
                                    </c:if>
                                    <c:if test="${i['status'] == 'Close'}">
                                        <option value="Available" >Available</option>
                                        <option value="Maintenance">Maintenance</option>
                                        <option value="Close" selected>Close</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <span class="focus"></span>
                        </div>
                    </div>
                    
                    <div class="form-group my-3">
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
