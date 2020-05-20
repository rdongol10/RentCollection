<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Add Rentee</title>
	<link href="<c:url value="/resources/css/fileDrop.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
	<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">

	<style type="text/css">
		.dropzone-wrapper{
			height: 200px;
		  	width : 100%;
			
		}
		.profileImageWrapper{
			width: 150px;
		}
		.dropzone,
		.dropzone:focus {
			height: 200px;
		}
		
		.imageholder{
			position: relative;
			height: 200px;
			display : none;
		}
		
		.displayImage {
		 	height: 200px;
		  	width : 100%;
		 	
		}
		
		.profileDisplayImage{
			width: 150px;
		}
		
		.imageholder .btn{
			position: absolute;
  			top: 50%;
 			transform: translate(-50%, -50%);
  			-ms-transform: translate(-50%, -50%);
	 		cursor: pointer;
 			border-radius: 50%;
 			line-height: unset;
 			display : none;
 			opacity : 0.5;
 			
		}
		
		.imageholder .btn:hover{
			opacity : 1;
		}
		
		.imageholder .imageEdit{
			left : 50px;
			color : #313A8C;
			background-color : #5969FF;
		}
		
		.imageholder .imageDelete{
			left : 100px;
			color : #BE182D;
			background-color: #F6ACB5;
		}
		
		.renteeDependent {
			border-top : 1px solid #e6e6f2 ;
			margin-top: 20px
		}
		
		.removeRenteeDependentHolder .btn{
		    margin-top: 220px;
    		cursor: pointer;
 			border-radius: 50%;
 			line-height: unset;
 			color : #BE182D;
			background-color: #F6ACB5;
			opacity : 0.5;
		}
		
		.removeRenteeDependentHolder .btn:hover{
			opacity : 1;
		}
	</style>
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
							 						Add Rentee
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the rentee</p>
								 			</div>
										</div>
									</div>
									
									<form id="renteeForm">
									
										<div class="card-body">
										
											<div class="row">
											
	                                             <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col3 imageColumn">
													<label for="renteeImage" class="col-form-label">Rentee Image<span class="requiredField">*</span></label>
	                                             
													<div class="dropzone-wrapper profileImageWrapper">
														<div class="dropzone-desc">
															 <i class="fas fa-download"></i>
															<p>Choose an image file or drag it here.</p>
														</div>
														<input type="file" name="renteeImage" id="renteeImage" class="dropzone" >
														
													</div>
													
													<div class="imageholder">
														<img src=""  id="displayRenteeImage" class="displayImage profileDisplayImage"></img>
														<i class="fas fa-pencil-alt btn imageEdit"></i>
														<i class="fas fa-trash-alt btn imageDelete"></i>
													</div>
													<div class="errorFeedback" id="displayRenteeImage-errorFeedback"></div>
												</div>
												
												<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col4 imageColumn">
													<label for="citizenshipImage" class="col-form-label">Citizenship Image<span class="requiredField">*</span></label>
	                                             
													<div class="dropzone-wrapper ">
														<div class="dropzone-desc">
															 <i class="fas fa-download"></i>
															<p>Choose an image file or drag it here.</p>
														</div>
														<input type="file" name="citizenshipImage" id="citizenshipImage" class="dropzone" >
														
													</div>
													
													<div class="imageholder">
														<img src=""  id="displayCitizenshipImage" class="displayImage"></img>
														<i class="fas fa-pencil-alt btn imageEdit"></i>
														<i class="fas fa-trash-alt btn imageDelete"></i>
													</div>
													
													<div class="errorFeedback" id="displayCitizenshipImage-errorFeedback"></div>
													
												</div>
												
												<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col4 imageColumn">
													<label for="citizenshipBackImage" class="col-form-label">Citizenship Back Image<span class="requiredField">*</span></label>
	                                             
													<div class="dropzone-wrapper ">
														<div class="dropzone-desc">
															 <i class="fas fa-download"></i>
															<p>Choose an image file or drag it here.</p>
														</div>
														<input type="file" name="citizenshipBackImage" id="citizenshipBackImage" class="dropzone" >
														
													</div>
													
													<div class="imageholder">
														<img src=""  id="displayCitizenshipBackImage" class="displayImage"></img>
														<i class="fas fa-pencil-alt btn imageEdit"></i>
														<i class="fas fa-trash-alt btn imageDelete"></i>
													</div>
													
													<div class="errorFeedback" id="displayCitizenshipBackImage-errorFeedback"></div>
													
												</div>
												
											</div>
											<br>
											
											<div class="row">
												<input id="id" name="id" type="hidden">
												<div class="form-group col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">
	                                                <label for="firstName" class="col-form-label">First Name<span class="requiredField">*</span></label>
	                                                <input id="firstName" name="firstName" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="firstName-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-2 col-lg-2 col-md-6 col-sm-12 col2">
	                                                <label for="middleName" class="col-form-label">Middle Name</label>
	                                                <input id="middleName" name="middleName" type="text" class="form-control" value=''>
													<div class="errorFeedback" id="middleName-errorFeedback"></div>
	                                            </div>
												<div class="form-group col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">
	                                                <label for="lastName" class="col-form-label">Last Name<span class="requiredField">*</span></label>
	                                                <input id="lastName" name="lastName" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="lastName-errorFeedback"></div>
	                                            </div>
	                                           <div class="form-group col-xl-2 col-lg-2 col-md-6 col-sm-12 col2">
													<label for="sex" class="col-form-label">Sex</label>
													<select class="form-control" id="sex" name="sex">
														<option value="Male" >Male</option>
														<option value="Female" >Female</option>
														<option value="Others" >Others</option>
													</select>
													<div class="errorFeedback" id="sex-errorFeedback">
														
													</div>
	                                            </div>
											</div>
											
											<div class="row">
												<div class="form-group col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">
	                                                <label for="address" class="col-form-label">Address<span class="requiredField">*</span></label>
	                                                <input id="address" name="address" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="address-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
	                                                <label for="phoneNumber" class="col-form-label">Phone Number<span class="requiredField">*</span></label>
	                                                <input id="phoneNumber" name="phoneNumber" type="text" class="form-control requiredInputs phonenumber-inputmask" value=''>
													<div class="errorFeedback" id="phoneNumber-errorFeedback"></div>
	                                            </div>
	                                             <div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
	                                                <label for="emailId" class="col-form-label">Email</label>
	                                                <input id="emailId" name="emailId" type="text" class="form-control email-inputmask" value=''>
													<div class="errorFeedback" id="emailId-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-2 col-lg-2 col-md-6 col-sm-12 col2">
	                                                <label for="citizenshipNumber" class="col-form-label">Citizenship No.<span class="requiredField">*</span></label>
	                                                <input id="citizenshipNumber" name="citizenshipNumber" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="citizenshipNumber-errorFeedback"></div>
	                                            </div>
											</div>
											
											<div class="row">
												<div class="form-group col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">
	                                                <label for="dob" class="col-form-label">Date of Birth<span class="requiredField">*</span></label>
	                                                <input id="dob" name="dob" type="text" class="form-control requiredInputs dob date" value=''>
													<div class="errorFeedback" id="dob-errorFeedback"></div>
	                                            </div>
											</div>
											
										</div>
										
										<div class="card-body border-top" id="renteeDependents">
									 		<div class="row">
                                    	    	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
                                    	    		Rentee Dependents
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
											        <Button class="btn btn-success topAddButton" id="addRenteeDependent" >
												    	<i class="fas fa-plus"></i>  &nbsp; Add Rentee Dependent
													</Button>
													
												</div>
											</div>
								 		</div>
								 		
								 		<div class="card-body border-top" >
								 		
								 			<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<button class="btn btn-primary" id="addRentee">
								 						Add Rentee
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
	
	<div class="loading" style="display:none">
		<img src="${contextPath}/resources/images/loading.gif" class="spinner" >
	</div>
	
