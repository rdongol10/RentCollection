<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/datatables.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/displayDetails.css" />" rel="stylesheet">
<title>Rentees</title>

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
					 				
						 				Rentee Lists
						 				
									</h2>
									
				                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
								        <a href="${contextPath}/resources/view/addRentee.jsp" class="btn btn-success topAddButton" >
									    	<i class="fas fa-plus"></i>  &nbsp; Add Rentee
										</a>
										
									</div>
								</div>
						 	</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered first" id="RenteeTable">
										<thead>
											<tr>
											    <th>First Name</th>
											    <th>Last Name</th>
											    <th>Middle Name</th>
											    <th>Address</th>
											    <th>Sex</th>
											    <th>Date of Birth</th>
												<th>Citizenship Number</th>
   											    <th>Phone Number</th>
   											    <th>Email Id</th>
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
	
	<div class="modal fade" id="renteeModal" tabindex="-1" role="dialog" aria-labelledby="renteeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="renteeModalLabel"></h3>
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
<script src="<c:url value="/resources/js/datatables.js" />" ></script>
<script src="<c:url value="/resources/js/bootstrap.bundle.js" />" ></script>
<script src="<c:url value="/resources/js/displayDetails.js" />" ></script>


<script type="text/javascript">
	var table;
	jQuery(document).ready(function(){
		loadTableData();
		
		jQuery("#RenteeTable").on("click",".editRentee",function(){
			
			editRentee(jQuery(this).attr("rentee"))
		})
		
		jQuery("#RenteeTable").on("click",".details",function(){
			getRenteeDetails(jQuery(this).attr("rentee"))
		})
	});
	
	function getRenteeDetails(id){
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/rentee/getRenteeModel/"+id
		}).done(function(data){
			displayRenteeDetails(data)
		});	
	}
	
	function displayRenteeDetails(data){
		jQuery(".modal-title").html("Rentee Details")
		jQuery(".modal-body").html(getRenteeDetailsHTML(data))
		jQuery('#renteeModal').modal('show');
	}
	
	
	function editRentee(renteeId){
		window.location.href="${contextPath}/resources/view/addRentee.jsp?id="+renteeId;
	}
	
	function loadTableData(){
		table = jQuery("#RenteeTable").DataTable({
			"processing": true,
			"serverSide": true,
			"ajax":{
				"url":"${contextPath}/rentee/listRentees",
				 "type": "POST",
				 "contentType": "application/json",
				 "data": function(data){
					return JSON.stringify(data);
				}
			},
			"columns":[
				{data : 0 , name:"first_name"},
				{data : 1 , name:"last_name"},
				{data : 2 , name:"middle_name"},
				{data : 3 , name:"address"},
				{data : 4 , name:"sex"},
				{data : 5 , name:"dob"},
				{data : 6 , name:"citizenship_number"},
				{data : 7 , name:"phone_number"},
				{data : 8 , name:"email_id"},
				{data : 9 , name:"actions",searchable : false , orderable:false}
			]
		});
	}	
</script>
</html>