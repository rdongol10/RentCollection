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

<style type="text/css">
	
	#transactionTable tr.selected{
		background-color : #CCCCCC
	}

</style>
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
   											    <th>Note</th>
											    <th>Total Charge</th>
   											    <th>Actions</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
										<tfoot class="transactionTableFoot">
											<tr> 
												<th colspan="6"  class="text-right"><strong>Total</strong></th>
												<th id="selectedTotal"></th>
												<th> <Button class="btn btn-success " id="paySelected" >Pay Selected</Button> </th>
											</tr>
										</tfoot>
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
					<button type="button" class="btn btn-success"id="payInvoice">Pay</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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

<script type="text/javascript">
	var table;
	var transactionId=0;
	var selectedTransactionIds =[];
	var total = 0;
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	
	jQuery(document).ready(function(){
		
		initializeAlertifyTheme()
		
		loadTableData()
		
		toggleTotalFooter();
		
		jQuery("#transactionTable").on("click",".details",function(){
			displayTransactionsDetail(jQuery(this).attr("transactionid"))
		})
		
		jQuery("#payInvoice").on("click",function(){
			payTransaction(transactionId,true);
		})
		
		jQuery("#transactionTable").on("click",".payment",function(){

			var transactionid=jQuery(this).attr("transactionid")
			
			alertify.confirm(
				"Confirm",
				"Are you sure you !!",
				function(){payTransaction(transactionid,false)},
				function(){}
			)
		})
		
		jQuery('#transactionModal').on('hidden.bs.modal', function (e) {
			transactionId=0;
		})
		
		jQuery("#transactionTable").on("click",".checkForPayment",function(){
			var tr = jQuery(this).closest("tr")
			jQuery(tr).toggleClass('selected');
			displaySelectedTotal()
		})
		
		jQuery("#paySelected").on("click",function(){
			
			alertify.confirm(
					"Confirm",
					"Are you sure you !!",
					function(){paySelectedTransactions()},
					function(){}
				)
			
		})
		
	});
	
	function unselectTableRows(){
		jQuery("#transactionTable .selected").each(function(i,tr){
			jQuery(tr).toggleClass('selected');
		});	
	}
	
	function toggleTotalFooter(){
		if(selectedTransactionIds.length > 0){
			jQuery(".transactionTableFoot").show();
		}else{
			jQuery(".transactionTableFoot").hide();
		}
	}
	function displaySelectedTotal(){
		selectedTransactionIds = [];
		total = 0;
		jQuery("#transactionTable .selected").each(function(i,tr){
			var row= table.row( tr );
			selectedTransactionIds.push(row.data()[0]);
			total += parseFloat(row.data()[6])
		})
		
		jQuery("#selectedTotal").html("<strong>"+total+"</strong>");
		toggleTotalFooter();
	}
	
	function payTransaction(transactionId , toggle){
		jQuery(".loading").show();

		jQuery.ajax({
			
			method:"PUT",
			url:"${contextPath}/transaction/payInvoice/"+transactionId

		}).done(function(data){
			jQuery(".loading").hide();
			$('#transactionTable').DataTable().ajax.reload();
			if(toggle){
				$('#transactionModal').modal('toggle');
			}
		}).fail(function(){
			jQuery(".loading").hide();
			alertify.alert("<div style='color:red'>An Error occured .</div>").setHeader("<b>Error</b>");
		});
	}
	
	function paySelectedTransactions(){
		
		if(selectedTransactionIds.length<=0){
			return;
		}
		
		jQuery(".loading").show();
		jQuery.ajax({
			
			method:"PUT",
			url:"${contextPath}/transaction/payInvoices",
			contentType: 'application/json; charset=UTF-8',		
			data : selectedTransactionIds.toString()

		}).done(function(data){
			jQuery(".loading").hide();
			$('#transactionTable').DataTable().ajax.reload();
			unselectTableRows()
			displaySelectedTotal()
		}).fail(function(){
			jQuery(".loading").hide();
			alertify.alert("<div style='color:red'>An Error occured .</div>").setHeader("<b>Error</b>");
		});
	}
	
	function displayTransactionsDetail(id){
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/transaction/getTransactionDetail/"+id,
		}).done(function(data){
			transactionId=id
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
				{data : 5 , name:"note"},
				{data : 6 , name:"total_charge"},
				{data : 7 , name:"actions",searchable : false , orderable:false}
			]
		});
		
	}
</script>
</html>