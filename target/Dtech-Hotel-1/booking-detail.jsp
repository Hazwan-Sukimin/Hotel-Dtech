<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM reservations JOIN rooms USING(roomid)
    WHERE accountid = ${account.id}
</sql:query>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail Page</title>
        <%@ include file="include/import-style.jsp" %>
        <style>
            body{
                padding-top: 100px;
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="include/navbar.jsp"/>
        
        <div class="container">
            <h1>Booking History</h1>
            <table class="table table-hover">
                <!-- column headers -->
                <tr>
                    <th>Room No</th>
                    <th>Date Start</th>
                    <th>Date End</th>
                    <th>Total Day</th>
                    <th>Total Adult</th>
                    <th>Total Child</th>
                    <th>Total Price</th>
                </tr>
                <!-- column data -->
                <c:forEach var="row" items="${result.rows}">
                    <c:set var="dateString1" value="${row['datestart']}" />
                    <c:set var="dateString2" value="${row['dateend']}" />
                    <fmt:parseDate value="${dateString1}" pattern="yyyy-MM-dd" var="date1" />
                    <fmt:parseDate value="${dateString2}" pattern="yyyy-MM-dd" var="date2" />
                    
                    <tr>
                        <td>${row['roomno']}</td>
                        <td>
                            <fmt:formatDate value="${date1}" pattern="d/MM/yyyy" />
                        </td>
                        <td><fmt:formatDate value="${date2}" pattern="d/MM/yyyy" /></td>
                        <td>${row['total_day']}</td>
                        <td>${row['total_adult']}</td>
                        <td>${row['total_child']}</td>
                        <td>${row['total_price']}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        
        
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
