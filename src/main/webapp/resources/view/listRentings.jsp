<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="<c:url value="/resources/css/displayDetails.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
	<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">
	
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
								<div class="form-group row">
                                     <label class="col-1 col-sm-1 col-form-label text-sm-right">Available</label>
                                     <div class="col-1 col-sm-1 col-lg-1 pt-1">
                                         <div class="switch-button switch-button-xs">
                                             <input type="checkbox" name="available" id="available" checked><span>
                                         <label for="available"></label></span>
                                         </div>
                                     </div>
                                 </div>
								<div class="table-responsive">
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
	
	<div class="modal fade" id="rentingModal" tabindex="-1" role="dialog" aria-labelledby="rentingModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="rentingModalLabel"></h3>
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
	
	<div class="loading" style="display:none">
		<img src="${contextPath}/resources/images/loading.gif" class="spinner" >
	</div>
	
</body>

<script src="<c:url value="/resources/js/alertify.js" />" ></script>
<script src="<c:url value="/resources/js/displayDetails.js" />" ></script>

<script>
	var table;
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	
	jQuery(document).ready(function(){
			
		initializeAlertifyTheme()
		
		loadTableData();
		
		jQuery("#RentingTable").on("click",".toggleRenting",function(){
			jQuery(".actionButton").prop('disabled', true);
			var rentingid=jQuery(this).attr("rentingid")
			
			alertify.confirm(
				"Confirm",
				"Are you sure you !!",
				function(){toggleRenting(rentingid)},
				function(){jQuery(".actionButton").prop('disabled', false);}
			)
			
		})
		
		jQuery("#RentingTable").on("click",".editRenting",function(){
			
			editRenting(jQuery(this).attr("rentingid"))
		})
		
		jQuery("#available").on("change",function(){
			$('#RentingTable').DataTable().ajax.reload();
		})
		
		jQuery("#RentingTable").on("click",".contractRenting",function(){
			createContract(jQuery(this).attr("rentingid"))
		})
		
		jQuery("#RentingTable").on("click",".details",function(){
			getRentingDetails(jQuery(this).attr("rentingid"))
		})
	});
	
	function getRentingDetails(rentingId){
		
		jQuery.ajax({
			
			method : "GET",
			url : "${contextPath}/renting/getRentingDetails/"+rentingId,
			
		}).done(function(data){
			displayRentingDetails(data)
		})
		
		
	}
	
	function displayRentingDetails(data){
		console.log(data)
		jQuery(".modal-title").html("Renting Details")
		
		jQuery(".modal-body").html(getRentingDetailsHTML(data));
		jQuery('#rentingModal').modal('show');
	}
	
	function createContract(rentingId){
		window.location.href="${contextPath}/resources/view/createContract.jsp?rentingId="+rentingId;
	} 
	
	function toggleRenting(rentingId){
		jQuery(".loading").show();
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/renting/toggleStatus/"+rentingId,
		}).done(function(data){
			jQuery(".loading").hide();
			$('#RentingTable').DataTable().ajax.reload();
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery(".actionButton").prop('disabled', false);
			alertify.alert("<div style='color:red'>An Error occured. </div>").setHeader("<b>Error</b>");

		});
	}
	
	function editRenting(rentingId){
		window.location.href="${contextPath}/resources/view/addRenting.jsp?id="+rentingId;

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
				 	data.available = $("#available").prop("checked");
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