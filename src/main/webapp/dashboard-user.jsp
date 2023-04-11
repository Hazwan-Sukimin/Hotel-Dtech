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
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Dashboard</title>
        <%@ include file="include/import-style.jsp" %>
        
        <style>
            a{
                text-decoration: none;
            }
            
            table{
                width: 100px;
            }
            
            a,ul,li{
                font-size: 20px;
                margin-right: 10px;
                list-style: none;
            }
            button{
                font-size: 20px;
            }
            .btn-outline-primary {
                margin-top: 5px; 
                padding: 5px 10px;
                /* define values in pixels / Percentage or em. whatever suits 
                   your requirements */
            }
            .card{
                box-shadow: 8px 14px 38px rgba(39,44,49,.06), 1px 3px 8px rgba(39,44,49,.03);
                transition: all .5s ease; /* back to normal */
            }
            .card:hover{
                transform: translate3D(0,-1px,0) scale(1.05);
            }
        </style>
    </head>
    <body>
        <jsp:include page="include/carousel.jsp"/>
        
        <div class="container mt-5">
            <jsp:include page="include/navbar.jsp"/>

            <!-- ## All content appear here ## -->
            <hr>  
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
                                        <select class="form-control" name="roomid" size="3">
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
            
            <jsp:include page="include/footer.jsp"/>
            
        </div>
        <!-- Navbar Responsiveness -->
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
            
//            $(document).ready(function(){
//                $(".booknow").click(function(){
//                    $("#poppup").show();
//                });      
//            });
        </script>
        
        <script>
            // Get the modal
            var modal = document.getElementById("myModal");

            // Get the button that opens the modal
            var btn = document.getElementById("myBtn");

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

            // When the user clicks the button, open the modal 
            
            $(".booknow").click(function(){
                $("#myModal").show();
            });

            // When the user clicks on <span> (x), close the modal
            span.onclick = function() {
              modal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
              if (event.target == modal) {
                modal.style.display = "none";
              }
            }
        </script>
        <%@ include file="include/import-script.jsp" %>
    </body>
</html>
