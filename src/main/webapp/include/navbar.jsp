<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header content -->
<div class="container mt-5">
    <!-- Nav bar -->
    <header class="mb-3 fixed-top header" id="header">
        <nav class="navbar mb-3 fixed-top navbar-expand-lg navbar-light">
            <div class="container">
                
                <c:choose>
                    <c:when test="${account.id != null}">
                        <a href="dashboard-user.jsp" class="navbar-brand">
                            <img src="media/img/logo.png" alt="logo" width="70" height="70" class="d-inline-block align-top"/>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="homepage.jsp" class="navbar-brand">
                            <img src="media/img/logo.png" alt="logo" width="70" height="70" class="d-inline-block align-top"/>
                        </a>
                    </c:otherwise>
                </c:choose>

                <button class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#toggleMobileMenu"
                        aria-controls="toggleMobileMenu"
                        aria-expanded="false"
                        aria-lable="Toggle navigation"
                >
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="toggleMobileMenu">
                    <ul class="navbar-nav ms-auto text-center">
                        <li> 
                            <c:choose>
                                <c:when test="${account.id != null}">
                                    <a href="dashboard-user.jsp" class="nav-link">Home</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="homepage.jsp" class="nav-link">Home</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <li>
                            <a href="#" class="nav-link">About Us</a>
                        </li>
                        <li>
                            <a href="#" class="nav-link">Services</a>
                        </li>
                        <li>
                            <a href="#" class="nav-link">Contact Us</a>
                        </li>
                        <c:if test="${account.id != null}">
                            <li>
                                <a href="booking-detail.jsp" class="nav-link">Booking Detail</a>
                            </li>
                        </c:if>
                        <li>
                            <c:choose>
                                <c:when test="${account.id != null}">
                                    
                                    
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-user"></i> ${account.fullname}<span class="sr-only"></span>
                                        </button>
                                        
                                        <div class="dropdown-menu">
                                            
                                            <form action="user-info.jsp" method="post">
                                                <input type="hidden" name="userid" value="${account.id}">
                                                <input type="hidden" name="viewProfile" value="1">
                                                <button type="submit" class="dropdown-item">User Profile</button>
                                            </form>
                                                
                                            <a class="dropdown-item" href="change-password-user.jsp">Change Password</a>    
                                            <div class="dropdown-divider"></div>
                                            <a href="logout" class="dropdown-item text-center text-danger">Logout</a>
                                        </div>
                                    </div>
                                </c:when>
                                    
                                <c:otherwise>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-outline-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-user"></i> <span>Login</span>
                                        </button>
                                        
                                        <div class="dropdown-menu">
                                            <a href="login-user.jsp" class="dropdown-item text-primary">USER</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="login-staff.jsp">STAFF</a>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            
                        </li>
                        
                    </ul>
                </div>
            </div>
        </nav>
    </header>
</div>      
