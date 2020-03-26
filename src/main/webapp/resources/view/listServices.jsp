<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="<c:url value="/resources/css/datatables.css" />" rel="stylesheet">
	<title>Services</title>
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
										
								        <a href="${contextPath}/resources/view/addService.jsp" class="btn btn-success topAddButton" >
									    	<i class="fas fa-plus"></i>  &nbsp; Add Service
										</a>
										
									</div>
								</div>
						 	</div>
							<div class="card-body">
								<div class="">
									<table class="table table-striped table-bordered first" id="userTable">
										<thead>
											<tr>
											    <th>Name</th>
											    <th>Minimum Charge</th>
											    <th>Charge</th>
											    <th>Type</th>
											    <th>Status</th>
											    <th>Action</th>
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

<script src="<c:url value="/resources/js/datatables.js" />" ></script>
<script>
	jQuery(document).ready(function(){
		loadTableData();
	});

	function loadTableData(){
		jQuery("#userTable").DataTable({
			"processing": true,
			"serverSide": true,
			"ajax":{
				"url":"${contextPath}/service/listServices",
				 "type": "POST",
				 "contentType": "application/json",
				 "data": function(data){
					return JSON.stringify(data);
				}
			},
			"columns":[
				{data : 0 , name:"name"},
				{data : 1 , name:"minimum_charge"},
				{data : 2 , name:"charge"},
				{data : 3 , name:"type"},
				{data : 4 , name:"active",searchable : false , orderable:false},
				{data : 5 , name:"actions",searchable : false , orderable:false}
			]
		});
	}	
</script>
</html>