</body>

<script src="<c:url value="/resources/js/jquery.inputmask.bundle.js" />" ></script>
<script src="<c:url value="/resources/js/inputmask.js" />" ></script>
<script src="<c:url value="/resources/js/alertify.js" />" ></script>

<script type="text/javascript">
	var errorFields= [];
	var mode ="save";
	var id = 0;
	var renteeDependentCount = 0 ;
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
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
	
	jQuery(document).ready(function(){
		
		initializeAlertifyTheme();
		id=getURLParameter("id");
		
		
		
		jQuery("#renteeForm").on("focus",".date",function(){
			initializeDatePicker(this);
		})
		
		function initializeDatePicker(element){
			console.log(element)
			jQuery(element).datepicker({
				changeMonth : true,
				changeYear : true,
				changeDay : true,
			});
		}
		
		
		if(id != undefined){
			mode="edit"
			jQuery("#addRentee").html("Edit Rentee")
			jQuery("#pageheader-title").html("Edit Rentee")
			getRentee(id)
		}else{
			mode ="save";
			jQuery("#addRentee").html("Add Rentee")
			jQuery("#pageheader-title").html("Add Rentee")
		}
		
		jQuery("#renteeForm").on("mouseover",".imageholder",function(){
			jQuery(this).find(".btn").show();
		})
		
		jQuery("#renteeForm").on("mouseout",".imageholder",function(){
			jQuery(this).find(".btn").hide();
		})
		jQuery("#renteeForm").on('dragover','.dropzone-wrapper', function(e) {
			e.preventDefault();
			e.stopPropagation();
			jQuery(this).addClass('dragover');
		});
		
		jQuery('#renteeForm').on('dragleave', '.dropzone-wrapper',function(e) {
			e.preventDefault();
			e.stopPropagation();
			jQuery(this).removeClass('dragover');
		});
		
		jQuery("#renteeForm").on("change",".dropzone",function() {
			readFile(this)
			jQuery(this).closest('.dropzone-wrapper').removeClass('dragover');
		});
		
		jQuery("#renteeForm").on("click",".imageDelete",function() {
			removeImage(this)
		});		
		
		jQuery("#renteeForm").on("click",".imageEdit",function() {
			triggerFileLoader(this)
		});
		
		jQuery("#addRenteeDependent").on("click",function(){
			event.preventDefault();
			
			jQuery("#renteeDependents").append(getRenteeDependentHTML());
			
		})
		
		jQuery("#renteeDependents").on("click",".removeRenteeDependent",function(){
			removeRenteeDependent(this);
		})
		
		jQuery("#addRentee").on("click",function(){
			jQuery("#addRentee").prop('disabled',true);

			event.preventDefault();
			removeErrorHighlights();
			if(validateInputs()){
				if(mode =="save"){
					saveRentee()
				}else{
					updateRentee(id)
				}	
			}else{
				jQuery("#addRentee").prop('disabled',false);
				highlightErrorFields()
			}
		})
	});//end of document ready
	
	function getRentee(id){
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/rentee/getRenteeModel/"+id
		}).done(function(data){
			console.log(data)	
			loadRenteeData(data)
		});	
	}
	
	function loadRenteeData(data){
		jQuery("#id").val(data.id);
		jQuery("#firstName").val(data.firstName);
		jQuery("#lastName").val(data.lastName);
		jQuery("#middleName").val(data.middleName);
		jQuery("#phoneNumber").val(data.phoneNumber);
		jQuery("#citizenshipNumber").val(data.citizenshipNumber);
		jQuery("#emailId").val(data.emailId);
		jQuery("#sex option[value="+data.sex+"]").attr("selected","selected");
		jQuery("#dob").val(data.dob);
		jQuery("#address").val(data.address);
		jQuery("#displayRenteeImage").attr("src","data:image/png;base64,"+data.renteeImageBase64)
		jQuery("#displayCitizenshipImage").attr("src","data:image/png;base64,"+data.citizenshipImageBase64)
		jQuery("#displayCitizenshipBackImage").attr("src","data:image/png;base64,"+data.citizenshipBackImageBase64)

		loadRenteeDependentData(data.renteeDependentModels);
		displayImages();
	}
	
	function loadRenteeDependentData(renteeDependentModels){
		var html="";
		for(var i=0 ; i<renteeDependentModels.length ; i++){
			html += '<div class="renteeDependent" id="renteeDependent-'+renteeDependentCount+'">';
			html += '<div class="row">'
			html += '<div class="form-group col-xl-10 col-lg-10 col-md-10 col-sm-10 col-10">'
			
			html += '<div class="row">'
			html += '<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 imageColumn">'
			html += '<label for="renteeDependentImage" class="col-form-label">Rentee Dependent Image<span class="requiredField">*</span></label>'
			html += '<div class="dropzone-wrapper profileImageWrapper">'
			html += '<div class="dropzone-desc">'
			html += '<i class="fas fa-download"></i>'
			html += '<p>Choose an image file or drag it here.</p>'
			html += '</div>'
			html += '<input type="file" name="renteeDependentImage" id="renteeDependentImage-'+renteeDependentCount+'" class="dropzone" >'
			html += '</div>'
			html += '<div class="imageholder">'
			html += '<img src="data:image/png;base64,'+renteeDependentModels[i].renteeDependentImageBase64+'"  id="displayRenteeDependentImage-'+renteeDependentCount+'" class="displayImage profileDisplayImage"></img>'
			html += '<i class="fas fa-pencil-alt btn imageEdit"></i>'
			html += '<i class="fas fa-trash-alt btn imageDelete"></i>'
			html += '</div>'
			html += '<div class="errorFeedback" id="displayRenteeDependentImage-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '</div>'
			html += '<br>'	
			
			html += '<div class="row">'
			html += '<input type="hidden" class="renteeDependentId" id="renteeDependentId-'+renteeDependentCount+'" value="'+renteeDependentModels[i].id+'">'
			html += '<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">'
			html += '<label for="renteeDependentFirstName" class="col-form-label">First Name<span class="requiredField">*</span></label>'
			html += '<input id="renteeDependentFirstName-'+renteeDependentCount+'" name="renteeDependentFirstName" type="text" class="form-control requiredInputs renteeDependentFirstName" value="'+renteeDependentModels[i].firstName+'">'
			html += '<div class="errorFeedback" id="renteeDependentFirstName-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">'
			html += '<label for="renteeDependentMiddleName" class="col-form-label">Middle Name</label>'
			html += '<input id="renteeDependentMiddleName-'+renteeDependentCount+'" name="renteeDependentMiddleName" type="text" class="form-control renteeDependentMiddleName" value="'+renteeDependentModels[i].middleName+'">'
			html += '<div class="errorFeedback" id="renteeDependentMiddleName-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">'
			html += '<label for="renteeDependentLastName" class="col-form-label">Last Name<span class="requiredField">*</span></label>'
			html += '<input id="renteeDependentLastName-'+renteeDependentCount+'" name="renteeDependentLastName" type="text" class="form-control requiredInputs renteeDependentLastName" value="'+renteeDependentModels[i].lastName+'">'
			html += '<div class="errorFeedback" id="renteeDependentLastName-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">'
			var sex = renteeDependentModels[i].sex;
			html += '<label for="renteeDependentSex" class="col-form-label">Sex</label>'
			html += '<select class="form-control renteeDependentSex" id="renteeDependentSex-'+renteeDependentCount+'" name="renteeDependentSex">'
			html += '<option value="male"' 
			if(sex == "male"){
				html += ' selected '				
			}
			html += '>Male</option>'
			html += '<option value="female" '
				if(sex == "female"){
					html += ' selected '				
				}
			html += '>Female</option>'
			html += '<option value="others" '
				if(sex == "others"){
					html += ' selected '				
				}
			html += '>Others</option>'
			html += '</select>'
			html += '<div class="errorFeedback" id="renteeDependentRelationship-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '</div>'
			
			html += '<div class="row">'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<label for="renteeDependentAddress" class="col-form-label">Address</label>'
			html += '<input id="renteeDependentAddress-'+renteeDependentCount+'" name="renteeDependentAddress" type="text" class="form-control renteeDependentAddress" value="'+renteeDependentModels[i].address+'">'
			html += '<div class="errorFeedback" id="renteeDependentAddress-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<label for="renteeDependentPhoneNumber" class="col-form-label">Phone Number</label>'
			html += '<input id="renteeDependentPhoneNumber-'+renteeDependentCount+'" name="renteeDependentPhoneNumber" type="text" class="form-control renteeDependentPhoneNumber phonenumber-inputmask" value="'+renteeDependentModels[i].phoneNumber+'">'
			html += '<div class="errorFeedback" id="renteeDependentPhoneNumber-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<label for="renteeDependentEmailId" class="col-form-label">Email</label>'
			html += '<input id="renteeDependentEmailId-'+renteeDependentCount+'" name="renteeDependentEmailId" type="text" class="email-inputmask form-control email renteeDependentEmailId" value="'+renteeDependentModels[i].emailId+'">'
			html += '<div class="errorFeedback" id="renteeDependentEmailId-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<label for="renteeDependentCitizenshipNumber" class="col-form-label">Citizenship No.</label>'
			html += '<input id="renteeDependentCitizenshipNumber-'+renteeDependentCount+'" name="renteeDependentCitizenshipNumber" type="text" class="form-control renteeDependentCitizenshipNumber" value="'+renteeDependentModels[i].citizenshipNumber+'">'
			html += '<div class="errorFeedback" id="renteeDependentCitizenshipNumber-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '</div>'
		
			var relationship = renteeDependentModels[i].relationship;
			html += '<div class="row">'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<label for="renteeDependentRelationship" class="col-form-label">Relationship</label>'
			html += '<select class="form-control renteeDependentRelationship" id="renteeDependentRelationship-'+renteeDependentCount+'" name="renteeDependentRelationship">'
			html += '<option value="spouse" ';
			
			if(relationship == "spouse"){
				html += 'selected'
			}
				
			html += '>Spauce</option>'
			html += '<option value="child"'
				if(relationship == "child"){
					html += 'selected'
				}
			html += '>Child</option>'
			html += '<option value="siblings"'
				if(relationship == "siblings"){
					html += 'selected'
				}
			html += '>siblings</option>'
			html += '<option value="friend" '
				if(relationship == "friend"){
					html += 'selected'
				}
			html += '>friend</option>'
			html += '<option value="others"'	
				if(relationship == "others"){
					html += 'selected'
				}
			html += '>others</option>'
			html += '</select>'
			html += '<div class="errorFeedback" id="renteeDependentRelationship-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<label for="renteeDependentDob" class="col-form-label">Date of Birth<span class="requiredField">*</span></label>'
			html += '<input id="renteeDependentDob-'+renteeDependentCount+'" name="renteeDependentDob" type="text" class="form-control requiredInputs renteeDependentDob date" value="'+renteeDependentModels[i].dob+'">'
			html += '<div class="errorFeedback" id="renteeDependentDob-'+renteeDependentCount+'-errorFeedback"></div>'
			html += '</div>'
			html += '</div>'
					
			html += '</div>'
			
			html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 removeRenteeDependentHolder">'
			html += '<i class = "removeRenteeDependent fas fa-trash-alt btn" id="removeRenteeDependent-'+renteeDependentCount+'" count="'+renteeDependentCount+'"></i>';
			html += '</div>'
			html += '</div>'
			html += '</div>'
			
			renteeDependentCount++;
		}
		
		jQuery("#renteeDependents").append(html);
	}
	function displayImages(){
		jQuery(".imageColumn").each(function(){
			
			jQuery(this).find(".imageholder").show();
			jQuery(this).find(".dropzone-wrapper").hide();
			
		})
		
	}
	
	function updateRentee(id){
		
		jQuery(".loading").show();
		var rentee = getRenteeData(mode)
		
		jQuery.ajax({
			
			method : "PUT",
			url : "${contextPath}/rentee/"+id,
			contentType: 'application/json; charset=UTF-8',		
			data : rentee
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listRentee.jsp";
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#addUser").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured while editing the Renting.</div>").setHeader("<b>Error</b>");
		});
	}
	
	function saveRentee(){
		jQuery(".loading").show();
		var rentee = getRenteeData(mode)
		
		jQuery.ajax({
			
			method : "POST",
			url : "${contextPath}/rentee",
			contentType: 'application/json; charset=UTF-8',		
			data : rentee
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listRentee.jsp";
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#addUser").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured while creating the Rentee.</div>").setHeader("<b>Error</b>");
		});
	}
	
	function getRenteeData(mode){
		var renteeData = new Object();
		if(mode=="edit"){
			renteeData.id=jQuery("#id").val();
		}	
		renteeData.firstName=jQuery("#firstName").val();
		renteeData.lastName=jQuery("#lastName").val();
		renteeData.middleName=jQuery("#middleName").val();
		renteeData.phoneNumber=jQuery("#phoneNumber").val();
		renteeData.citizenshipNumber=jQuery("#citizenshipNumber").val();
		renteeData.emailId=jQuery("#emailId").val();
		renteeData.address=jQuery("#address").val();
		renteeData.sex=jQuery("#sex").val();
		renteeData.dob=jQuery("#dob").val();
		renteeData.renteeImageBase64=jQuery("#displayRenteeImage").attr("src")
		renteeData.citizenshipImageBase64=jQuery("#displayCitizenshipImage").attr("src")
		renteeData.citizenshipBackImageBase64=jQuery("#displayCitizenshipBackImage").attr("src")
		renteeData.renteeDependentModels=getRenteeDependentsData(mode);
		return JSON.stringify(renteeData);

	}
	
	function getRenteeDependentsData(mode){
		var renteeDependents = []
		
		jQuery(".renteeDependent").each(function(){
			var renteeDependent = new Object();
			if(mode=="edit"){
				renteeDependent.id=$(this).find('.renteeDependentId').val();
			}
			renteeDependent.firstName=$(this).find('.renteeDependentFirstName').val();
			renteeDependent.lastName=$(this).find('.renteeDependentLastName').val();
			renteeDependent.middleName=$(this).find('.renteeDependentMiddleName').val();
			renteeDependent.phoneNumber=$(this).find('.renteeDependentPhoneNumber').val();
			renteeDependent.citizenshipNumber=$(this).find('.renteeDependentCitizenshipNumber').val();
			renteeDependent.relationship=$(this).find('.renteeDependentRelationship').val();
			renteeDependent.emailId=$(this).find('.renteeDependentEmailId').val();
			renteeDependent.address=$(this).find('.renteeDependentAddress').val();
			renteeDependent.sex=$(this).find('.renteeDependentSex').val();
			renteeDependent.dob=$(this).find('.renteeDependentDob').val();
			renteeDependent.renteeDependentImageBase64=$(this).find('.profileDisplayImage').attr("src");

			renteeDependents.push(renteeDependent)	
			
		})
		return renteeDependents;

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
		validateImages();
		validateDate();
		validatePhoneNumber();
		return !errorFields.length > 0;
	}
	
	function validatePhoneNumber() {
		
		jQuery(".phonenumber-inputmask").each(function(){
			if(jQuery(this).val().trim() == ""){
				return;
			}
			if(!/^[0-9]{10}$/.test(jQuery(this).val())){
				var errorField = {};
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Phone Number should be of 10 digits";
				errorFields.push(errorField)
			}
		})

	}
	
	function validateDate(){
		jQuery(".date").each(function(){
			var errorField = {};
			var date = jQuery(this).val();	
			var datePattern =/^(?:(?:31(\/)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/
			if(!datePattern.test(date)){
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Invalid date . Must be MM/DD/YYYY";
				errorFields.push(errorField)
			}	
		})
		
	}
	function validateImages(){
		jQuery(".displayImage").each(function(){
			var errorField = {};
		    if(jQuery(this).attr("src").trim() == ""){
		    	errorField.id = jQuery(this).attr("id");
				errorField.message = "Please add the image";
				errorFields.push(errorField)
		    }
		})
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
	
	function removeRenteeDependent(removeRenteeDependent){
		var count = jQuery(removeRenteeDependent).attr("count");
		jQuery("#renteeDependent-"+count).remove();

	}
	
	function triggerFileLoader(clickedButton){
		var imageColumn = jQuery(clickedButton).closest(".imageColumn");
		var fileInput = jQuery(imageColumn).find(".dropzone");
		jQuery(fileInput).trigger('click')
	}
	
	function removeImage(clickedButton){
		var imageColumn = jQuery(clickedButton).closest(".imageColumn");
		var imageHolder =jQuery(imageColumn).find(".imageholder");
		jQuery(imageHolder).find(".displayImage").attr("src","");
		jQuery(imageHolder).hide();
		jQuery(imageColumn).find(".dropzone-wrapper").show();
	}
	
	function readFile(input){
		var errorFiles = [];
		if(input.files[0].type == "image/jpeg" || input.files[0].type == "image/png"){
			getBase64(input.files[0],function(e){
				var imageColumn = jQuery(input).closest(".imageColumn");
				var imageHolder =jQuery(imageColumn).find(".imageholder");
				jQuery(imageHolder).find(".displayImage").attr("src",e.target.result)
				
				jQuery(imageHolder).show();
				jQuery(input).closest(".dropzone-wrapper").hide();
				
			})
		}else{
			errorFiles.push(input.files[0].name)
		}
		if(errorFiles.length >0){
			
			alertify.alert("<div style='color:red'>"+errorFiles + " are invalid files. Only upload .png or .jpg files</div>").setHeader("<b>Error Files</b>");
		
		}
		
		jQuery(input).val("");
	}
	
	function getBase64(file, onLoadCallback) {
			
	    var reader = new FileReader();
	    reader.readAsDataURL(file);
	    reader.onload = onLoadCallback;
	    reader.onerror = function(error) {
	        console.log('Error when converting PDF file to base64: ', error);
	    };
	}
	
	function getRenteeDependentHTML(){
		var html= "";
		
		html += '<div class="renteeDependent" id="renteeDependent-'+renteeDependentCount+'">';
		html += '<div class="row">'
		html += '<div class="form-group col-xl-10 col-lg-10 col-md-10 col-sm-10 col-10">'
		
		html += '<div class="row">'
		html += '<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col3 imageColumn">'
		html += '<label for="renteeDependentImage" class="col-form-label">Rentee Dependent Image<span class="requiredField">*</span></label>'
		html += '<div class="dropzone-wrapper profileImageWrapper">'
		html += '<div class="dropzone-desc">'
		html += '<i class="fas fa-download"></i>'
		html += '<p>Choose an image file or drag it here.</p>'
		html += '</div>'
		html += '<input type="file" name="renteeDependentImage" id="renteeDependentImage-'+renteeDependentCount+'" class="dropzone" >'
		html += '</div>'
		html += '<div class="imageholder">'
		html += '<img src=""  id="displayRenteeDependentImage-'+renteeDependentCount+'" class="displayImage profileDisplayImage"></img>'
		html += '<i class="fas fa-pencil-alt btn imageEdit"></i>'
		html += '<i class="fas fa-trash-alt btn imageDelete"></i>'
		html += '</div>'
		html += '<div class="errorFeedback" id="displayRenteeDependentImage-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
		html += '<br>'	
		
		html += '<div class="row">'
		html += '<input type="hidden" class="renteeDependentId" id="renteeDependentId-'+renteeDependentCount+'" value="">'
		html += '<div class="form-group col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">'
		html += '<label for="renteeDependentFirstName" class="col-form-label">First Name<span class="requiredField">*</span></label>'
		html += '<input id="renteeDependentFirstName-'+renteeDependentCount+'" name="renteeDependentFirstName" type="text" class="form-control requiredInputs renteeDependentFirstName" value="">'
		html += '<div class="errorFeedback" id="renteeDependentFirstName-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-6 col-sm-12 col2">'
		html += '<label for="renteeDependentMiddleName" class="col-form-label">Middle Name</label>'
		html += '<input id="renteeDependentMiddleName-'+renteeDependentCount+'" name="renteeDependentMiddleName" type="text" class="form-control renteeDependentMiddleName" value="">'
		html += '<div class="errorFeedback" id="renteeDependentMiddleName-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">'
		html += '<label for="renteeDependentLastName" class="col-form-label">Last Name<span class="requiredField">*</span></label>'
		html += '<input id="renteeDependentLastName-'+renteeDependentCount+'" name="renteeDependentLastName" type="text" class="form-control requiredInputs renteeDependentLastName" value="">'
		html += '<div class="errorFeedback" id="renteeDependentLastName-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-12 col-sm-12 col2">'
		html += '<label for="renteeDependentSex" class="col-form-label">Sex</label>'
		html += '<select class="form-control renteeDependentSex" id="renteeDependentSex-'+renteeDependentCount+'" name="renteeDependentSex">'
		html += '<option value="male" >Male</option>'
		html += '<option value="female" >Female</option>'
		html += '<option value="others" >others</option>'	
		html += '</select>'
		html += '<div class="errorFeedback" id="renteeDependentRelationship-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
		
		html += '<div class="row">'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="renteeDependentAddress" class="col-form-label">Address</label>'
		html += '<input id="renteeDependentAddress-'+renteeDependentCount+'" name="renteeDependentAddress" type="text" class="form-control renteeDependentAddress" value="">'
		html += '<div class="errorFeedback" id="renteeDependentAddress-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="renteeDependentPhoneNumber" class="col-form-label">Phone Number</label>'
		html += '<input id="renteeDependentPhoneNumber-'+renteeDependentCount+'" name="renteeDependentPhoneNumber" type="text" class="form-control renteeDependentPhoneNumber phonenumber-inputmask" value="">'
		html += '<div class="errorFeedback" id="renteeDependentPhoneNumber-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="renteeDependentEmailId" class="col-form-label">Email</label>'
		html += '<input id="renteeDependentEmailId-'+renteeDependentCount+'" name="renteeDependentEmailId" type="text" class="email-inputmask form-control email renteeDependentEmailId" value="">'
		html += '<div class="errorFeedback" id="renteeDependentEmailId-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="renteeDependentCitizenshipNumber" class="col-form-label">Citizenship No.</label>'
		html += '<input id="renteeDependentCitizenshipNumber-'+renteeDependentCount+'" name="renteeDependentCitizenshipNumber" type="text" class="form-control renteeDependentCitizenshipNumber" value="">'
		html += '<div class="errorFeedback" id="renteeDependentCitizenshipNumber-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
	
		html += '<div class="row">'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="renteeDependentRelationship" class="col-form-label">Relationship</label>'
		html += '<select class="form-control renteeDependentRelationship" id="renteeDependentRelationship-'+renteeDependentCount+'" name="renteeDependentRelationship">'
		html += '<option value="spouse" >Spauce</option>'
		html += '<option value="child" >Child</option>'
		html += '<option value="siblings" >Siblings</option>'
		html += '<option value="friend" >Friend</option>'
		html += '<option value="others" >others</option>'	
		html += '</select>'
		html += '<div class="errorFeedback" id="renteeDependentRelationship-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="renteeDependentDob" class="col-form-label">Date of Birth<span class="requiredField">*</span></label>'
		html += '<input id="renteeDependentDob-'+renteeDependentCount+'" name="renteeDependentDob" type="text" class="form-control requiredInputs renteeDependentDob date" value="">'
		html += '<div class="errorFeedback" id="renteeDependentDob-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
				
		html += '</div>'
		
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 removeRenteeDependentHolder">'
		html += '<i class = "removeRenteeDependent fas fa-trash-alt btn" id="removeRenteeDependent-'+renteeDependentCount+'" count="'+renteeDependentCount+'"></i>';
		html += '</div>'
		html += '</div>'
		html += '</div>'
		
		renteeDependentCount++;
		return html;
	}
</script>
</html>