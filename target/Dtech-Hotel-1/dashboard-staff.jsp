<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="myDatasource" 
                   driver="oracle.jdbc.OracleDriver" 
                   url="jdbc:oracle:thin:@localhost:1521:XE" 
                   user="Hazwan" 
                   password="123"
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT roomno,datestart,dateend,fullname
    FROM staffs JOIN reservations USING(staffid) JOIN rooms USING(roomid)
    WHERE staffid = ${staff.id}
</sql:query>
    
<!-- Set Current Date -->
<% 
    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date(System.currentTimeMillis());
    request.setAttribute("currentDate", formatter.format(date));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Dashboard</title>
        
        <jsp:include page="include/import-style.jsp"/>
        
        <!-- CSS for this pages -->
        <style>
            ul,li{
                list-style: none;
                font-size: 20px;
            }
            
            table{
                width: 100px;
            }
            
            td{
                vertical-align: middle;
            }
            
            .bg-gradient-blue{
                background-image: linear-gradient(#9FDDD3,#69B4AE);
            }
            .bg-blue{
                background-color: #69B4AE;
            }
            
            .sidebar-nav{
                width: 450px; /* width of sidebar */
                transform: none;
                visibility: visible;
                top: 98px;
            }
            .container{
                margin: 150px 500px;  
            }
            .table-container{
                margin: 0px 500px; 
                width: 1500px;
            }
            
            .sidebar-link{
                display: flex;
                align-items: center;
            }
            .sidebar-link .right-icon{
                display: inline-flex;
                
            }
            
            .sidebar-link[aria-expanded="true"] .right-icon{
                transform: rotate(-90deg);
                transition: 0.5s;
            }
            .sidebar-link[aria-expanded="false"] .right-icon {
                transition: 0.5s;
            }
            
            ::-webkit-scrollbar {
                width: 10px;
            }
            
            
            
            canvas{
                width: 10px;
                height: 10px;
            }
            .form-size{
                width: 400px;
            }
            
            body{
                background-color: lightgrey;
            }
            
            .row{
                border-radius: 15px;
                padding: 25px;
            }
            
            .form-check{
                padding: 10px 40px 10px;
            }
        </style>
        
    </head>
    <body>
        <div class="container">
            <!-- Error notification -->
            <div class="alert alert-success alert-dismissible fade show" id="poppup" role="alert" style="width:400px;">
                <i class="fal fa-exclamation-circle"></i> <span id="error"></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            
            <!-- Top bar -->
            <nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-gradient-blue">
                <div class="container-fluid">
                    <!-- image logo -->
                    <a class="navbar-brand mx-3">
                        <img src="media/img/logo.png" alt="logo" width="70" height="70" />
                    </a>
                    
                    <div class="row">
                        <div class="col-12">
                            <a href="change-password-staff.jsp" class="btn btn-outline-secondary">Change Password</a>
                            <a href="logout" class="btn btn-outline-secondary">Logout</a>
                        </div>
                    </div>
                </div>
            </nav>
            
            <!-- Offcanvas for all list -->
            <div 
                class="offcanvas offcanvas-start sidebar-nav bg-blue" 
                tabindex="-1" 
                id="offcanvasScrolling" 
                aria-labelledby="offcanvasScrollingLabel"
            >
                <div class="offcanvas-body p-1">
                    <nav class='navbar-dark'>
                        <ul class='navbar-nav'>
                            
                            <!-- List for Reservation -->
                            <li>
                                <a class="nav-link px-3 mt-4 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapseReservation"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapseReservation"
                                >
                                    <span class="me-3"><i class="fas fa-clipboard-list text-dark"></i></i></i></span>
                                    <span>Task</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                <div class="collapse" id="collapseReservation">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#table-reservation" onclick="viewTask()">
                                                    <span class="me-2 text-primary"><i class="fas fa-house-leave"></i>&nbsp; View Task</span>
                                                </a>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </li>
                            
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                            
                            <!-- List for Profle -->
                            <li>
                                <a class="nav-link px-3 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapseProfile"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapseProfile"
                                >
                                    <span class="me-3"><i class="fa fa-user text-dark"></i></i></span>
                                    <span>Profile</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                <div class="collapse" id="collapseProfile">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#edit-profile" onclick="viewProfile();">
                                                    <span class="me-2 text-warning"><i class="fas fa-user-edit "></i>&nbsp; Edit Profile</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            
            <!-- Table Task -->
            <div class="row bg-secondary" id="viewTask">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of Task</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <table class="table table-hover text-center" id="tableStaff">
                        <!-- column headers -->
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Room No</th>
                                <th>Check In Date</th>
                                <th>Check Out Date</th>
                                <th>Staff Incharge</th>
                                <th>Status</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row" items="${result.rows}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>

                                    <td>${row['ROOMNO']}</td>
                                    <td>${row['DATESTART']}</td>
                                    <td>${row['DATEEND']}</td>
                                    <td>${row['FULLNAME']}</td>
                                    
                                    <c:choose>
                                        <c:when test="${row['DATEEND'] < currentDate}">
                                            <td><p href="url" class="btn btn-success">Done</p></td>
                                        </c:when>
                                            
                                        <c:otherwise>
                                            <td><a href="" class="btn btn-warning">Not Done</a></td>
                                        </c:otherwise>
                                    </c:choose>

                                    <td></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Edit User Profile -->
            <div class="row bg-secondary form-size" id="editProfile" style="width: 600px;">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">Edit User Profile</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <form id="formStaff">
                        <input type="hidden" name="id" id="id" value="${staff.id}">
                        <div class="form-group">
                            <label>Fullname</label>
                            <input type="text" name="fullname" id="fullname" class="form-control" placeholder="Fullname" value="${staff.fullname}" size="30px">
                        </div>
                        
                        <div class="form-group mt-3">
                            <label>Email</label>
                            <input type="text" name="email" id="email" class="form-control" placeholder="Email" value="${staff.email}" size="30px">
                        </div>
                        
                        <div class="form-group mt-3">
                            <label>Phone</label>
                            <input type="text" name="phone" id="phone" class="form-control" placeholder="Phone" value="${staff.phone}" size="30px">
                        </div>
                        
                        <div class="form-group mt-3">
                            <label>Address</label>
                            <input type="text" name="address" id="address" class="form-control" placeholder="Address" value="${staff.address}" size="30px">
                        </div>
                        
                        <div class="form-group mt-3">
                            <label>Position</label>
                            <input type="text" name="position" id="position" class="form-control" placeholder="Position" value="${staff.position}" size="30px" readonly>
                        </div>
                        
                        <div class="form-group mt-3">
                            <label>Status</label>
                            <input type="text" name="status" id="status" class="form-control" placeholder="Status" value="${staff.status}" size="30px" readonly>
                        </div>
                        

                        <div class="form-group mt-3 text-end">
                            <a class="btn btn-info" id="add" onclick="return take_value_profile()">Save</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <jsp:include page="include/import-script.jsp"/>
        
        <script>
            hideAll();
            $("#viewTask").show();        
            
            function hideAll(){
                $("#viewTask").hide();
                $("#editProfile").hide();
                $("#poppup").hide();
            }
            
            function viewProfile(){
                hideAll();
                $("#editProfile").show();
            }
            
            function viewTask(){
                hideAll();
                $("#viewTask").show();
            }
        </script>
        
        <script>
            function take_value_profile(){
                var id = document.forms["formStaff"]["id"].value;
                var fullname = document.forms["formStaff"]["fullname"].value;
                var email = document.forms["formStaff"]["email"].value;
                var phone = document.forms["formStaff"]["phone"].value;
                var address = document.forms["formStaff"]["address"].value;
               
                var http = new XMLHttpRequest();
                
                http.open("POST", "update_staff", true);
                http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                
                var params1 = "id=" + id + "&fullname=" + fullname + "&email=" + email + "&phone=" + phone + "&address=" + address;
                
                http.send(params1);
                
                http.onload = function() {
                    $("#poppup").show();
                    document.getElementById('error').innerHTML = 'Success';
                };
            }
        </script>
    </body>
</html>
