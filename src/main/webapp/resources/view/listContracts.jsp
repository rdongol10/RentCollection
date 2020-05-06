<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">

<title>Contracts</title>
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
					 				
						 				Service Lists
						 				
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
											    <th>Payment Type</th>
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
</body>

<script type="text/javascript">
	var table;
	jQuery(document).ready(function(){
		
		loadTableData();
		
	});
	
	function loadTableData(){
		table = jQuery("#contractTable").DataTable({
			"processing": true,
			"serverSide": true,
			"ajax":{
				"url":"${contextPath}/contract/listContracts",
				 "type": "POST",
				 "contentType": "application/json",
				 "data": function(data){
					return JSON.stringify(data);
				}
			},
			"columns":[
				{data : 0 , name:"name"},
				{data : 1 , name:"first_name"},
				{data : 2 , name:"start_date"},
				{data : 3 , name:"payment_type"},
				{data : 4 , name:"last_paid_date"},
				{data : 5 , name:"last_paid_date"},
				{data : 6 , name:"actions",searchable : false , orderable:false}
			]
		});
	}
</script>
</html>