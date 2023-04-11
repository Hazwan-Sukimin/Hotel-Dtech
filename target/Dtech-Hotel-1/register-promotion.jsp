<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Promotion Page</title>
        
        <%@ include file="include/import-style.jsp" %>
        
        <style>
            td{
                padding: 10px;
            }
            body{
                background-color: lightblue;
            }
        </style>
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
            
            <h1>Register Promotion</h1>
            <form action="add_promotion" method="POST" autocomplete="off">

                <table>
                    <tr>
                        <td> Code:  </td>
                        <td> <input type="text" name="code" value="${param.code}" placeholder="Enter Code... "> </td>
                    </tr>
                    
                    <tr>
                        <td> Promo Rate: </td>
                        <td> <input type="text" name="promorate" value="${param.promorate}" placeholder="Enter Address... "> </td>
                    </tr>

                    <tr>
                        <td> Promotion Off </td>
                        <td> <input type="text" name="promooff" value="${param.promooff}" placeholder="Enter Phone... "> </td>
                    </tr>
                    
                    <tr>
                        <td> Date Start </td>
                        <td> <input type="date" name="datestart" value="${param.datestart}" placeholder="Enter Phone... "> </td>
                    </tr>
                    
                    <tr>
                        <td> Date End </td>
                        <td> <input type="date" name="dateend" value="${param.dateend}" placeholder="Enter Phone... "> </td>
                    </tr>
                    
                    <tr>
                        <td>Description</td>
                        <td>
                            <textarea style="resize: none;" rows="4" cols="50" name="description" value="${param.description}" placeholder="description of promotion"></textarea>
                        </td>
                    </tr>
                    
                    
                    <tr>
                        <td></td>
                        <td style="text-align: end;"> <input type="submit" name="submit" class="btn btn-outline-primary"> </td>
                    </tr>

                </table>
                
            </form>
            <a href="dashboard-manager.jsp">Go Back</a>
        </div>
        
        
        <script>
            
        </script>
        <%@ include file="include/import-script.jsp" %>
    </body>
</html>
