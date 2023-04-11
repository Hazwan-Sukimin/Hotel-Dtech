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
    WHERE categoryid = ${param.id}
</sql:query>
    
        
<sql:query var="facility" dataSource="${myDatasource}">
    SELECT * FROM categories 
    JOIN categoryfacilities USING(categoryid) 
    JOIN facilities USING(facilityid)
    WHERE categoryid = ${param.id}
</sql:query>
    
<sql:query var="all" dataSource="${myDatasource}">
    SELECT * FROM facilities
</sql:query>

    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Category Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            img{
                width: 200px;
                height: 200px;
            }
        </style>
    </head>
    <body>
        <div class="d-flex justify-content-center mt-5">
            <form action="update_category" method="post">
                <input type="hidden" name="id" value="${param.id}">
                <h1>Update Room Category</h1>
                <c:forEach var="row" items="${result.rows}">
                    <div class="form-group mt-4">
                        <label>Name</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="Name" value="${row['NAME']}" size="30px">
                    </div>
                    
                    <div class="form-group mt-4">
                        <label>Description</label>
                        <textarea class="form-control" style="resize: none;" rows="4" cols="50" name="description" placeholder="Description of Category">${row['DESCRIPTION']}</textarea>
                    </div>
                    
                    <div class="form-group mt-4">
                        <label>Size</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="Size" value="${row['sqft']}" size="30px">
                        <small>in sqft</small>
                    </div>
                    
                    <!-- Checkbox suitable for -->
                    <label class="mt-3 fw-bold">Suitable For</label>
                    <input type="text" class="form-control" value="${row['suitable']}" readonly>
                    <div class="row">
                        <div class="col-3 m-3 form-check">
                            <input type="checkbox" id="Backpacker" class="form-check-input" name="suitable" value="Backpackers">
                            <label for="Backpacker">Backpacker</label>
                        </div>
                        <div class="col-3 m-3 form-check">
                            <input type="checkbox" id="family" class="form-check-input" name="suitable" value="Family">
                            <label for="family">Family</label>
                        </div>
                        <div class="col-3 m-3 form-check">
                            <input type="checkbox" id="traveller" class="form-check-input" name="suitable" value="Traveller">
                            <label for="traveller">Traveller</label>
                        </div>
                        <div class="col-3 m-3 form-check">
                            <input type="checkbox" id="business" class="form-check-input" name="suitable" value="Business">
                            <label for="business">Business</label>
                        </div>
                        <div class="col-3 m-3 form-check">
                            <input type="checkbox" id="couple" class="form-check-input" name="suitable" value="Couple">
                            <label for="couple">Couple</label>
                        </div>
                        <div class="col-3 m-3 form-check">
                            <input type="checkbox" id="budget" class="form-check-input" name="suitable" value="Budget">
                            <label for="budget">Budget</label>
                        </div>
                    </div>
                    
                    <label class="mt-3">Current Facility</label>
                    <div class="row text-muted">
                        
                        <c:forEach var="row1" items="${all.rows}" varStatus="counter">
                            <c:forEach var="col1" items="${facility.rows}">
                                <c:if test="${row1['name'] == col1['name']}">
                                    <div class="col-auto m-3 form-check">
                                        <input type="checkbox" id="${row1['NAME']}" class="form-check-input" name="facility" checked value="${row1['FACILITYID']}" disabled>
                                        <label for="${row1['NAME']}">${row1['ICON']}</label>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                    
                    <label class="mt-3">Choose new Facility</label>
                    <div class="row">
                        <c:forEach var="row1" items="${all.rows}" varStatus="counter">
                            <c:if test="${row1['name'] != col1['name']}">
                                <div class="col-auto m-3 form-check">
                                    <input type="checkbox" id="${row1['NAME']}" class="form-check-input" name="facility" value="${row1['FACILITYID']}">
                                    <label for="${row1['NAME']}">${row1['ICON']}</label>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                        
                    
                    <div class="form-group mt-4">
                        <label>Price</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="Price" value="${row['price']}" size="30px">
                    </div>
                    
                    <div class="form-group my-4">
                        <label>Current Image</label> <br>
                        <img class="form-group" src="media/img/category/${row['image']}" alt="alt"/>
                        <input type="file" name="name" id="name" class="form-control" placeholder="Name" value="asd" size="30px">
                    </div>
                    
                    <div class="form-group my-4 text-end">
                        <input type="submit" name="name" id="name" class="btn btn-primary" value="Update" size="30px">
                    </div>
                </c:forEach>
                    
                <a href="dashboard-manager.jsp">Go Back</a>
            </form>
        </div>
    </body>
</html>
