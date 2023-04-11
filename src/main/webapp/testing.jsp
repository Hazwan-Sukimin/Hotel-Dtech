<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/import-style.jsp"/>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <div class="container">
            ${staff.toString()}
        </div>
        
        <button class="show">
            Click Me
        </button>
        
        <script>
            $(document).ready(function(){
                $(".show").click(function(){
                    Swal.fire({
                        title: '<strong>Are you sure?</strong>',
                        icon: 'warning',
                        html:`You really can't go back after this, We can't retrieve it either!`,
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        reverseButtons: true,
                        focusCancel: true,
                        cancelButtonText:`Blue pill`,
                        confirmButtonText:`Red pill`
                    }).then((result) => {
                        if (result.value) {
                            window.location.href = 'login-staff.jsp'
                        }
                    });
                });
            });
        </script>
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
