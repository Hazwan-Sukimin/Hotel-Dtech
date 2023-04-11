<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage Page</title>
        
        <jsp:include page="include/import-style.jsp"/>
        
        <style>
            a,ul,li{
                font-size: 20px;
                margin-right: 10px;
            }
            .btn-outline-primary {
                margin-top: 5px; 
                padding: 5px 10px;
                /* define values in pixels / Percentage or em. whatever suits 
                   your requirements */
            }
        </style>
    </head>
    <body>
        <!-- Carousel + Navbar-->
        <jsp:include page="include/carousel.jsp"/>
        <jsp:include page="include/navbar.jsp"/>
        
        <!-- ## All content appear here ## -->
        <div class="container">
            <div class="row text-center">
                <div class="col-3">
                    hello
                </div>
                <div class="col-3">
                    hello
                </div>
                <div class="col-3">
                    hello
                </div>
                <div class="col-3">
                    hello
                </div>
            </div>
        </div>
            
          
        <!-- Footer Content -->
        <jsp:include page="include/footer.jsp"/>
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
        <jsp:include page="include/import-script.jsp"/>
    </body>
</html>
