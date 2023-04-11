<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Success Page</title>
        <jsp:include page="include/import-style.jsp"/>
    </head>
    <body>
        <div class="container">
            <h1 class="text-success">Congratulation</h1>
            ${show.toString()}
            ${show1}
            
            <c:if test="${userSubmit == 'Submit'}">
                 <p>
                    Fullname: ${account.fullname} <br>
                    Email: ${account.email} <br> 
                    Username ${account.username} <br>
                    Phone: ${account.phone} <br>
                    Password: ${account.password} <br> 
                    Citizen: ${account.citizen} <br>
                    <c:if test="${account.citizen == 'yes'}" >
                        IC: ${account.ic} <br> 
                    </c:if>

                </p>
            </c:if>
                
            <c:if test="${staffSubmit == 'Submit'}">
                <p>
                    Fullname: ${staff.fullname} <br>
                    Email: ${staff.email} <br> 
                    Address: ${staff.address} <br>
                    Phone: ${staff.phone} <br>
                    Position: ${staff.position} <br> 
                    Status: ${staff.status} <br>
                    Manager: ${staff.manager} <br>
                </p>
            </c:if>
                
            <c:if test="${facilitySubmit == 'Add'}">
                 <p>
                    Name: ${facility.name} <br>
                    Type: ${facility.type} <br> 
                    Icon: ${facility.icon} <br>
                </p>
            </c:if>
                
            <c:if test="${detailSubmit == 'Add'}">
                 <p>
                    Name: ${facility.name} <br>
                    Description: ${facility.type} <br> 
                    SQFT: ${facility.icon} <br>
                    Suitable: ${facility.icon} <br>
                    Price: ${facility.icon} <br>
                    Deposit: ${facility.icon} <br>
                </p>
            </c:if>
                
            <c:if test="${roomSubmit == 'Add'}">
                 <p>
                    Roomno: ${room.roomno} <br>
                    Status: ${room.status} <br> 
                    Detail Id: ${room.detailid} <br> 
                </p>
            </c:if>
           

            <h3 class="text-success">
                Successfully Registered <i class="far fa-check-circle"></i>
            </h3>

            <a href="${link}">Back</a>
        </div>
        
    </body>
    <script>
        var i = '${show}';
    </script>
</html>
