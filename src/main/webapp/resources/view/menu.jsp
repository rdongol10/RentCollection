<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
    <link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/datatables.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/fonts/fontawesome/css/fontawesome-all.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
	<title>Menu</title>
</head>
<body>
    <!-- ============================================================== -->
        <!-- navbar -->
        <!-- ============================================================== -->
        <div class="dashboard-header">
        	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
            <nav class="navbar navbar-expand-lg bg-white fixed-top">
                <a class="navbar-brand" href="${contextPath}/">Renting</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse " id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto navbar-right-top">
                        <li class="nav-item dropdown nav-user">
                            <a class="nav-link nav-user-img" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${contextPath}/resources/images/avatar-1.jpg" alt="" class="user-avatar-md rounded-circle"></a>
                            <div class="dropdown-menu dropdown-menu-right nav-user-dropdown" aria-labelledby="navbarDropdownMenuLink2">
                                <div class="nav-user-info">
                                    <h5 class="mb-0 text-white nav-user-name">John Abraham </h5>
                                    <span class="status"></span><span class="ml-2">Available</span>
                                </div>
                                <a class="dropdown-item" href="#"><i class="fas fa-user mr-2"></i>Account</a>
                                <a class="dropdown-item" href="#"><i class="fas fa-cog mr-2"></i>Setting</a>
                                <a class="dropdown-item" href="#"><i class="fas fa-power-off mr-2"></i>Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <!-- ============================================================== -->
        <!-- end navbar -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- left sidebar -->
        <!-- ============================================================== -->
        <div class="nav-left-sidebar sidebar-dark">
            <div class="menu-list">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="d-xl-none d-lg-none" href="#">Dashboard</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav flex-column">
                            <li class="nav-divider">
                                Menu
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#submenu-1" aria-controls="submenu-1">Users </a>
                                <div id="submenu-1" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listUsers.jsp">List Users</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/addUser.jsp">Add Users</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#serviceMenu" aria-controls="serviceMenu">Service</a>
                                <div id="serviceMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listServices.jsp">List Service</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/addService.jsp">Add Service</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#rentingMenu" aria-controls="rentingMenu">Renting</a>
                                <div id="rentingMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listRentings.jsp">List Renting</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/addRenting.jsp">Add Renting</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#renteeMenu" aria-controls="renteeMenu">Rentee</a>
                                <div id="renteeMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listRentee.jsp">List Rentee</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/addRentee.jsp">Add Rentee</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#contractMenu" aria-controls="#contractMenu">Contract</a>
                                <div id="contractMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listContracts.jsp">List Contracts</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/createContract.jsp">Create Contract</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#transactionMenu" aria-controls="#transactionMenu">Transactions</a>
                                <div id="transactionMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listTransactions.jsp">List Transactions</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/duePayments.jsp">Remaining Payments</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- end left sidebar -->
        <!-- ============================================================== -->

</body>
<script src="<c:url value="/resources/js/jquery-3.3.1.min.js" />" ></script>
<script src="<c:url value="/resources/js/datatables.js" />" ></script>
<script src="<c:url value="/resources/js/jquery-ui.js" />" ></script>
<script src="<c:url value="/resources/js/bootstrap.bundle.js" />" ></script>
</html>
 