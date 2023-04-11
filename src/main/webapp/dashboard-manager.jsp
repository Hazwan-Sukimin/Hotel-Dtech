<%@page import="bean.Staff"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

<!-- List of Sql Queries Used By This Pages -->
    <!-- Sql Query to list out all Room -->
    <sql:query var="result1" dataSource="${myDatasource}">
        SELECT * FROM rooms JOIN categories USING(categoryid)
    </sql:query>
        
    <!-- Sql Query to list out all Reservation -->
    <sql:query var="reservation" dataSource="${myDatasource}">
        SELECT reservationid,roomno,datestart,dateend, staffid 
        FROM reservations JOIN rooms USING(roomid)
        ORDER BY datestart ASC
    </sql:query>
        
    <!-- Sql Query to list out all Category -->
    <sql:query var="result3" dataSource="${myDatasource}">
        SELECT * FROM categories
    </sql:query>
        
    <!-- Sql Query to list out all Facility -->
    <sql:query var="result4" dataSource="${myDatasource}">
        SELECT * FROM facilities
    </sql:query>
        
    <!-- Sql Query to list out all Staff -->
    <sql:query var="result5" dataSource="${myDatasource}">
        SELECT * FROM staffs
        WHERE staffid <> ${staff.id}
    </sql:query>
        
    <!-- Sql Query to list out all Promotion -->
    <sql:query var="result6" dataSource="${myDatasource}">
        SELECT * FROM promotions
    </sql:query>
        
    <sql:query var="profit" dataSource="${myDatasource}">
        SELECT sum(total_price) AS "total_price" FROM reservations
    </sql:query>
        
    <sql:query var="totalStaff" dataSource="${myDatasource}">
        SELECT count(staffid) AS "staffid" FROM staffs
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
        <title>Manager Dashboard</title>
        
        <%@ include file="include/import-style.jsp" %>
        
        <!--CSS for this pages-->
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
                            <a href="change_password" class="btn btn-outline-secondary">Change Password</a>
                            <a href="logout" class="btn btn-outline-secondary">Logout</a>
                        </div>
                    </div>
                </div>
            </nav>
            
            <!-- display alert when user crud -->
            <div class="row">
                <!--show Error if user wrongly input any information-->
                <c:forTokens var = "result" items = "${errorMsgs}" delims = "," >
                <div class="alert alert-${status} alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${result}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                </c:forTokens>
            </div>              

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
                            <li>
                                <div class="text-muted small fw-bold text-uppercase px-3">
                                    Home
                                </div>
                            </li>
                            
                            <li>
                                <a class="nav nav-link px-4" href="#dashboard" onclick="dashboard()">
                                    <span class="me-2"><i class="fas fa-chart-line text-dark"></i></span>
                                    <span>Dashboard</span>
                                </a>
                            </li>
                            
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                            
                            <!-- List for Reservation -->
                            <li>
                                <a class="nav-link px-3 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapseReservation"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapseReservation"
                                >
                                    <span class="me-3"><i class="fas fa-calendar-alt text-dark"></i></i></span>
                                    <span>Reservation</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                <div class="collapse" id="collapseReservation">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#table-reservation" onclick="viewReservation()">
                                                    <span class="me-2"><i class="fal fa-table"></i>&nbsp; View Reservation</span>
                                                </a>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </li>
                            
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                            
                            <!-- List for Room -->
                            <li>
                                <a class="nav-link px-3 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapseRoom"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapseRoom"
                                >
                                    <span class="me-3"><i class="far fa-hotel text-dark"></i></span>
                                    <span>Room</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                <div class="collapse" id="collapseRoom">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#table-room" onclick="viewRoom()">
                                                    <span class="me-2"><i class="fal fa-table"></i>&nbsp; View All Room</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="nav-link px-4 mb-3" href="register-room.jsp" onclick="viewRoomForm()">
                                                    <span class="me-2"><i class="far fa-bed"></i>&nbsp; Add New Room</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="nav-link px-4" href="#table-category" onclick="viewCategory()">
                                                    <span class="me-2"><i class="fal fa-table"></i>&nbsp; View All Category</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="nav-link px-4" href="register-category.jsp" onclick="viewCategoryForm()">
                                                    <span class="me-2"><i class="fas fa-suitcase"></i>&nbsp; Register Category</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                            
                            <!-- List for Facilities -->
                            <li>
                                <a class="nav-link px-3 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapseFacility"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapseFacility"
                                >
                                    <span class="me-3"><i class="far fa-cogs text-dark"></i></span>
                                    <span>Facility</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                <div class="collapse" id="collapseFacility">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#table-facility" onclick="viewFacility()">
                                                    <span class="me-2"><i class="fal fa-table"></i>&nbsp; View All Facility</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="nav-link px-4" href="register-facility.jsp">
                                                    <span class="me-2"><i class="fas fa-luggage-cart text-dark"></i>&nbsp; Add New Facility</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                            
                            <!-- List for Staff -->
                            <li>
                                <a class="nav-link px-3 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapseStaff"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapseStaff"
                                >
                                    <span class="me-3"><i class="fas fa-users text-dark"></i></span>
                                    <span>Staff</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                
                                <div class="collapse" id="collapseStaff">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#table-staff" onclick="viewStaff()">
                                                    <span class="me-2"><i class="fas fa-id-card text-dark"></i>&nbsp; View All Staff</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="nav-link px-4" href="register-staff.jsp">
                                                    <span class="me-2"><i class="fas fa-user-plus text-dark"></i>&nbsp; Add New Staff</span>
                                                </a>
                                            </li>
                                            
                                        </ul>

                                    </div>
                                </div>
                            </li>
                            
                            <li class="my-4">
                                <hr class="dropdown-divider">
                            </li>
                            <!-- List for Promotion -->
                            <li>
                                <a class="nav-link px-3 sidebar-link" 
                                   data-bs-toggle="collapse" 
                                   href="#collapsePromotion"
                                   role="button"
                                   aria-expanded="false"
                                   aria-controls="collapsePromotion"
                                >
                                    <span class="me-3"><i class="far fa-badge-percent text-dark"></i></span>
                                    <span>Promotion</span>
                                    <span class="right-icon ms-auto"><i class="fas fa-chevron-left"></i></span>
                                </a>
                                
                                <div class="collapse" id="collapsePromotion">
                                    <div>
                                        <ul class="navbar-nav ps-3">
                                            <li>
                                                <a class="nav-link px-4" href="#table-promotion" onclick="viewPromotion()">
                                                    <span class="me-2"><i class="fad fa-tags text-dark"></i>&nbsp; View All Promotion</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="nav-link px-4" href="#add-promotion">
                                                    <span class="me-2"><i class="fas fa-plus-circle text-dark"></i>&nbsp; Add New Promotion</span>
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
                                                <a class="nav-link px-4" href="#edit-profile" onclick="viewEditProfile();">
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
            
            <!-- Card in Bootstrap With Chart Js-->
            <div class="row bg-secondary" id="chartCard">
                <div class="col-3">
                    <div class="card" style="width: 18rem;">
                        <canvas id="myChart1" class="border"></canvas>

                        <div class="card-body">
                            <h5 class="card-title">Total Profit</h5>
                            <p class="card-text">RM ${profit.rows[0]['total_price']}</p>
                            <a href="StudentController" class="btn btn-primary">Direct Me</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-3">
                    <div class="card" style="width: 18rem;">
                        <canvas id="myChart2" class="border"></canvas>

                        <div class="card-body">
                            <h5 class="card-title">Total Staff</h5>
                            <p class="card-text">This Company have ${totalStaff.rows[0]['staffid']} available staff</p>
                            <a href="StudentController" class="btn btn-primary">Direct Me</a>
                        </div>
                    </div>
                </div>
                            
                <div class="col-3">
                    <div class="card my-2" style="width: 18rem;">
                        <canvas id="myChart2" class="border"></canvas>

                        <div class="card-body">
                            <h5 class="card-title">Total Staff</h5>
                            <p class="card-text">This Company have ${totalStaff.rows[0]['staffid']} available staff</p>
                            <a href="StudentController" class="btn btn-primary">Direct Me</a>
                        </div>
                    </div>
                            
                    <div class="card my-2" style="width: 18rem;">
                        <canvas id="myChart2" class="border"></canvas>

                        <div class="card-body">
                            <h5 class="card-title">Total Staff</h5>
                            <p class="card-text">This Company have ${totalStaff.rows[0]['staffid']} available staff</p>
                            <a href="StudentController" class="btn btn-primary">Direct Me</a>
                        </div>
                    </div>
                            
                    <div class="card my-2" style="width: 18rem;">
                        <canvas id="myChart2" class="border"></canvas>

                        <div class="card-body">
                            <h5 class="card-title">Total Staff</h5>
                            <p class="card-text">This Company have ${totalStaff.rows[0]['staffid']} available staff</p>
                            <a href="StudentController" class="btn btn-primary">Direct Me</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Table Room -->
            <div class="row bg-secondary" id="tableRoom">
                
                    
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of All Room</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <div class="col-3">
                        <label for="standard-select">Category</label>
                        <div class="select">
                            
                            <select id="standard-select">
                                <c:forEach var="filterCategory" items="${result3.rows}">
                                    <option value="${filterCategory['CATEGORYID']}">${filterCategory['NAME']}</option>
                                </c:forEach>
                            </select>
                            
                            <span class="focus"></span>
                        </div>
                    </div>
                    
                    <div class="col mt-4">
                        <button type="submit" style="width: 10ch; height: 50px" class="btn btn-primary">Filter</button>
                    </div>
                </div>
                
                <div class="row bg-white rounded-3">

                    <table class="table table-hover text-center" >
                        <!-- column headers -->
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Room No</th>
                                <th>Status</th>
                                <th>Type</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row1" items="${result1.rows}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>

                                    <td>${row1['ROOMNO']}</td>
                                    <td>${row1['STATUS']}</td>
                                    <td>${row1['NAME']}</td>


                                    <td>
                                        <a class="btn btn-outline-primary" href="update-room.jsp?id=${row1['ROOMID']}"><i class="far fa-edit"></i></a>
                                        <a class="btn btn-outline-danger" href="delete_room?id=${row1['ROOMID']}" onclick="if (confirm('Delete selected item?')){return true;}else{event.stopPropagation(); event.preventDefault();};"><i class="far fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
            </div>
            
            <!-- Table Reservation -->
            <div class="row bg-secondary" id="tableReservation">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of All Reservation</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <div class="col-3">
                        <label for="standard-select">Category</label>
                        <div class="select">

                            <select id="standard-select">
                                <c:forEach var="filterCategory" items="${result3.rows}">
                                    <option value="${filterCategory['CATEGORYID']}">${filterCategory['NAME']}</option>
                                </c:forEach>
                            </select>

                            <span class="focus"></span>
                        </div>
                    </div>

                    <div class="col mt-4">
                        <button type="submit" style="width: 10ch; height: 50px" class="btn btn-primary">Filter</button>
                    </div>
                </div>
                
                <div class="row bg-white rounded-3">
                    <table class="table table-hover text-center border border-muted" >
                        <!-- column headers -->
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Room No</th>
                                <th>Check In Date</th>
                                <th>Check Out Date</th>
                                <th>Status</th>
                                <th>User Detail</th>
                                <th>Staff Incharge</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row2" items="${reservation.rows}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>${row2['ROOMNO']}</td>
                                    <td>${fn:substring(row2['DATESTART'],0,10)}</td>
                                    <td>${fn:substring(row2['DATEEND'],0,10)}</td>

                                    <td>
                                        <!--Status for check in and check out-->
                                        <c:choose>
                                            <c:when test="${currentDate > row2['DATEEND'] }">
                                                <span class="text-center bg-warning rounded-pill text-dark" style="padding: 5px;">
                                                    Done
                                                </span>
                                            </c:when>
                                            
                                            <c:otherwise>
                                                <span class="text-center text-white bg-success rounded-pill" style="padding: 5px;">
                                                    Active
                                                </span>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>

                                    <td>
                                        <a class="btn btn-outline-light border btn-sm rounded-pill" href="user-detail.jsp?reservationid=${row2['RESERVATIONID']}" style="padding: 0px 5px;">
                                            <span class="text-center text-primary">
                                                <i class="fas fa-info-circle"></i> Detail
                                            </span>
                                        </a>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${row2['STAFFID']==null}">
                                                <a class="btn btn-warning btn-sm rounded-pill" href="assign-staff.jsp?reservationid=${row2['RESERVATIONID']}" style="padding: 0px 5px;">
                                                    <span class="text-center text-dark">
                                                        <i class="fas fa-user-plus"></i></i> Assign
                                                    </span>
                                                </a>
                                            </c:when>

                                            <c:otherwise>
                                                <a class="btn btn-success btn-sm rounded-pill" style="padding: 0px 5px;">
                                                    <span class="text-center text-dark">
                                                        <i class="fas fa-user-plus"></i></i> Check
                                                    </span>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>
                                    <td>
                                        <a class="btn btn-outline-danger" href="delete_reservation?id=${row2['RESERVATIONID']}" onclick="if (confirm('Delete selected item?')){return true;}else{event.stopPropagation(); event.preventDefault();};"><i class="far fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Table Category -->
            <div class="row bg-secondary" id="tableCategory">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of All Category</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <table class="table table-hover text-center" >
                        <!-- column headers -->
                        <thead>
                            <tr>
                                <th>#</th>

                                <th>Type</th>
                                <th>Description</th>
                                <th>Size</th>
                                <th>Suitable</th>
                                <th>Price</th>

                                <th>Action</th>

                                <th>Image</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row3" items="${result3.rows}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>${row3['NAME']}</td>
                                    <td style="width: 300px;">${row3['DESCRIPTION']}</td>
                                    <td>${row3['SQFT']}</td>
                                    <td>${row3['SUITABLE']}</td>
                                    <td>${row3['PRICE']}</td>

                                    <td>
                                        <a class="btn btn-outline-info" href="detail-category.jsp?id=${row3['CATEGORYID']}"><i class="fas fa-info-circle text-muted"></i></a>
                                        <a class="btn btn-outline-primary" href="update-category.jsp?id=${row3['CATEGORYID']}"><i class="far fa-edit"></i></a>
                                        <a class="btn btn-outline-danger" href="delete_category?id=${row3['CATEGORYID']}" onclick="if (confirm('Delete selected item?')){return true;}else{event.stopPropagation(); event.preventDefault();};"onclick="if (confirm('Delete selected item?')){return true;}else{event.stopPropagation(); event.preventDefault();};"><i class="far fa-trash-alt"></i></a>
                                    </td>
                                    
                                    <td>
                                        <img src="media/img/category/${row3['IMAGE']}" alt="alt"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Table Facility -->
            <div class="row bg-secondary" id="tableFacility">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of All Facility</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <table class="table table-hover text-center" >
                        <!-- column headers -->
                        <thead>
                            <tr>
                                <th>#</th>

                                <th>Name</th>
                                <th>Type</th>
                                <th>Icon</th>

                                <th>Action</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row4" items="${result4.rows}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>

                                    <td>${row4['NAME']}</td>
                                    <td>${row4['TYPE']}</td>
                                    <td style="font-size: 50px;">${row4['ICON']}</td>

                                    <td>
                                        <a class="btn btn-outline-primary" href="update-facility.jsp?id=${row4['FACILITYID']}"><i class="far fa-edit"></i></a>
                                        <a class="btn btn-outline-danger" href="delete_facility?id=${row4['FACILITYID']}" onclick="if (confirm('Delete selected item?')){return true;}else{event.stopPropagation(); event.preventDefault();};"><i class="far fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Table Staff -->
            <div class="row bg-secondary" id="tableStaff">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of All Staff</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <table class="table table-hover text-center" id="tableStaff">
                        <!-- column headers -->
                        <thead>
                            <tr>
                                <th>#</th>

                                <th>Fullname</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Position</th>
                                <th>Status</th>
                                <th>Manager</th>

                                <th>Action</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row5" items="${result5.rows}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>

                                    <td>${row5['FULLNAME']}</td>
                                    <td>${row5['EMAIL']}</td>
                                    <td>${row5['PHONE']}</td>
                                    <td>${row5['ADDRESS']}</td>
                                    <td>${row5['POSITION']}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${row5['STATUS'] == 'Off'}">
                                                <a class="nav nav-link text-muted">Inactive</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="nav nav-link text-success">Active</a>
                                            </c:otherwise>
                                        </c:choose>


                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${row5['MANAGER']==0 || row5['MANAGER']==null}">
                                                -
                                            </c:when>
                                            <c:otherwise>
                                                ${row5['MANAGER']}
                                            </c:otherwise>
                                        </c:choose>

                                    </td>

                                    <td>
                                        <a class="btn btn-outline-primary" href="update-staff.jsp?id=${row5['STAFFID']}"><i class="far fa-edit"></i></a>
                                        <a class="btn btn-outline-danger" id="deleteStaff" href="delete_staff?id=${row5['STAFFID']}" onclick="if (confirm('Delete selected item?')){return true;}else{event.stopPropagation(); event.preventDefault();};"><i class="far fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
                
            <!-- Table Promotion -->    
            <div class="row bg-secondary" id="tablePromotion">
                
                <div class="row mb-5 bg-white">
                    <h1 class="text-center">List of All Promotion</h1>
                </div>
                
                <div class="row my-3 bg-white">
                    <table class="table table-hover text-center">
                        <!-- column headers -->

                        <thead>
                            <tr>
                                <c:forEach var="columnName" items="${result6.columnNames}" varStatus="totalColumn">
                                    <th> ${columnName} </th>
                                    <c:set var="tc" value="${totalColumn.count}" />
                                </c:forEach>

                                <th>Action</th>
                            </tr>
                        </thead>

                        <!-- column data -->
                       <tbody>
                            <c:forEach var="row6" items="${result6.rows}" varStatus="counter">
                                <tr>

                                    <td>${row6[i]}</td>

                                    <td>
                                        <a class="btn btn-outline-primary" href="update-staff.jsp?id=${row[0]}"><i class="far fa-edit"></i></a>
                                        <a class="btn btn-outline-danger" href="?"><i class="far fa-trash-alt"></i></a>
                                    </td>
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
            
        <!-- import all important js -->
        <jsp:include page="include/import-script.jsp"/>
        
        <!-- Script for pie chart -->
        <script>
            const ctx1 = document.getElementById('myChart1');
            const myChart1 = new Chart(ctx1, {
                type: 'doughnut',
                data: {
                    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                    datasets: [{
                        data: [12, 19, 3, 5, 2, 3],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 2
                    }]
                }
            });
            
            const ctx2 = document.getElementById('myChart2');
            const myChart2 = new Chart(ctx2, {
                type: 'doughnut',
                data: {
                    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                    datasets: [{
                        data: [12, 19, 3, 5, 2, 3],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 2
                    }]
                }
            });
        </script>
        
        <!-- Script for Organizing List -->
        <script>
            hideAll();
            $("#chartCard").show();
            
            function hideAll(){
                $("#chartCard").hide();
                $("#functionAll").hide();
                $("#tableRoom").hide();
                $("#tableReservation").hide();
                $("#tableCategory").hide();
                $("#tableFacility").hide();
                $("#tableStaff").hide();
                $("#tablePromotion").hide();
                $("#editProfile").hide();
                $("#poppup").hide();
                $("#regRoom").hide();
                $("#regCategory").hide();
            }
            
            function dashboard(){
                hideAll();
                $("#chartCard").show();
            }
            
            function viewReservation(){
                hideAll();
                $("#tableReservation").show();
            }
            function viewRoom(){
                hideAll();
                $("#tableRoom").show();
            }
            function viewCategory(){
                hideAll();
                $("#tableCategory").show();
            }
            function viewFacility(){
                hideAll();
                $("#tableFacility").show();
            }
            function viewStaff(){
                hideAll();
                $("#tableStaff").show();
            }
            function viewPromotion(){
                hideAll();
                $("#tablePromotion").show();
            }
            function viewEditProfile(){
                hideAll();
                $("#editProfile").show();
            }
            function viewRoomForm(){
                hideAll();
                $("#regRoom").show();
            }
            function viewCategoryForm(){
                hideAll();
                $("#regCategory").show();
            }
        </script>
        
        <!-- Ajax script to edit staff -->
        <script>
            function take_value_category(){
                var name = document.forms["formCategory"]["categoryName"].value;
                var description = document.forms["formCategory"]["categoryDescription"].value;
                var size = document.forms["formCategory"]["categorySize"].value;
                var suit = document.forms["formCategory"]["categorySuit"].value;
                var price = document.forms["formCategory"]["categoryPrice"].value;
                var deposit = document.forms["formCategory"]["categoryDeposit"].value;
                var facility = document.forms["formCategory"]["categoryFacility"].value;
                var image = document.forms["formCategory"]["categoryImage"].value;
               
                var http = new XMLHttpRequest();
                
                http.open("POST", "add_detail", true);
                http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                
                var params1 = "name=" + name + "&description=" + description + "&size=" + size + "&suit=" + suit + "&price=" + price + "&deposit=" + deposit + "&facility=" + facility + "&image=" + image ;
                
                http.send(params1);
                
                http.onload = function() {
//                    $("#poppup").show();
//                    document.getElementById('error').innerHTML = 'Success';
                    alert("http.responseText");
                };
            }
            
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
