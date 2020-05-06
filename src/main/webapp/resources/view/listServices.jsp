<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
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
								<div class="table-responsive">
									<table class="table table-striped table-bordered first" id="serviceTable">
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

<script>
	var table;
	jQuery(document).ready(function(){
		
		loadTableData();
		
		jQuery("#serviceTable").on("click",".editService",function(){
			
			editService(jQuery(this).attr("serviceId"));
			
		})
		
		jQuery("#serviceTable").on("click",".toggleService",function(){
			
			toggleService(jQuery(this).attr("serviceId"));
			
		})
		
		jQuery("#serviceTable").on("click",".showDetails",function(){
			toggleServiceDetails(this);
		})
		
		
	});
	
	
	function toggleServiceDetails(clickedColumn){
		var tr = jQuery(clickedColumn).closest("tr");
		var row= table.row( tr );
		console.log(row)
		if ( row.child.isShown() ) {
		    row.child.hide();
		    tr.removeClass('shown');
		    jQuery(clickedColumn).attr("class","actionButton showDetails fas fa-angle-double-down")
		}
		else {
			LoadServiceDetails(clickedColumn , row , tr)
			
		} 
	}
	
	function LoadServiceDetails(clickedColumn , row , tr){
		jQuery.ajax({
			method : "GET",
			url : "${contextPath}/service/getServiceDetails/"+jQuery(clickedColumn).attr("serviceId"),
			async:false,
			success:function(data){
				row.child( formatServiceDetailData(data) ).show();
		   		tr.addClass('shown');
				jQuery(clickedColumn).attr("class","actionButton showDetails fas fa-angle-double-up")
				$(".innerTable").DataTable({
					destroy: true,
					"paging":   false,
					 "searching": false,
					 "info":     false
				});
			}
		});
		
	}

	function formatServiceDetailData(data){
		var html = "";
		html += "<table class='innerTable'>"
		html += "<thead><tr>"
		html += "<th>Rate</th>"
		html += "<th>Volume</th>"
		html += "<th>Service Charge</th>"
		html += "</tr></thead>"
		html += "<tbody>"
		for(var i = 0 ; i<data.length ; i++){
			html += '<tr>';
			html += '<td>'+data[i].rate+'</td>'
			html += '<td>'+data[i].volumeCutoff+'</td>'
			html += '<td>'+data[i].serviceCharge+'</td>'
			html += '</tr>';
		}
		html += "</tbody>"
		html += "</table>"
		
		
		return html;
	}
	
	function editService(serviceId){
		
		window.location.href="${contextPath}/resources/view/addService.jsp?id="+serviceId;

	}
	
	function toggleService(serviceId){
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/service/toggleStatus/"+serviceId,
		}).done(function(data){
			$('#serviceTable').DataTable().ajax.reload();
		});
	}
	
	function loadTableData(){
		table = jQuery("#serviceTable").DataTable({
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