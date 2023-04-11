<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="myDatasource" 
                   driver="com.mysql.cj.jdbc.Driver" 
                   url="jdbc:mysql://localhost:3306/dtech hotel" 
                   user="root" 
                   password=""
                   />
<!-- Sql Query to list out all Facility -->
<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM facilities
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Room Page</title>
        <jsp:include page="include/import-style.jsp"/>
        <style>
            tr,td{
                padding: 10px;
            }
            .icon{
                font-size: 25px;
            }
            .myForm{
                width: 600px;
            }
        </style>
    </head>
    <body>
        
        <div class="container">
            <c:forTokens var = "result1" items = "${errorMsgs}" delims = "," >
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fal fa-exclamation-circle"></i> | ${result1}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:forTokens>
        </div>
        
        
        <div class="container shadow myForm">
            <div class="d-flex justify-content-center p-5 mt-5 ">
                <form class="mt-3" action="add_detail" method="POST" autocomplete="off">
                    <h1>Add New Category</h1>
                    
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Category Name" value="${param.name}" size="30px">
                    </div>
                    
                    <div class="form-group mt-3">
                        <label>Description</label> <br>
                        <textarea style="resize: none;" rows="4" cols="50" name="description" placeholder="Description of Category">${param.description}</textarea>
                    </div>
                    
                    <div class="form-group mt-3">
                        <label>Size</label>
                        <input type="text" name="size" class="form-control" placeholder="Size" value="${param.size}" size="30px">
                        <label><small>unit in sqft</small></label>
                    </div>
                    
                    <!-- Checkbox suitable for -->
                    <label class="mt-3 fw-bold">Suitable For</label>
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
                    
                    <!-- Facility -->
                    <label class="mt-3">Facility</label>
                    <div class="row">
                        <c:forEach var="row" items="${result.rows}" > 
                            <div class="col-auto m-3 form-check">
                                <input type="checkbox" id="${row['NAME']}" class="form-check-input" name="facility" value="${row['FACILITYID']}">
                                <label for="${row['NAME']}">${row['ICON']}</label>
                            </div>
                        </c:forEach>
                        
                        <div class="col text-end p-3">
                            <input type="button" value="Select All" style="font-size: 16px;" onclick="selectAll();">
                            <input type="button" value="Deselect All" style="font-size: 16px;" onclick="deselectAll();">
                        </div>
                    </div>
                    
                    <!-- Price -->
                    <div class="form-group mt-3">
                        <label>Price</label>
                        <input type="text" name="price" id="price" class="form-control" placeholder="Price" value="${param.price}" size="30px">
                    </div>

                    <div class="form-group mt-3">
                        <label>Deposit</label>
                        <input type="text" name="deposit" id="deposit" class="form-control" placeholder="Deposit" value="${param.deposit}" size="30px">
                    </div>
                    
                    <div class="form-group mt-3">
                        <label>Image</label>
                        <input type="file" name="image" id="imagecategory" class="form-control" placeholder="Size" value="${param.roomsize}" size="30px">
                    </div>
                    
                    <div class="form-group mt-3 text-end">
                        <input class="btn btn-warning" type="reset" name="reset">
                        <input class="btn btn-info" type="submit" value="Create" name="submit">
                    </div>
                    
                    <a href="dashboard-manager.jsp">Go Back</a>
                </form>
            </div>
        </div>      
                        
        <script>
            function selectAll(){
                var checkboxes = document.getElementsByName('facility');
                                
                for(var i=0; i<checkboxes.length; i++){  
                    checkboxes[i].checked = true; 
                }
            }
            function deselectAll(){
                var checkboxes = document.getElementsByName('facility');
                                
                for(var i=0; i<checkboxes.length; i++){  
                    checkboxes[i].checked = false; 
                }
            }
        </script>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
