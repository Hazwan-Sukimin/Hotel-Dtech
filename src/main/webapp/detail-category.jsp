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

<sql:query var="facility" dataSource="${myDatasource}">
    SELECT * FROM categories JOIN categoryfacilities USING(categoryid)
    JOIN facilities USING(facilityid) WHERE categoryid = ${param.id}
</sql:query>
    
<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM categories WHERE categoryid = ${param.id}
</sql:query>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/import-style.jsp"/>
    </head>
    
    <body>
        <div class="d-flex justify-content-center mt-5">
                
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
                    <input type="text" name="name" id="name" class="form-control" placeholder="Size" value="${row['size']}" size="30px">
                </div>

                <div class="form-group mt-4">
                    <label>Suitable</label>
                    <input type="text" name="name" id="name" class="form-control" placeholder="Suitable" value="${row['suitable']}" size="30px">
                </div>

                <div class="form-group mt-4">
                    <label>Price</label>
                    <input type="text" name="name" id="name" class="form-control" placeholder="Price" value="${row['price']}" size="30px">
                </div>

                <div class="form-group my-4">
                    <label>Current Image</label>
                    <img class="form-control" src="media/img/category/${row['image']}" alt="alt"/>
                    <input type="file" name="name" id="name" class="form-control" placeholder="Name" value="asd" size="30px">
                </div>

                <div class="form-group my-4 text-end">
                    <input type="submit" name="name" id="name" class="btn btn-primary" value="Update" size="30px">
                </div>
            </c:forEach>
        </div>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
