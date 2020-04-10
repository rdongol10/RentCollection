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
    		margin-left: 70px;
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
											
	                                             <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 imageColumn">
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
												
												<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4 imageColumn">
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
													
													<div class="errorFeedback" id="citizenshipImage-errorFeedback"></div>
													
												</div>
												
												<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4 imageColumn">
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
													
													<div class="errorFeedback" id="citizenshipBackImage-errorFeedback"></div>
													
												</div>
												
											</div>
											<br>
											
											<div class="row">
												<input id="id" name="id" type="hidden">
												<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">
	                                                <label for="firstName" class="col-form-label">First Name<span class="requiredField">*</span></label>
	                                                <input id="firstName" name="firstName" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="firstName-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
	                                                <label for="middleName" class="col-form-label">Middle Name</label>
	                                                <input id="middleName" name="middleName" type="text" class="form-control" value=''>
													<div class="errorFeedback" id="middleName-errorFeedback"></div>
	                                            </div>
												<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">
	                                                <label for="lastName" class="col-form-label">Last Name<span class="requiredField">*</span></label>
	                                                <input id="lastName" name="lastName" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="lastName-errorFeedback"></div>
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
											</div>
											
											<div class="row">
												<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">
	                                                <label for="address" class="col-form-label">Address<span class="requiredField">*</span></label>
	                                                <input id="address" name="address" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="address-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="phoneNumber" class="col-form-label">Phone Number<span class="requiredField">*</span></label>
	                                                <input id="phoneNumber" name="phoneNumber" type="text" class="form-control requiredInputs phonenumber-inputmask" value=''>
													<div class="errorFeedback" id="phoneNumber-errorFeedback"></div>
	                                            </div>
	                                             <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="emailId" class="col-form-label">Email</label>
	                                                <input id="emailId" name="emailId" type="text" class="form-control email-inputmask" value=''>
													<div class="errorFeedback" id="emailId-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
	                                                <label for="citizenshipNumber" class="col-form-label">Citizenship No.<span class="requiredField">*</span></label>
	                                                <input id="citizenshipNumber" name="citizenshipNumber" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="citizenshipNumber-errorFeedback"></div>
	                                            </div>
											</div>
											
											<div class="row">
												<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">
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
	
	jQuery(document).ready(function(){
		
		initializeAlertifyTheme();
		
		jQuery("#renteeForm").on("focus",".date",function(){
			initializeDatePicker(this);
		})
		
		function initializeDatePicker(element){
			jQuery(element).datepicker({
				changeMonth : true,
				changeYear : true,
				changeDay : true
			});
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
			event.preventDefault();
		})
	})
	
	function removeRenteeDependent(removeRenteeDependent){
		var count = jQuery(removeRenteeDependent).attr("count");
		jQuery("#renteeDependent-"+count).remove();

		renteeDependent
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
		html += '<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">'
		html += '<label for="renteeDependentFirstName" class="col-form-label">First Name<span class="requiredField">*</span></label>'
		html += '<input id="renteeDependentFirstName-'+renteeDependentCount+'" name="renteeDependentFirstName" type="text" class="form-control requiredInputs renteeDependentFirstName" value="">'
		html += '<div class="errorFeedback" id="renteeDependentFirstName-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">'
		html += '<label for="renteeDependentMiddleName" class="col-form-label">Middle Name</label>'
		html += '<input id="renteeDependentMiddleName-'+renteeDependentCount+'" name="renteeDependentMiddleName" type="text" class="form-control renteeDependentMiddleName" value="">'
		html += '<div class="errorFeedback" id="renteeDependentMiddleName-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-4 col-4">'
		html += '<label for="renteeDependentLastName" class="col-form-label">Last Name<span class="requiredField">*</span></label>'
		html += '<input id="renteeDependentLastName-'+renteeDependentCount+'" name="renteeDependentLastName" type="text" class="form-control requiredInputs renteeDependentLastName" value="">'
		html += '<div class="errorFeedback" id="renteeDependentLastName-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">'
		html += '<label for="renteeDependentSex" class="col-form-label">Sex<span class="requiredField">*</span></label>'
		html += '<select class="form-control renteeDependentSex" id="renteeDependentSex-'+renteeDependentCount+'" name="renteeDependentSex">'
		html += '<option value="male" >Male</option>'
		html += '<option value="female" >Female</option>'
		html += '<option value="others" >others</option>'	
		html += '</select>'
		html += '<div class="errorFeedback" id="renteeDependentRelationship-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
		
		html += '<div class="row">'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="renteeDependentAddress" class="col-form-label">Address</label>'
		html += '<input id="renteeDependentAddress-'+renteeDependentCount+'" name="renteeDependentAddress" type="text" class="form-control renteeDependentAddress" value="">'
		html += '<div class="errorFeedback" id="renteeDependentAddress-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="renteeDependentPhoneNumber" class="col-form-label">Phone Number</label>'
		html += '<input id="renteeDependentPhoneNumber-'+renteeDependentCount+'" name="renteeDependentPhoneNumber" type="text" class="form-control renteeDependentPhoneNumber phonenumber-inputmask" value="">'
		html += '<div class="errorFeedback" id="renteeDependentPhoneNumber-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="renteeDependentEmailId" class="col-form-label">Email</label>'
		html += '<input id="renteeDependentEmailId-'+renteeDependentCount+'" name="renteeDependentEmailId" type="text" class="form-control email-renteeDependentEmailId" value="">'
		html += '<div class="errorFeedback" id="renteeDependentEmailId-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="renteeDependentCitizenshipNumber" class="col-form-label">Citizenship No.<span class="requiredField">*</span></label>'
		html += '<input id="renteeDependentCitizenshipNumber-'+renteeDependentCount+'" name="renteeDependentCitizenshipNumber" type="text" class="form-control renteeDependentCitizenshipNumber" value="">'
		html += '<div class="errorFeedback" id="renteeDependentCitizenshipNumber-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
	
		html += '<div class="row">'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="renteeDependentRelationship" class="col-form-label">Relationship<span class="requiredField">*</span></label>'
		html += '<select class="form-control renteeDependentRelationship" id="renteeDependentRelationship-'+renteeDependentCount+'" name="renteeDependentRelationship">'
		html += '<option value="spouse" >Spauce</option>'
		html += '<option value="child" >Child</option>'
		html += '<option value="siblings" >Siblings</option>'
		html += '<option value="friend" >Friend</option>'
		html += '<option value="others" >others</option>'	
		html += '</select>'
		html += '<div class="errorFeedback" id="renteeDependentRelationship-'+renteeDependentCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
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