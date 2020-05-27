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
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3"  id="duePaymentsContainer" style="display:none">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-danger-light">
									<i class="fas fa-money-check-alt fa-2x text-danger homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Due Payments
								</div> 
								
								<div class="notification" id="duePaymentCount">
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="expiredContractsContainer" style="display:none">
						<div class="card homeIconContainer" >
							<div class="card-body ">
								<div class="homeIcon bg-danger-light">
									<i class="fas fa-file-signature fa-2x text-danger homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Expired Contracts
								</div> 
								
								<div class="notification" id="expiredContractsCount">
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="renteesContainer">
						<div class="card homeIconContainer" >
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
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="rentingsContainer">
						<div class="card homeIconContainer" >
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
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="servicesContainer">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-info-light">
									<i class="fas fa-laptop-house fa-2x text-info homeIconImage" ></i>
								</div>
								<div class="homeIconText">
									Services
								</div> 
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="contractsContainer">
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
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="transactionContainer">
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
		</div>	
	</div>
</body>

<script type="text/javascript">

	jQuery(document).ready(function(){
		
		getUnpaidBillsCount();
		getExpiredContractsCount();
		
		jQuery("#duePaymentsContainer").on("click",function(){
			window.open("${contextPath}/resources/view/duePayments.jsp","_blank");
		})
		
		jQuery("#expiredContractsContainer").on("click",function(){
			window.open("${contextPath}/resources/view/expiredContracts.jsp","_blank");
		})
		
		jQuery("#renteesContainer").on("click",function(){
			window.open("${contextPath}/resources/view/listRentee.jsp","_blank");
		})
		
		jQuery("#rentingsContainer").on("click",function(){
			window.open("${contextPath}/resources/view/listRentings.jsp","_blank");
		})
		
		jQuery("#servicesContainer").on("click",function(){
			window.open("${contextPath}/resources/view/listServices.jsp","_blank");
		})
		
		jQuery("#contractsContainer").on("click",function(){
			window.open("${contextPath}/resources/view/listContracts.jsp","_blank");
		})
		
		jQuery("#transactionContainer").on("click",function(){
			window.open("${contextPath}/resources/view/listTransactions.jsp","_blank");
		})
	})
	
	function getUnpaidBillsCount(){
		jQuery.ajax({
			method:"GET",
			url :"${contextPath}/transaction/countUnpaidBills"
		}).done(function(data){
			displayDuePayments(data)
		});
	}
	
	function getExpiredContractsCount(){
		jQuery.ajax({
			method:"GET",
			url :"${contextPath}/contract/countExpiredContracts"
		}).done(function(data){
			displayExpiredContracts(data)
		});
	}
	
	function displayDuePayments(data){
		if(parseInt(data) > 0){
			jQuery("#duePaymentCount").html(data + " due")
			jQuery("#duePaymentsContainer").show()
		}
	}
	
	function displayExpiredContracts(data){
		if(parseInt(data) > 0){
			jQuery("#expiredContractsCount").html(data + " expired")
			jQuery("#expiredContractsContainer").show()
		}
	}
</script>
</html>