<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>

<%@page import="bean.Reservation"%>
<%@page import="dao.ReservationDao"%>
<%@page import="bean.MyConnection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />

<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM categories
</sql:query>
    
<sql:query var="result2" dataSource="${myDatasource}">
    SELECT * FROM reservations
</sql:query>

<sql:query var="room" dataSource="${myDatasource}">
    SELECT * FROM rooms WHERE roomid = ${param.roomid}
</sql:query>
    
<sql:query var="price" dataSource="${myDatasource}">
    SELECT price FROM rooms JOIN categories USING (categoryid)
    WHERE roomid = ${param.roomid}
</sql:query>
    
<sql:query var="categoryname" dataSource="${myDatasource}">
    SELECT name FROM categories
    WHERE categoryid = ${param.categoryid}
</sql:query>
    
    
    

<% 
    // get parameter get
    String roomid = request.getParameter("roomid");

    // get Object of bean
    Reservation rs = new Reservation();
    
    // get object of dao
    ReservationDao rsd = new ReservationDao(MyConnection.getConnection());
    
    List dates = rsd.disableDate(roomid);
    
    request.setAttribute("disableDate", dates);
  
%>

<script>
    
    var dateSizes = '${disableDate}'.length;
    var dd = '${disableDate}'.substr(1,dateSizes-2);
    var dateList = dd.split(",");
    
</script>
   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Page</title>
        
        <jsp:include page="include/import-style.jsp"/>
        
        <style>
            body{
                padding-top: 100px;
            }
        </style>
        
    </head>
    
    
    <body>
        <jsp:include page="include/navbar.jsp"/>
            
        <!--show Error if user wrongly input any information-->    
        <div class="container">
            <c:forTokens var = "resultErr" items = "${errorMsgs}" delims = "," >
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${resultErr}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:forTokens>
        </div>
        
        <!-- ## All content appear here ## -->
        <div class="d-flex justify-content-center " >
            <div class="login-content shadow p-5 rounded-5" style="width: 750px;">
                <h1 class="text-center my-3">Book Room</h1> 
                <form action="add_reservation" method="post" autocomplete="off">
                    
                    <div class="form-group mt-3">
                        <label>Category</label>
                        <input type="text" name="categoryname" id="fullname" class="form-control" value="${categoryname.rows[0]['name']}" readonly>
                        <input type="hidden" name="categoryid" id="fullname" class="form-control" value="${param.categoryid}" readonly>
                    </div>
                    
                    <!-- RoomNo for category user chosen -->
                    <div class="form-group mt-3">
                        <label>Room No</label>
                        <input type="text" name="roomno" id="fullname" class="form-control" value="${room.rows[0]['roomno']}" readonly>
                        <input type="hidden" name="roomid" id="fullname" class="form-control" value="${room.rows[0]['roomid']}" readonly>
                    </div>
                    
                    
                    
                    <!-- Date Input -->
                    <div class="row my-3 ">
                        <div class="col d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                                <label>Check In Date</label>
                                <input type="text" name="datestart" id="datestart" class="form-control text-center">
                            </div>
                        </div>
                        
                        <div class="col d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                                <label>Check Out Date</label>
                                <input type="text" name="dateend" id="dateend" class="form-control text-center">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Date Input -->
                    <div class="row my-3 ">
                        <div class="col d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                                <label>Total Adult</label>
                                <input type="number" min="1" value="1" name="totaladult" class="form-control text-center">
                            </div>
                        </div>
                        
                        <div class="col d-flex justify-content-center">
                            <div class="form-group text-center" style="width: 300px;">
                                <label>Total Child</label>
                                <input type="number" min="0" value="0" name="totalchild" id="dateend" class="form-control text-center">
                            </div>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <div class="form-group mt-3">
                        <label>Fullname</label>
                        <input type="text" name="fullname" id="fullname" class="form-control" placeholder="Fullname" value="${account.fullname}" size="30px">
                    </div>

                    <div class="form-group mt-3">
                        <label>Email</label>
                        <input type="text" name="email" id="email" class="form-control" placeholder="Email" value="${account.email}" size="30px">
                    </div>

                    <div class="form-group mt-3">
                        <label>Phone</label>
                        <input type="text" name="phone" id="phone" class="form-control" placeholder="Phone" value="${account.phone}" size="30px">
                    </div>

                    <div class="form-group mt-3 text-end">
                        <c:forEach var="row" items="${price.rows}" > 
                            <input type="hidden" name="price" value="${row['PRICE']}">
                        </c:forEach>
                        <input class="btn btn-info" type="submit" value="Book" >
                    </div>
                </form>
            </div>
        </div>
                    
        <br><hr><br>
        
        <!-- List of Room -->
        <div class="container">
            <h1 class="text-center mb-5">List of Room</h1>
            <div class="row text-center">
                    <c:forEach var="row" items="${result.rows}">
                        <div class="col-4">
                            <div class="card my-3 mx-2" style="width: 400px;">
                                <img class="card-img-top rounded-top" src="media/img/category/${row['IMAGE']}">
                                
                                <div class="card-body bg-warning">
                                    <h5 class="card-title">${row['NAME']}</h5>
                                </div>
                                <div class="card-body" style="height: 130px;">
                                    <p class="card-text">${row['DESCRIPTION']}</p>
                                </div>
                                
                                <sql:query var="result2" dataSource="${myDatasource}">
                                    SELECT * FROM categories JOIN rooms USING(categoryid)
                                    WHERE categoryid = ${row['CATEGORYID']}
                                </sql:query>
                                <form action="book_room" method="get">
                                    <div class="card-header">
                                        <input type="hidden" name="categoryid" value="${row['CATEGORYID']}">
                                        <select name="roomid" size="3">
                                            <c:forEach var="row1" items="${result2.rows}" > 
                                                <option value="${row1['roomid']}">${row1['roomno']}</option>
                                            </c:forEach>
                                        </select>
                                        <input type="submit" class="btn btn-primary" value="Book Now">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
        </div>
        
        <jsp:include page="include/import-script.jsp"/>
        
        <script>
            // object of date
            var array = ["2022-01-28","2022-01-30","2022-02-1", "2022-01-13", "2022-01-20"];
            var trima = [];

            for (i = 0; i < dateList.length; i++ ) {
                trima.push(dateList[i].trim().substring(10,""));
            }

            $('#datestart').datepicker({
                beforeShowDay: function(date){
                    var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    return [ trima.indexOf(string) == -1 ];
                },
                minDate:new Date(),
                dateFormat: 'dd/mm/yy'
            });
            
            $('#dateend').datepicker({
                beforeShowDay: function(date){
                    var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    return [ trima.indexOf(string) == -1 ];
                },
                minDate:new Date(),
                dateFormat: 'dd/mm/yy'
            });
            
        </script>           
        
        <script>
            // disable previous date and forward date | START
            var date = new Date();
            date.setDate(date.getDate() + 90);
            var today = new Date().toISOString().split('T')[0];
            var maxDate = date.toISOString().split('T')[0];
            document.getElementsByName("datestart")[0].setAttribute('min', today);
            // disable previous date and forward date
            document.getElementsByName("datestart")[0].setAttribute('max', maxDate);
            
            // disable previous date and forward date | END
            var date = new Date();
            date.setDate(date.getDate() + 90);
            var today = new Date().toISOString().split('T')[0];
            var maxDate = date.toISOString().split('T')[0];
            document.getElementsByName("dateend")[0].setAttribute('min', today);
            // disable previous date and forward date
            document.getElementsByName("dateend")[0].setAttribute('max', maxDate);
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
