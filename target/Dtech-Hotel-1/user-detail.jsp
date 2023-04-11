<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM accounts JOIN reservations USING(accountid)
    WHERE reservationid = ${param.reservationid}
</sql:query>

    <sql:query var="detail" dataSource="${myDatasource}">
        SELECT *
        FROM accounts JOIN reservations USING(accountid)
        JOIN rooms USING(roomid)
        JOIN categories USING (categoryid)
        WHERE reservationid = ${param.reservationid}
    </sql:query>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Detail Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            form{
                width: 700px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center my-5">
                <form action="add_staff" method="POST" class="shadow p-5" autocomplete="off">
                    <h1>Reservation Number ${param.reservationid}</h1>
                    
                    <div class="mt-5 text-center">
                        <img src="media/img/category/${detail.rows[0]['image']}" alt="alt"/>
                    </div>
                    
                    <h3 class="mt-5">Booking Information</h3>
                    
                    <hr class="w-50" style="height: 2px;">
                    
                    <div class="row justify-content-center my-3">
                        <label>Room No</label>
                        <input type="text" class="form-control"value="${detail.rows[0]['roomno']}">
                    </div>
                    
                    <!-- Date Input -->
                    <div class="row justify-content-center my-3 ">
                        <div class="col-3 d-flex justify-content-center">
                            <div class="form-group text-center">
                               <label>Check In</label>
                                <input type="text" class="form-control text-center" value="${fn:substring(detail.rows[0]['datestart'],0,10)}" >
                            </div>
                        </div>
                        
                        <div class="col-3 d-flex justify-content-center">
                            <div class="form-group text-center" >
                                <label>Check Out</label>
                                <input type="text" class="form-control text-center" value="${fn:substring(detail.rows[0]['dateend'],0,10)}" >
                            </div>
                        </div>
                            
                        <div class="col-3 d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                               <label>Total Day</label>
                                <input type="text" class="form-control text-center" value="${detail.rows[0]['total_day']}" readonly>
                            </div>
                        </div>
                    </div>
                            
                    <!-- Total Day -->
                    <div class="row justify-content-center">
                        
                        <div class="col-3 d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                               <label>Total Adult</label>
                                <input type="text" class="form-control text-center" value="${detail.rows[0]['total_adult']}" readonly>
                            </div>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                               <label>Total Child</label>
                                <input type="text" class="form-control text-center" value="${detail.rows[0]['total_child']}" readonly>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Total Price -->
                    <div class="row justify-content-center mt-3">
                        
                        <div class="col-3 d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                               <label>Total Price</label>
                                <input type="text" class="form-control bg-success text-white text-center" value="RM ${detail.rows[0]['total_price']}" readonly>
                            </div>
                        </div>
                    </div>
                            
                    
                    
                    <h3 class="mt-5">User Information</h3>
                    <hr class="w-50" style="height: 2px;">
                    <div class="form-group">
                        <label>Fullname</label>
                        <input type="text" name="fullname" class="form-control" placeholder="Fullname" value="${detail.rows[0]['fullname']}" >
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" placeholder="Email" value="${detail.rows[0]['email']}" >
                    </div>
                    
                    <div class="form-group my-3">
                        <label>Phone</label>
                        <input type="text" name="phone" class="form-control" placeholder="Phone" value="${detail.rows[0]['email']}" >
                    </div>
                    
                    <a href="dashboard-manager.jsp">Go Back</a>
                </form>
            </div>
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
