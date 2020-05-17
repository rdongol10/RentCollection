<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/displayDetails.css" />" rel="stylesheet">

<title>Due payments</title>
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
				                    <h2 class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 topCardHeader">
					 				
						 				Transactions
						 				
									</h2>
								</div>
	                   		</div>
	                   		
	                   		<div class="card-body">
	                   		
	                   			<div class="table-responsive">
	                   				<table class="table table-striped table-bordered first" id="transactionTable">
										<thead>
											<tr>
												<th>Invoice No.</th>
											    <th>Renting Name</th>
											    <th>Rentee Name</th>
											    <th>Billed Date</th>
											    <th>Paid Date</th>
											    <th>Total Charge</th>
   											    <th>Note</th>
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
	
	<div class="modal fade" id="transactionModal" tabindex="-1" role="dialog" aria-labelledby="transactionModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xlg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="transactionModalLabel"></h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
</body>

<script src="<c:url value="/resources/js/displayDetails.js" />" ></script>

<script type="text/javascript">
	jQuery(document).ready(function(){
		
		loadTableData()
		
		jQuery("#transactionTable").on("click",".details",function(){
			displayTransactionsDetail(jQuery(this).attr("transactionid"))
		})
		
		jQuery("#transactionTable").on("click",".payment",function(){
			payTransaction(jQuery(this).attr("transactionid"))
		})
		
	});
	
	function payTransaction(transactionId){
		jQuery.ajax({
			
			method:"PUT",
			url:"${contextPath}/transaction/payInvoice/"+transactionId

		}).done(function(data){
			$('#transactionTable').DataTable().ajax.reload();
		})
	}
	
	function displayTransactionsDetail(transactionId){
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/transaction/getTransactionDetail/"+transactionId,
		}).done(function(data){
			jQuery(".modal-title").html("Transaction");
			jQuery(".modal-body").html(getTransactionDetailHTML(data));
			jQuery('#transactionModal').modal('show');
		})
	}
	
	function loadTableData(){
		table = jQuery("#transactionTable").DataTable({
			"processing": true,
			"serverSide": true,
			"ajax":{
				"url":"${contextPath}/transaction/listTransactions",
				 "type": "POST",
				 "contentType": "application/json",
				 "data": function(data){
				 	
					 data.unpaidOnly = "true"
				 	
					return JSON.stringify(data);
				}
			},
			"columns":[
				{data : 0 , name:"id"},
				{data : 1 , name:"name"},
				{data : 2 , name:"first_name"},
				{data : 3 , name:"billed_date"},
				{data : 4 , name:"paid_Date"},
				{data : 5 , name:"total_charge"},
				{data : 6 , name:"note"},
				{data : 7 , name:"actions",searchable : false , orderable:false}
			]
		});
		
	}
</script>
</html>