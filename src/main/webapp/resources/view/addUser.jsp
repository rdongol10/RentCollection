<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add User</title>
</head>
<body>
	<div class="dashboard-main-wrapper">

		<%@ include file="/resources/view/menu.jsp" %>  
	
	    <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
					<div class="col-xl-10">
						
						<!--====================================== --> 
						<!--  Ueer Form-->						
                        <!-- ===================================== -->
                        <div class="row">
                        	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        		<div class="card">
                        		
	                        		<div class="card-header">
								 		<div class="row">
								 			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							                    <h2 class="pageheader-title" id="pageheader-title">
							 						Add User
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the user</p>
								 			</div>
											
										</div>
								 	</div>
								 	
                        			<div class="card-body">
                        				<form id="userForm">
                        					<div class="row">
	                        					<div class="form-group col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5">
	                                                <label for="firstName" class="col-form-label">First Name<span class="requiredField">*</span></label>
	                                                <input id="firstName" name="firstName" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="firstName-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
	                                                <label for="middleName" class="col-form-label">Middle Name</label>
	                                                <input id="middleName" name="middleName" type="text" class="form-control required"  value=''>
	                                            	<div class="errorFeedback" id="middleName-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5">
	                                                <label for="lastName" class="col-form-label">Last Name<span class="requiredField">*</span></label>
	                                                <input id="lastName" type="text" name="lastName" class="form-control requiredInputs"  value=''>
	                                            	<div class="errorFeedback" id="lastName-errorFeedback"></div>
	                                            </div>
                        					
                        					</div>
                        			
                        					<div class="row">
                        						<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">
	                                                <label for="phoneNumber" class="col-form-label"><span class="requiredField">*</span>Phone Number</label>
	                                                <input id="phoneNumber" name="phoneNumber" type="text" class="form-control phonenumber-inputmask requiredInputs"  value=''>
	                                           		<div class="errorFeedback" id="phoneNumber-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">
	                                                <label for="emailAddress" class="col-form-label">Email Address</label>
	                                                <input id="emailAddress" name="emailAddress" type="text" class="form-control email-inputmask"  value=''>
	                                                <div class="errorFeedback" id="emailAddress-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<label for="sex" class="col-form-label">Sex</label>
													<select class="form-control" id="sex" name="sex">
														<option value="Male" >Male</option>
														<option value="Female" >Female</option>
														<option value="Others" >Others</option>
													</select>
													<div class="errorFeedback" id="sex-errorFeedback">
														
													</div>
	                                            </div>
                        					
                        						<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<label for="typeOfUser" class="col-form-label">Type of User</label>
													<select class="form-control" id="typeOfUser" name="typeOfUser">
														<option value="Admin" >Admin</option>
													</select>
													<div class="errorFeedback" id="typeOfUser-errorFeedback">
														
													</div>
	                                            </div>
                        					</div>
                        					
											<div class="row">
												<div class="form-group col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
	                                                <label for="loginName" class="col-form-label">User Name<span class="requiredField">*</span></label>
	                                                <input id="loginName" type="text" class="form-control requiredInputs" name="loginName"  value=''>
	                                                <div class="errorFeedback" id="loginName-errorFeedback">
														
													</div>
	                                            </div>
											</div>
											
											<div class="row passwordRow">
												<div class="form-group col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
	                                                <label for="password" class="col-form-label">Password<span class="requiredField">*</span></label>
	                                                <input id="password" type="password" class="form-control requiredInputs" name="password">
	                                                <div class="errorFeedback" id="password-errorFeedback">
														
													</div>
	                                            </div>
											</div>
											
											<div class="row passwordRow">
												<div class="form-group col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
	                                                <label for="rePassword" class="col-form-label">Re-enter Password<span class="requiredField">*</span></label>
	                                                <input id="rePassword" type="password" class="form-control requiredInputs" name="rePassword">
	                                                <div class="errorFeedback" id="rePassword-errorFeedback">
														
													</div>
	                                            </div>
											</div>
											<br>
											<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<button class="btn btn-primary" id="addUser">
								 						Add User
													</button>
												</div>	
											</div>
                        			
                        				</form>
                        			</div>
                        		</div>
                        	</div>
						</div>						
						
						<!--====================================== --> 
						<!--  end Ueer Form-->						
                        <!-- ===================================== -->
					</div>
				</div>
			</div>	
		</div>	
	</div>
