<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="<c:url value="/resources/css/datatables.css" />" rel="stylesheet">
	<title>Rentings</title>
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
					 				
						 				Renting Lists
						 				
									</h2>
									
				                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
								        <a href="${contextPath}/resources/view/addRenting.jsp" class="btn btn-success topAddButton" >
									    	<i class="fas fa-plus"></i>  &nbsp; Add Renting
										</a>
										
									</div>
								</div>
						 	</div>
							<div class="card-body">
								<div class="">
									<table class="table table-striped table-bordered first" id="RentingTable">
										<thead>
											<tr>
											    <th>Name</th>
											    <th>Type</th>
											    <th>Number of Rooms</th>
											    <th>Price</th>
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
	var table;
	jQuery(document).ready(function(){
			
		loadTableData();
		
		jQuery("#RentingTable").on("click",".toggleRenting",function(){
			
			toggleRenting(jQuery(this).attr("rentingid"))
		})
			
	});
	
	function toggleRenting(rentingId){
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/renting/toggleStatus/"+rentingId,
		}).done(function(data){
			$('#RentingTable').DataTable().ajax.reload();
		});
	}
	
	function loadTableData(){
		table = jQuery("#RentingTable").DataTable({
			"processing": true,
			"serverSide": true,
			"ajax":{
				"url":"${contextPath}/renting/listRentings",
				 "type": "POST",
				 "contentType": "application/json",
				 "data": function(data){
					return JSON.stringify(data);
				}
			},
			"columns":[
				{data : 0 , name:"name"},
				{data : 1 , name:"type"},
				{data : 2 , name:"number_of_rooms"},
				{data : 3 , name:"price"},
				{data : 4 , name:"status",searchable : false , orderable:false},
				{data : 5 , name:"actions",searchable : false , orderable:false}
			]
		});
	}	
</script>	
</html>