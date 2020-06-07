<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<meta charset="ISO-8859-1">
<title>Change Password</title>
<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">

</head>
<body>
    <div class="dashboard-main-wrapper">
    	<%@ include file="/resources/view/menu.jsp" %> 
    	 <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
					<div class="col-xl-10">
						<div class="row">
                        	<div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-8">
                        		<div class="card">
                        			<div class="card-header">
								 		<div class="row">
								 			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							                    <h2 class="pageheader-title" id="pageheader-title">
							 						Change Password
												</h2>
								 			</div>
											
										</div>
								 	</div>
								 	
								 	<div class="card-body">
								 		<form id="updatePasswordForm">
								 			<div class="row">
	                        					<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col4">
	                                                <label for="oldPassword" class="col-form-label">Old Password<span class="requiredField">*</span></label>
	                                                <input id="oldPassword" name="oldPassword" type="password" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="oldPassword-errorFeedback"></div>
	                                            </div>
	                                         </div> 
	                                         
	                                         <div class="row">
	                        					<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col4">
	                                                <label for="newPassword" class="col-form-label">New Password<span class="requiredField">*</span></label>
	                                                <input id="newPassword" name="newPassword" type="password" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="newPassword-errorFeedback"></div>
	                                            </div>
	                                         </div>   
	                                         
	                                         <div class="row">
	                        					<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col4">
	                                                <label for="confirmNewPassword" class="col-form-label">Confirm Password<span class="requiredField">*</span></label>
	                                                <input id="confirmNewPassword" name="confirmNewPassword" type="password" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="confirmNewPassword-errorFeedback"></div>
	                                            </div>
	                                         </div> 
	                                         
	                                         <div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-12 col2">
													<button class="btn btn-primary" id="changePassword">
								 						Change User
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
    <div class="loading" style="display:none">
		<img src="${contextPath}/resources/images/loading.gif" class="spinner" >
	</div>
	
</body>

<script src="<c:url value="/resources/js/alertify.js" />" ></script>


<script type="text/javascript">

	var errorFields = []
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	
	jQuery("document").ready(function(){
		
		initializeAlertifyTheme()
		
		jQuery("#changePassword").on("click",function(){
			jQuery("#changePassword").prop('disabled',true);
			event.preventDefault()
			removeErrorHighlights()
			if (validateInputs()) {
				updatePassword()
			} else {
				highlightErrorFields()
				jQuery("#changePassword").prop('disabled',false);
			}
		})
		
	})
	
	function compareOldPassword(){
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/user/comparePassword",
			contentType: 'application/json; charset=UTF-8',		
			data:jQuery("#oldPassword").val(),
			async: false,
			success:function(data){
				if(!data){
					var errorField = {};
					errorField.id = "oldPassword"
					errorField.message = "Incorrect Old Password";
					errorFields.push(errorField)
				}
			}
		});
	}
	
	function updatePassword(){
		jQuery(".loading").show();
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/user/updatePassword",
			contentType: 'application/json; charset=UTF-8',		
			data :getPasswordModel()
			
		}).done(function(data){
			jQuery(".loading").hide();
			jQuery("#changePassword").prop('disabled',false);
			if(data){
				  alertify.success('Password Updated');
			}else{
				alertify.error('An error occured');
			}
			clearAll()
			
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#changePassword").prop('disabled',false);
			alertify.error('An error occured');
			clearAll()
		})
		
	}
	
	function getPasswordModel(){
		var passwordModel = new Object();
		passwordModel.oldPassword = jQuery("#oldPassword").val();
		passwordModel.newPassword = jQuery("#newPassword").val();
		passwordModel.confirmPassword = jQuery("#confirmNewPassword").val();
		return JSON.stringify(passwordModel);

	}
	
	function clearAll(){
		jQuery(':input').val('');

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
		
		if(!validateOtherFields()){
			return false;
		}
		
		return true;
	}
	
	function validateOtherFields(){
		errorFields = []
		
		compareOldPassword();
		validatePasswords();
		
		return !errorFields.length > 0;
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
	
	function removeErrorHighlights(){
		jQuery(".errorFeedback").html("");
		jQuery(".form-control").css("border-color","");

	}
	
	function validatePasswords(){
		var password=jQuery("#newPassword").val();
		var repassword=jQuery("#confirmNewPassword").val()
		if(password!=repassword){
			var errorField = {};
			errorField.id = "confirmNewPassword"
			errorField.message = "Passwords did not match ";
			errorFields.push(errorField)
		}

	}
	

</script>

</html>