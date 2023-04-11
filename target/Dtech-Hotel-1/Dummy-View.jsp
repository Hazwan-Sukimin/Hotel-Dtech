<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Page</title>
        
        <%@ include file="include/import-style.jsp" %>
        
        <style>
            .table {
                margin: auto;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid ml-5 text-center">
            <h1>Account</h1>
            <form action="" method="post">
                <input type="text" name="search" value="${param.search}" placeholder="Search.."><input type="submit"> <br><hr>
                <input type="submit" name="sortName" value="Sort By Email">
                <input type="submit" name="sortName" value="Sort By First Name">
            </form>
            
            <c:if test="${param.sortName == 'Sort By Email'}">
                <c:set var="sortName" value="DESC"/>
            </c:if>
                
            <c:if test="${param.sortName == 'Sort By First Name'}">
                <c:set var="sortName" value="DESC"/>
            </c:if>
            
            
            <c:choose>
                <c:when test="${search.equals('')}">
                    <sql:query var="result" dataSource="${myDatasource}">
                        SELECT *
                        FROM employees
                        ORDER BY email ${sortName}
                    </sql:query>
                </c:when>
                        
                <c:otherwise>
                    <sql:query var="result" dataSource="${myDatasource}">
                        SELECT *
                        FROM employees
                        WHERE first_name like '%${param.search}%'
                        ORDER BY email ${sortName}
                    </sql:query>
                </c:otherwise>
            </c:choose>

            

            <table class="table table-hover" style="width: 500px">
                <!-- column headers -->
                <thead>
                    <tr class="text-center">
                        <th>No</th>
                        <th>Email</th>
                        <th>FIRST NAME</th>
                        <th>LAST NAME</th>
                    </tr>
                </thead>
                
                <!-- column data -->
                <tbody>
                    
                    <c:forEach var="row" items="${result.rows}" varStatus="count">
                        <tr class="text-center">
                            <td class="bg-info " scope="row"> ${count.index+1} </td>
                            <td class="bg-info " scope="row"> ${row["EMAIL"]} </td>
                            <td class="bg-info " scope="row"> ${row["FIRST_NAME"]} </td>
                            <td class="bg-info " scope="row"> ${row["LAST_NAME"]} </td>
                        </tr>
                    </c:forEach>
                    
                </tbody>
            </table>
        </div>
    </body>
</html>
