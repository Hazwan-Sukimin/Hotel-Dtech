<%@page import="bean.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

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
        <title>User Profile Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            input{
                margin: 10px;
            }
            
            td{
                padding: 10px;
            }
            .form-group{
                width: 300px;
            }
            body{
                padding-top: 100px;
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="include/navbar.jsp"/>
        <div class="container mt-5">
            <c:forTokens var = "result" items = "${errorMsgs}" delims = "," >
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${result}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:forTokens>
            
            <div class="d-flex justify-content-center">
                <form id="userInfo" autocomplete="off">
                    <h1>User Profile</h1>
                    <input type="hidden" name="id" id="id" value="${staff.id}">
                    <div class="form-group">
                        <label>Fullname</label>
                        <input type="text" name="fullname" id="fullname" class="form-control" placeholder="Fullname" value="${account.fullname}" size="30px">
                    </div>

                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" id="fullname" class="form-control" placeholder="Username" value="${account.username}" size="30px">
                    </div>

                    <div class="form-group mt-3">
                        <label>Email</label>
                        <input type="text" name="email" id="email" class="form-control" placeholder="Email" value="${account.email}" size="30px">
                    </div>

                    <div class="form-group mt-3">
                        <label>Phone</label>
                        <input type="text" name="phone" id="phone" class="form-control" placeholder="Phone" value="${account.phone}" size="30px">
                    </div>

                    <div class="form-group mt-3">
                        <label>Citizen</label>
                        <c:choose>
                            <c:when test="${account.citizen == 'yes'}" >
                                <input type="checkbox" name="citizen" id="citizen" onclick="showIcActive();" value="${account.getCitizenC()}" checked>
                            </c:when>

                            <c:otherwise>
                                <input type="checkbox" name="citizen" id="citizen" onclick="showIc();" value="${account.getCitizenC()}">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:choose>
                        <c:when test="${account.ic == null || account.ic == ''}">

                            <div class="form-group mt-3" id="inputic" style="display:none;">
                                <label>IC</label>
                                <input class="form-control" type="text" name="ic">
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="form-group mt-3"  >
                                <label>IC</label>
                                <input class="form-control" type="text" name="ic" value="${account.ic}">
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${account.ic == null || account.ic == ''}">
                            <div class="form-group mt-3">
                                <label>Age</label>
                                <input class="form-control" type="text" name="age" value="${account.getAgeC()}">
                            </div>
                            <div class="form-group mt-3">
                                <label>Gender :</label>

                                <input type="radio" id="male" name="gender" value="Male">
                                <label for="male">Male</label>
                                <input type="radio" id="female" name="gender" value="Female">
                                <label for="female">Female</label><br>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="form-group mt-3">
                                <label>Age</label>
                                <input class="form-control" type="text" name="age" value="${account.getAgeC()}" readonly>
                            </div>
                            <div class="form-group mt-3">
                                <label>Gender :</label>
                                <input class="form-control" type="text" name="gender" value="${account.getGenderC()}" readonly>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="form-group mt-3 text-end">
                        <a class="btn btn-info" id="add" onclick="return take_value_profile()">Save</a>
                    </div>
                </form>
                
            </div>
            
        </div>
        
        <jsp:include page="include/footer.jsp"/>
        
        <jsp:include page="include/import-script.jsp"/>
        
        <script>
            function showIc(){
                var ic = document.getElementById("citizen");
                if (!ic.checked) {
                   document.getElementById("inputic").style.display = "none"; 
                } else {
                    document.getElementById("inputic").style.display = ""; 
                }
            }
        </script>
        
        <script>

            var nav = document.querySelector('nav'); // get nav tag

            // make a listener to change navbar color when scrolling down
            window.addEventListener('scroll', function(){
                if(window.pageYOffset > 50){
                    nav.classList.add('bg-light', 'shadow');
                }else{
                    nav.classList.remove('bg-light', 'shadow');
                }
            });
        </script>
    </body>
    
</html>
