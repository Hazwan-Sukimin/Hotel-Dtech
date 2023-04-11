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

<sql:query var="result1" dataSource="${myDatasource}">
    SELECT * FROM staffs
</sql:query>

<sql:query var="room" dataSource="${myDatasource}">
    SELECT * FROM reservations JOIN rooms USING(roomid)
    WHERE reservationid = ${param.reservationid}
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assign Staff Page</title>
        <jsp:include page="include/import-style.jsp"/>
    </head>
    <body>
        
        <div class="container mt-5">
            <!--show Error if user wrongly input any information-->
            <c:forTokens var = "result" items = "${errorMsgs}" delims = "," >
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fal fa-exclamation-circle"></i> | ${result}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            </c:forTokens>
            
            <h1 class="text-center">Assign Staff</h1>
            
            <div class="d-flex justify-content-center">

                <form action="assign_staff" method="POST">
                    <input type="hidden" name="reservationid" value="${param.reservationid}">
                    <div class="form-group mt-4">
                        <label>RoomNo</label>
                        <input type="text" class="form-control" value="${room.rows[0]['roomno']}" size="30px" readonly>
                    </div>
                    
                    <div class="form-group mt-4">
                        <label>Check In</label>
                        <input type="text" class="form-control" value="${fn:substring(room.rows[0]['datestart'],0,10)}" size="30px" readonly>
                    </div>
                    
                    <div class="form-group mt-4">
                        <label>Check Out</label>
                        <input type="text" class="form-control" value="${fn:substring(room.rows[0]['dateend'],0,10)}" size="30px" readonly>
                    </div>
                    
                    <div class="form-group mt-4">
                        <label>Staff Name</label>
                        <select class="form-control" name="staffid" size="3">
                            <c:forEach var="row" items="${result1.rows}" > 
                                <option value="${row['staffid']}">${row['fullname']}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group text-end mt-4">
                        <input type="submit" class="btn btn-primary" value="Assign">
                    </div>
                </form>
            </div>
            
            
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
