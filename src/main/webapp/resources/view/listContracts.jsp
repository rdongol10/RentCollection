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
	var termiateContractId=0;
	var errorFields = []
	var transactionData="";
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	
	jQuery(document).ready(function(){
		
		initializeAlertifyTheme()

		loadTableData();
		
		jQuery("#contractTable").on("click",".billContract",function(){
			
			billContract(jQuery(this).attr("contractid"))

		})
		
		jQuery("#contractTable").on("click",".details",function(){
			getDetails(jQuery(this).attr("rentingId"))
		})
		
		jQuery("#contractTable").on("click",".deleteContract",function(){
			jQuery(".actionButton").prop('disabled', true);
			terminateContract(jQuery(this).attr("contractid"))
		})
		
		jQuery('#contractModal').on('hidden.bs.modal', function (e) {
			termiateContractId=0;
			transactionData=""
		})
		
		jQuery("#contractModal").on("click",".submitTermination",function(){
			event.preventDefault();
			
			jQuery(".submitTermination").prop("disabled",true);
			removeErrorHighlights()
			
			if(validateInputs()){
				submitBill()
			}else{
				jQuery(".submitTermination").prop("disabled",false);
				highlightErrorFields()
			}
		})
		
		jQuery("#contractModal").on("click","#terminateContract",function(){
			jQuery("#terminateContract").prop("disabled",true);
			terminateContractWithoutPayment()
		})
		
		jQuery("#contractModal").on("click","#payAndTerminate",function(){
			jQuery("#payAndTerminate").prop("disabled",true);
			payAndterminateContract()
		})
		
		
	});
	
	function terminateContractWithoutPayment(){
		jQuery(".loading").show();
		console.log("===================")
		jQuery.ajax({
			method:"POST",
			url:"${contextPath}/contract/terminateContract",
			contentType: 'application/json; charset=UTF-8',		
			data : termiateContractId
		}).done(function(data){
			jQuery(".loading").hide();
			$('#contractTable').DataTable().ajax.reload();
			$('#contractModal').modal('toggle');
		}).fail(function(){
			jQuery("#terminateContract").prop("disabled",false);
			jQuery(".loading").hide();
			alertify.alert("<div style='color:red'>An Error occured</div>").setHeader("<b>Error</b>");
		});
	}
	
	function payAndterminateContract(){
		jQuery(".loading").show();

		jQuery.ajax({
			method:"POST",
			url:"${contextPath}/contract/payAndTerminateContract",
			contentType: 'application/json; charset=UTF-8',		
			data: transactionData
		}).done(function(data){
			jQuery(".loading").hide();
			$('#contractTable').DataTable().ajax.reload();
			$('#contractModal').modal('toggle');
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#payAndTerminate").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured</div>").setHeader("<b>Error</b>");
		});
	}
	
	
	function submitBill(){
		jQuery(".loading").show();
		jQuery.ajax({
			method:"POST",
			url:"${contextPath}/transaction/calculateForTermination",
			contentType:'application/json; charset=UTF-8',
			data:getBillData()
			
		}).done(function(data){
			jQuery(".loading").hide();
			jQuery(".submitTermination").prop("disabled",false);
			displayTransactionsDetail(data)
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery(".submitTermination").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured</div>").setHeader("<b>Error</b>");
		});
	}
	
	function displayTransactionsDetail(data){
		transactionData = JSON.stringify(data.transaction)
		jQuery(".modal-title").html("Transaction");
		jQuery(".modal-body").html(getTransactionDetailHTML(data));
		jQuery(".modal-footer").html(
				'<button type="button" class="btn btn-primary" id="terminateContract">Terminate</button>' +
				'<button type="button" class="btn btn-success"id="payAndTerminate">Pay and Terminate</button>' +
				'<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>'
		);
		jQuery('#contractModal').modal('show');
	}
	
	function getBillData(){
		var billData = new Object();
		billData.contractId= termiateContractId;
		
		var billContractServices = []
		
		jQuery(".services").each(function(){
			var billContractService = new Object();
			billContractService.rentingFacilityId=$(this).find('.rentingFacilityId').val();
			billContractService.serviceName=$(this).find('.serviceName').html();
			if($(this).find('.serviceCharge').val() == "-"){
				
				billContractService.serviceType="fixed"
				billContractService.serviceCharge=$(this).find('.serviceCharge').html();
				billContractService.lastUnit="0"
				billContractService.currentUnit="0"
			}else{
				billContractService.serviceType="unit"
				billContractService.serviceCharge="0";
				billContractService.lastUnit=$(this).find('.lastUnit').html();
				billContractService.currentUnit=$(this).find('.currentUnits').val();

			}
			
			billContractServices.push(billContractService)
		
		})
		
		billData.billContractServices = billContractServices;
		
		return JSON.stringify(billData)
		
	}
	
	
	
	function highlightErrorFields() {
		if (errorFields.length < 1) {
			return;
		}

		errorFields.forEach(function(value, index) {
			var id = value.id;
			var message = value.message
			jQuery("#" + id).css("border-color", "red");
			jQuery("#" + id + "-errorFeedback").html(message)
		})
	}
	
	
	function removeErrorHighlights(){
		jQuery(".errorFeedback").html("");
		jQuery(".form-control").css("border-color","");

	}

	function validateInputs() {

		if(!validateRequiredFields()){
			return false;
		}
		
		if(!validateOtherFields()){
			return false;
		}
		
		return true;
	}
	
	function validateRequiredFields() {
		errorFields = []
		jQuery(".requiredInputs:visible").each(function() {
			var errorField = {};

			if (this.value.trim() == "") {
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Required field connot be empty";
				errorFields.push(errorField)
			}

		})

		return !errorFields.length > 0

	}
	
	function validateOtherFields(){
		errorFields = []
		validateUnits()
		validateNumberFields()
		return !errorFields.length > 0;;
	}
	
	function validateUnits(){
		
		jQuery(".currentUnits").each(function(){
			
			var errorField = {};
			
			var count = jQuery(this).attr("count");
			
			var lastUnit = parseInt(jQuery("#lastUnit-"+count).html());
			
			var currentUnit =  jQuery(this).val();
			
			if(currentUnit < lastUnit){
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Current unit should be greater than last unit";
				errorFields.push(errorField)
			}
			
		});
	}
	
	function validateNumberFields(){
		jQuery(".number:visible").each(function() {
			var errorField = {};
			if (this.value.trim() != "" && parseInt(this.value.trim()) <0 ) {
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Cannot be less than 0";
				errorFields.push(errorField)
			}
		})
	}
	
	
	function terminateContract(contractId){
		jQuery(".loading").show();
		jQuery.ajax({
			
			method : "GET",
			url : "${contextPath}/contract/areAllBillsCleared/"+contractId,
			
		}).done(function(data){
			jQuery(".loading").hide();
			jQuery(".actionButton").prop('disabled', false);
			if(data){
				getServices(contractId)
			}else{
				alertify.alert("<div style='color:red'>All the bills must be cleared to terminate a contract</div>").setHeader("<b>Cannot terminate</b>");
			}
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery(".actionButton").prop('disabled', false);
			alertify.alert("<div style='color:red'>An Error occured .</div>").setHeader("<b>Error</b>");

		});
	}
	
	function getServices(id){
		jQuery(".loading").show();
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/contract/billContractService/"+id
		}).done(function(data){
			jQuery(".loading").hide();
			displayTermintaeContractModal(data,id)
		}).fail(function(){
			jQuery(".loading").hide();
			alertify.alert("<div style='color:red'>An Error occured .</div>").setHeader("<b>Error</b>");
		});	
	}
	
	function displayTermintaeContractModal(data , contractId){
		termiateContractId = contractId;
		jQuery(".modal-title").html("Cancel Contract")
		jQuery(".modal-body").html(getServiceDataHTML(data));
		jQuery(".modal-footer").html('<button type="button" class="btn btn-primary submitTermination" >Submit</button><button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>');
		jQuery('#contractModal').modal('show'); 

	}
	
	function getServiceDataHTML(data){
		var html="";
		
		if(data.length<=0){
			return html;
		}
		
		html += '<div class="row ">'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Service Name</div>'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Charge</div>'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Last Unit</div>'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Curent Unit</div>'
		html += '</div>'
		for(var i =0 ; i<data.length ; i++){
			html += '<br>'
			html += '<div class="row services">'
			html += '<input type ="hidden" class="rentingFacilityId" value="'+data[i].rentingFacilityId+'"  id="rentingFacilityId-'+i+'" >'
			html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 serviceName"  id="serviceName-'+i+'" >'+data[i].serviceName+'</div>'
			if(data[i].serviceType == "fixed"){
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 serviceCharge"  id="serviceCharge-'+i+'" >'+data[i].serviceCharge+'</div>'
			}else{
				
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 serviceCharge"  id="serviceCharge-'+i+'" >-</div>'
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 lastUnit" id="lastUnit-'+i+'" >'+data[i].lastUnit+'</div>'
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">'
				html += '<input type="number" id="currentUnit-'+i+'" class="number form-control requiredInputs currentUnits" min="0" count="'+i+'">'
				html += '<div class="errorFeedback" id="currentUnit-'+i+'-errorFeedback"></div>'
				html += '</div>'

			}
			html += '</div>'
		}
		return html;
		
	}
	
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
		
		jQuery(".modal-footer").html('<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>');


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