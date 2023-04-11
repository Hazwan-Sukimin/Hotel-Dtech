<!DOCTYPE html>
<html>
    <head>
        <title>Directory Pages</title>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <%@ include file="include/import-style.jsp" %>
        
        <style>
            body{
                font-family: 'Poppins', sans-serif !important;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <ul>
                <li>User Login <a href="login-user.jsp">Click Here</a></li>
                <li>Staff Login <a href="login-staff.jsp">Click Here</a></li>
            </ul>

        </div>
        
        <div class="container-fluid">
            <h1>Choose Type of User</h1>
            
            <ul>
                <h3>Login Page</h3>
                <li>User Login <a href="login-user.jsp">Click Here</a></li>
                <li>Staff Login <a href="login-staff.jsp">Click Here</a></li>
                <hr>
                <h3>Dashboard Page</h3>
                <li>Manager: <a href="dashboard-manager.jsp">Click Here</a></li>
                <li>Staff: <a href="dashboard-staff.jsp">Click Here</a></li>
                <li>User: <a href="dashboard-user.jsp">Click Here</a></li>

                <hr>
                <h3>Register new "row" Page</h3>
                <li>User: <a href="register-user.jsp">Click Here</a></li>
                <li>Staff: <a href="register-staff.jsp">Click Here</a></li>
                <li>Room Details: <a href="staff-login.jsp">Click Here</a></li>
                <li>Room: <a href="staff-login.jsp">Click Here</a></li>
                <li>Facility: <a href="staff-login.jsp">Click Here</a></li>
                <li>Reservation: <a href="staff-login.jsp">Click Here</a></li>
                <li>Payment: <a href="staff-login.jsp">Click Here</a></li>
                <li>Promotions: <a href="register-promotion.jsp">Click Here</a></li>

                <hr>
                <h3>View Information Page</h3>
                <li>All Information <a href="Dummy-View.jsp">Click Here</a></li>


            </ul>
        </div>
        
    </body>
</html>