</body>

<script src="<c:url value="/resources/js/jquery.inputmask.bundle.js" />" ></script>
<script src="<c:url value="/resources/js/inputmask.js" />" ></script>

<script>

	var errorFields = []
	var mode ="save";
	var id=0;
	
	jQuery(document).ready(function() {

		id=getURLParameter("id")
		
		if(id != undefined){
			mode="edit"
			jQuery("#loginName").attr("disabled","disabled");
			jQuery(".passwordRow").hide();
			jQuery("#addUser").html("Edit User")
			jQuery("#pageheader-title").html("Edit User")

			getUser(id)
		}else{
			var mode ="save";
			jQuery("#addUser").html("Add User")
			jQuery("#pageheader-title").html("Add User")
		}
		
		jQuery("#addUser").on("click", function(event) {
			event.preventDefault()
			removeErrorHighlights()
			if (validateInputs()) {
				if(mode =="save"){
					saveUser()
				}else if(mode="edit"){
					updateUser(id)
				}
			} else {
				highlightErrorFields()
			}

		});

	});	
	
	function removeErrorHighlights(){
		jQuery(".errorFeedback").html("");
		jQuery(".form-control").css("border-color","");

	}
	function saveUser(){
		
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/user",
			data:{
				 loginName : jQuery("#loginName").val() , firstName : jQuery("#firstName").val(),lastName : jQuery("#lastName").val(),middleName : jQuery("#middleName").val(),phoneNumber : jQuery("#phoneNumber").val(),password : jQuery("#password").val(),emailAddress : jQuery("#emailAddress").val(),sex : jQuery("#sex").val(),typeOfUser : jQuery("#typeOfUser").val() 
			}
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listUsers.jsp";
		});
	}
	
	function updateUser(userId){
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/user/"+userId,
			data:{
				 loginName : jQuery("#loginName").val() , firstName : jQuery("#firstName").val(),lastName : jQuery("#lastName").val(),middleName : jQuery("#middleName").val(),phoneNumber : jQuery("#phoneNumber").val(),emailAddress : jQuery("#emailAddress").val(),sex : jQuery("#sex").val(),typeOfUser : jQuery("#typeOfUser").val() 
			}
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listUsers.jsp";
		});
	}
	
	
	function getUser(id){
		
		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/user/"+id
			
		}).done(function(data){
			loadUserData(data)
		});
		
	}
	
	function loadUserData(data){
		jQuery("#firstName").val(data.firstName);
		jQuery("#lastName").val(data.lastName);
		jQuery("#middleName").val(data.middleName);
		jQuery("#phoneNumber").val(data.phoneNumber);
		jQuery("#emailAddress").val(data.emailAddress);
		jQuery("#loginName").val(data.loginName);
		jQuery("#typeOfUser option[value="+data.typeOfUser+"]").attr("selected","selected");
		jQuery("#sex option[value="+data.sex+"]").attr("selected","selected");

		
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
		validatePhoneNumber();
		
		if(mode == "save"){
			
			validatePasswords();
			doesUserNameExists();
		}
		
		return !errorFields.length > 0;
	}
	
	function validatePasswords(){
		var password=jQuery("#password").val();
		var repassword=jQuery("#rePassword").val()
		if(password!=repassword){
			var errorField = {};
			errorField.id = "rePassword"
			errorField.message = "Passwords did not match ";
			errorFields.push(errorField)
		}

	}

	
	function validatePhoneNumber() {
		if(!/^[0-9]{10}$/.test(jQuery("#phoneNumber").val())){
			var errorField = {};
			errorField.id = "phoneNumber"
			errorField.message = "Phone Number should be of 10 digits";
			errorFields.push(errorField)
		}

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
	
	function doesUserNameExists(){
		var userName=jQuery("#loginName").val()
		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/user/userExists/"+userName,
			async: false,
			success:function(data){
				if(data == "true"){
					var errorField = {};
					errorField.id = "loginName"
					errorField.message = "User Name already exists";
					errorFields.push(errorField)
				}
			}
		});
	}
	

</script>
</html>