<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<%
    request.setAttribute("roomid", request.getParameter("roomid"));
%>

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM rooms JOIN details USING(detailid)
    WHERE roomid = ${roomid}
</sql:query>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            tr,td{
                padding: 20px;
            }
        </style>
    </head>
    
    <body>
        <div class="container mt-5">
            ${account.fullname}
            <h1>Confirm Booking</h1>
            <form action="register-reservation.jsp" method="POST">
                <table>
                    <c:forEach var="row" items="${result.rows}" > 
                        
                    <tr>
                        <td> RoomNo : </td>
                        <td> ${row['ROOMNO']} </td>
                    </tr>
                    
                    <tr>
                        <td> Room Name : </td>
                        <td> ${row['NAME']} </td>
                    </tr>
                    
                    <tr>
                        <td> Room Description : </td>
                        <td> ${row['DESCRIPTION']} </td>
                    </tr>
                    
                    <tr>
                        <td> Room Price : </td>
                        <td> ${row['PRICE'] + row['DEPOSIT']} </td>
                    </tr>
                    
                    </c:forEach>
                    
                    <tr>
                        <td> </td>
                        <td style="text-align: end;"> 
                            
                            <input class="btn btn-outline-primary" type="submit" value="Confirm Book"> 
                            
                        </td>
                    </tr>
                </table>
            </form>
            
        </div>
    </body>
</html>
