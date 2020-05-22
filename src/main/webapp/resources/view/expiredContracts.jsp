<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Expired Contracts</title>

<link href="<c:url value="/resources/css/displayDetails.css" />" rel="stylesheet">

</head>
<body>
<div class="dashboard-main-wrapper">
		<%@ include file="menu.jsp" %>  
	    <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
						 
						<div class="card ">
							<div class="card-header">
						 		<div class="row">
				                    <h2 class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-9 topCardHeader">
					 				
						 				Contract Lists
						 				
									</h2>
									
				                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
								        <a href="${contextPath}/resources/view/createContract.jsp" class="btn btn-success topAddButton" >
									    	<i class="fas fa-plus"></i>  &nbsp; Create Contract
										</a>
										
									</div>
								</div>
						 	</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered first" id="contractTable">
										<thead>
											<tr>
											    <th>Renting Name</th>
											    <th>Rentee Name</th>
											    <th>Start Date</th>
											    <th>Last Paid Date</th>
											    <th>Expire Date</th>
   											    <th>Actions</th>
											</tr>
										</thead>
									</table>	
								</div>
							</div>	
						</div>
					</div>
				</div>
			</div>	
		</div>	
	</div>
	
	<div class="modal fade" id="contractModal" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="contractModalLabel"></h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
</body>

	<script src="<c:url value="/resources/js/displayDetails.js" />" ></script>
	<script type="text/javascript">
		var table;
		jQuery(document).ready(function(){
			
			loadTableData();
			
			jQuery("#contractTable").on("click",".billContract",function(){
				
				billContract(jQuery(this).attr("contractid"))
	
			})
			
			jQuery("#contractTable").on("click",".details",function(){
				getDetails(jQuery(this).attr("rentingId"))
			})
			
		});
		
		function getDetails(rentingId){
	
			jQuery.ajax({
				
				method : "GET",
				url : "${contextPath}/renting/getRentingDetails/"+rentingId,
				
			}).done(function(data){
				displayDetails(data)
			})
		}
		
		function displayDetails(data){
			console.log(data)
			jQuery(".modal-title").html("Details")
			
			jQuery(".modal-body").html(getRentingDetailsHTML(data));
			jQuery('#contractModal').modal('show');
		}
		
		function billContract(contractId){
			window.location.href="${contextPath}/resources/view/billContract.jsp?id="+contractId;
		}
		
		function loadTableData(){
			table = jQuery("#contractTable").DataTable({
				"processing": true,
				"serverSide": true,
				"ajax":{
					"url":"${contextPath}/contract/listContracts",
					 "type": "POST",
					 "contentType": "application/json",
					 "data": function(data){
						data.expired = "true"; 
						return JSON.stringify(data);
					}
				},
				"columns":[
					{data : 0 , name:"name"},
					{data : 1 , name:"first_name"},
					{data : 2 , name:"start_date"},
					{data : 3 , name:"last_paid_date"},
					{data : 4 , name:"last_paid_date"},
					{data : 5 , name:"actions",searchable : false , orderable:false}
				]
			});
		}
	</script>
</html>
