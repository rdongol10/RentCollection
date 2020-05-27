<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
</head>
<body>
	<div class="dashboard-main-wrapper">

	<%@ include file="/resources/view/menu.jsp" %>  
	
	    <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">

				<div class="row">
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-danger-light">
									<i class="fas fa-money-check-alt fa-2x text-danger homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Due Payments
								</div> 
								
								<div class="notification">
									3 due
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-danger-light">
									<i class="fas fa-file-signature fa-2x text-danger homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Expired Contracts
								</div> 
								
								<div class="notification">
									3 expired
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-primary-light">
									<i class="fas fa-user fa-2x text-primary homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Rentees
								</div> 
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-warning-light">
									<i class="fas fa-home fa-2x text-warning homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Rentings
								</div> 
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-info-light">
									<i class="fas fa-laptop-house fa-2x text-info homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Services
								</div> 
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-violet-light">
									<i class="fas fa-file-signature fa-2x text-violet homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Contracts
								</div> 
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-success-light">
									<i class="fas fa-file-invoice-dollar fa-2x text-success homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Transactions
								</div> 
							</div>
						</div>
					</div>
				</div>
				</div>
				
				<div class="row">
					
				
			</div>	
		</div>	
	</div>
</body>
</html>