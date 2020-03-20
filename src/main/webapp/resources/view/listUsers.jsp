<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User list</title>
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
					 				
						 				User Lists
						 				
									</h2>
									
				                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
								        <a href="${contextPath}/resources/view/addUser.jsp" class="btn btn-success topAddButton" >
									    	<i class="fas fa-plus"></i>  &nbsp; Add User
										</a>
										
									</div>
								</div>
						 	</div>
							<div class="card-body">
								<div class="">
									<table class="table table-striped table-bordered first" id="userTable">
										<thead>
											<tr>
											    <th>User Name</th>
											    <th>First Name</th>
											    <th>Middle Name</th>
											    <th>Last Name</th>
											    <th>Sex</th>
											    <th>Phone Number</th>
		 									    <th>Email Address</th>
											    <th>Type of User</th>
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
		jQuery("#userTable").DataTable({
			"processing": true,
			"serverSide": true,
			"ajax":{
				"url":"${contextPath}/user/listUsers",
				 "type": "POST",
				 "contentType": "application/json",
				 "data": function(data){
					return JSON.stringify(data);
				}
			},
			"columns":[
				{data : 0 , name:"userName"},
				{data : 1 , name:"firstName"},
				{data : 2 , name:"middleName"},
				{data : 3 , name:"lastName"},
				{data : 4 , name:"sex"},
				{data : 5 , name:"phoneNumber"},
				{data : 6 , name:"emailAddress"},
				{data : 7 , name:"typeOfUser"}
			]
		});
		
	})
</script>
</html>