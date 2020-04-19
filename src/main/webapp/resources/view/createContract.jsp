<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/select2.css" />" rel="stylesheet">
<title>create contract</title>
</head>
<body>
	<div class="dashboard-main-wrapper">
		<%@ include file="/resources/view/menu.jsp" %>  
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
							 						Create Contract
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to create a contract</p>
								 			</div>
										</div>
								 	</div>
								 	
								 	<div class="card-body">
										<form id="contractForm">
											<div class="row">
				                                <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
													<label for="renting" class="col-form-label">Renting<span class="requiredField">*</span></label>
													<select class="form-control requiredInputs" id="renting" name="renting">
													</select>
													<div class="errorFeedback" id="renting-errorFeedback">
														
													</div>
								                </div>
							                 	<div class="form-group col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1">
							                 	
							                 	</div>
							                 	
												<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
													<label for="rentee" class="col-form-label">Rentee<span class="requiredField">*</span></label>
													<select class="form-control requiredInputs" id="rentee" name="rentee">
													</select>
													<div class="errorFeedback" id="rentee-errorFeedback">
														
													</div>
				                                </div>
				                                
				                                <div class="form-group col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1">
							                 	
							                 	</div>
							                 	
							                 	<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
													<label for="paymentType" class="col-form-label">Payment Type</label>
													<select class="form-control" id="paymentType" name="paymentType">
														<option value ="prepaid">Prepaid</option>
														<option value ="postpaid">Postpaid</option>
													</select>
													<div class="errorFeedback" id="paymentType-errorFeedback">
														
													</div>
				                                </div>
								                
                                            </div>
                                            
                                            <div class="row">
                                            	<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<button class="btn btn-primary" id="createContract">
								 						Create Contract
													</button>
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
	</div>
</body>
<script src="<c:url value="/resources/js/select2.min.js" />" ></script>
<script type="text/javascript">
	
	var errorFields = []

	jQuery(document).ready(function(){
		
		var rentingId = getURLParameter("rentingId")
		
		loadSelectOptions(rentingId);
		
		jQuery("#renting").select2();
		jQuery("#rentee").select2();
		
		jQuery("#createContract").on("click",function(){
			event.preventDefault()
			removeErrorHighlights()
			if (validateInputs()) {
				saveContract()
			} else {
				highlightErrorFields()
			}
			
		})
		
	});
	
	function saveContract(){
		var contract = getContractData();
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/contract",
			contentType: 'application/json; charset=UTF-8',	
			data:contract
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listContracts.jsp";
		});
	}
	
	function getContractData(){
		var contractData = new Object();
		
		contractData.rentingId = jQuery("#renting").val()
		contractData.renteeId = jQuery("#rentee").val()

		contractData.paymentType = jQuery("#paymentType").val()

		return JSON.stringify(contractData);

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
	
	function validateInputs() {

		if(!validateRequiredFields()){
			return false;
		}
		
		return true;
	}
	
	function validateRequiredFields() {
		errorFields = []
		jQuery(".requiredInputs:visible").each(function() {
			var errorField = {};

			if (this.value.trim() == "" || jQuery(this).val() == null) {
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Required field connot be empty";
				errorFields.push(errorField)
			}

		})

		return !errorFields.length > 0

	}
	
	function removeErrorHighlights(){
		jQuery(".errorFeedback").html("");
		jQuery(".form-control").css("border-color","");

	}
	
	function loadSelectOptions(rentingId){
		getAvailableRentings(rentingId)
		getRenteeCotract()
	}
	
	function getAvailableRentings(rentingId){
		jQuery.ajax({
			method : "GET",
			url:"${contextPath}/renting/getAvailableRentings",
			async:false
		}).done(function(data){
			jQuery("#renting").html(getOptions(data,rentingId))
		})	
	}
	
	function getRenteeCotract(){
		jQuery.ajax({
			method : "GET",
			url:"${contextPath}/rentee/getRenteeContractModel",
			async:false
		}).done(function(data){
			jQuery("#rentee").html(getOptions(data))
		})	
	}
	
	
	function getOptions(data,id){
		var html= '<option disabled '
		if(id == undefined){
			
			html +='selected ';
			
		}
		
		html +='> -- select an option -- </option>';
		for(var i =0 ; i<data.length;i++){
			html += '<option value ="'+ data[i].id+'"'
			if(id == data[i].id){
				html +='selected ';
			}
			html += ' >'+data[i].name+'</option>' 
		}
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