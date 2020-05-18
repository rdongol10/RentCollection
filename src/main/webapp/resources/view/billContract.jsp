<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Bill Contract</title>

<link href="<c:url value="/resources/css/displayDetails.css" />" rel="stylesheet">

</head>
<body>
	<div class="dashboard-main-wrapper">
		<%@ include file="menu.jsp" %>  
	    <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
			
				<div class="row">
					<div class="col-xl-10">
					
						<div class="row">
						 	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
						 	
						 		<div class="card">
						 		
						 			<div class="card-header">
								 		<div class="row">
								 			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							                    <h2 class="pageheader-title" id="pageheader-title">
							 						Bill Contract
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the bill service</p>
								 			</div>
										</div>
								 	</div>
								 	
								 	<form id="billingForm">
								 		<div class="card-body">
								 			<div class="row">
								 				<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
								 					<label for="months" class="col-form-label">Number of months</label>
	                                                <input id="months" min = "0" name="months" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="months-errorFeedback"></div>
								 				</div>
								 				
								 			</div>
								 			
								 		</div>
								 		
								 		<div id ="serviceContainer">
								 			
							 			</div>
							 			
								 		<div class="card-body border-top">
                                        
                                        	<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<button class="btn btn-primary" id="billContract">
								 						Submit
													</button>
												</div>	
											</div>
                                        </div>
								 	
								 	</form>
								 	
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
					<button type="button" class="btn btn-primary" id="bilInvoice">Bill</button>
					<button type="button" class="btn btn-success"id="payInvoice">Pay</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>		
</body>

<script src="<c:url value="/resources/js/displayDetails.js" />" ></script>

<script type="text/javascript">
	var id=0;
	var errorFields = []
	var transactionData="";
	
	jQuery(document).ready(function() {
		
		id= getURLParameter("id");
		if(id!=undefined){
			getServices(id)
		}
		
		jQuery("#billContract").on("click",function(){
			event.preventDefault()
			removeErrorHighlights()
			
			if(validateInputs()){
				submitBill()
			}else{
				highlightErrorFields()
			}
		})
		
		jQuery('#transactionModal').on('hidden.bs.modal', function (e) {
			transactionData="";
		})
		
		jQuery('#bilInvoice').on('click',function(){
			billInvoice()
		})
		
		jQuery('#payInvoice').on('click',function(){
			payInvoice()
		})
	});	
	
	function billInvoice(){
		jQuery.ajax({
			
			method:"POST",
			url:"${contextPath}/transaction/billInvoice",
			contentType:'application/json; charset=UTF-8',
			data:transactionData
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listContracts.jsp";
		})
	}
	
	function payInvoice(){
		jQuery.ajax({
			
			method:"POST",
			url:"${contextPath}/transaction/payInvoice",
			contentType:'application/json; charset=UTF-8',
			data:transactionData
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listContracts.jsp";
		})
	}
	
	function submitBill(){
		
		jQuery.ajax({
			method:"POST",
			url:"${contextPath}/transaction/calculateBill",
			contentType:'application/json; charset=UTF-8',
			data:getBillData()
			
		}).done(function(data){
			displayTransactionsDetail(data)
		})
	}
	
	function displayTransactionsDetail(data){
		transactionData = JSON.stringify(data.transaction)
		jQuery(".modal-title").html("Transaction");
		jQuery(".modal-body").html(getTransactionDetailHTML(data));
		jQuery('#transactionModal').modal('show');
	}
	
	
	function getBillData(){
		var billData = new Object();
		billData.numberOfMonths = jQuery("#months").val();
		billData.contractId= id;
		
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
		validateNumberofMonths()
		validateUnits()
		validateNumberFields()
		return !errorFields.length > 0;;
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
	function validateNumberofMonths(){
		
		if(parseInt(jQuery("#months").val())<=0){
			
			var errorField = {};
			errorField.id = "months"
			errorField.message = "Months should be greater than 0";
			errorFields.push(errorField)
		}
		
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
	
	function getServices(id){
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/contract/billContractService/"+id
		}).done(function(data){
			loadServiceData(data)
		});	
	}
	
	function loadServiceData(data){
		
		if(data.length<=0){
			return ;
		}
		
		jQuery("#serviceContainer").html(getServiceDataHTML(data))
	}
	
	function getServiceDataHTML(data){
		var html="";
		
		if(data.length<=0){
			return html;
		}
		
		html += '<div class="card-body border-top">'
		html += '<div class="row">'
		html += '<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<h3>Services</h3>'
		html += '</div>'
		html += '</div>'
		
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
		html += '</div>'
		return html;
		
	}
	function getURLParameter(param){
		
		var pageURL = window.location.search.substring(1);
		var urlVariables = pageURL.split('&')
		for(var i=0;i<urlVariables.length;i++){
			var parameterName=urlVariables[i].split('=');
			if(parameterName[0] == param){
				return decodeURIComponent(parameterName[1]);
			}
		}
	}
</script>
</html>