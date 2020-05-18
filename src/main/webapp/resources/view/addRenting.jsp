<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Add Renting</title>
	<link href="<c:url value="/resources/css/fileDrop.css" />" rel="stylesheet">
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
                        	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        		<div class="card">
                        			<div class="card-header">
								 		<div class="row">
								 			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							                    <h2 class="pageheader-title" id="pageheader-title">
							 						Add Renting
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the renting</p>
								 			</div>
								 		</div>
								 	</div>
								 	
							 		<form id="userForm">
									 	<div class="card-body">
								 			<div class="row">
								 				<input id="id" name="id" type="hidden">
								 				
								 				<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
	                                                <label for="name" class="col-form-label">Name<span class="requiredField">*</span></label>
	                                                <input id="name" name="name" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="name-errorFeedback"></div>
	                                            </div>
	                                            
							 				    <div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
                                            
		                                            <label for="type" class="col-form-label">Type</label>
													<select class="form-control" id="type" name="type">
														<option value="flat" >Flat</option>
														<option value="room" >Room</option>
													</select>
		
													<div class="errorFeedback" id="type-errorFeedback">
													</div>
												</div>	
	                                            
	                                           <div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
	                                                <label for="numberOfRooms" class="col-form-label">Number of Rooms</label>
	                                                <input id="numberOfRooms" name="numberOfRooms" type="number" class="form-control" value=''>
													<div class="errorFeedback" id="numberOfRooms-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
	                                                <label for="price" class="col-form-label">Price<span class="requiredField">*</span></label>
	                                                <input id="price" name="price" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="price-errorFeedback"></div>
	                                            </div>
    
								 			</div>
									 	</div>
									 	
									 	<div class="card-body border-top" id="rentingFacilities">
									 		<div class="row">
                                    	    	<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col4">
                                    	    		Renting Facilities
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-5 col-lg-5 col-md-6 col-sm-12 col5">
                                    	    		<div class="errorFeedback" id="rentingFacilities-errorFeedback">
													</div>
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">
										
											        <Button class="btn btn-success topAddButton" id="addRentingFacility" >
												    	<i class="fas fa-plus"></i>  &nbsp; Add Renting Facility
													</Button>
													
												</div>
											</div>
									 	</div>
									 	
									 	<div class="card-body border-top" id="imageFiles">
									 		<div class="row">
									 			<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col3">
                                    	    		Upload Renting Image
                                    	    	</div>
                                    	    	<div class="col-xl-8 col-lg-8 col-md-6 col-sm-12 col8 errorFeedback" id="images-errorFeedback">
                                    	    	</div>
									 		</div>
									 		
									 		<div class="row">
                                    	    	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
													<div class="dropzone-wrapper">
														<div class="dropzone-desc">
															 <i class="fas fa-download"></i>
															<p>Choose an image file or drag it here.</p>
														</div>
														<input type="file" name="rentingImage" id="rentingImage" class="dropzone" multiple>
													</div>
										 		</div>
									 		</div>
									 		
									 		<div id="displayImages" >
									 			
									 		</div>
									 	</div>
									 	
									 	<div class="card-body border-top" >
									 		<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">
													<button class="btn btn-primary" id="addRenting">
								 						Add Renting
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

<script src="<c:url value="/resources/js/alertify.js" />" ></script>

<script>
	
	var serviceModels;
	var rentingFacilityCount = 0 ;
	var errorFields= [];
	var mode ="save"
	var files =[];
	var id = 0;
	var imageCounts = 0;
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
		
	jQuery(document).ready(function(){
		
		initializeAlertifyTheme();
		
		id=getURLParameter("id");
		
		getSevices();
		
		if(id != undefined){
			mode="edit"
			jQuery("#addRenting").html("Edit Renting")
			jQuery("#pageheader-title").html("Edit Renting")
			getRenting(id)
		}else{
			mode ="save";
			jQuery("#addRenting").html("Add Renting")
			jQuery("#pageheader-title").html("Add Renting")
		}
		
		jQuery("#addRentingFacility").on("click",function(){
			event.preventDefault();
			jQuery("#rentingFacilities").append(getRentingFacilityHTML())
		})
		
		jQuery("#rentingFacilities").on("click",".RemoveRentingFacility" ,function(){
			
			var count = jQuery(this).attr("count");
			jQuery("#rentingFacility-"+count).remove();
			
		})
		
		$('.dropzone-wrapper').on('dragover', function(e) {
			e.preventDefault();
			e.stopPropagation();
			$(this).addClass('dragover');
		});
		
		$('.dropzone-wrapper').on('dragleave', function(e) {
			e.preventDefault();
			e.stopPropagation();
			$(this).removeClass('dragover');
		});
		
		$(".dropzone").change(function() {
			readFile(this)
			$('.dropzone-wrapper').removeClass('dragover');
				
		});
		
		jQuery("#displayImages").on("click",".removeImage", function(){
			var index = jQuery(this).attr("index");
			jQuery("#rentImageRow-"+index).remove();
		})
		
		jQuery("#addRenting").on("click",function(){
			event.preventDefault();
			removeErrorHighlights()
			if(validateInputs()){
				if(mode =="save"){
					saveRenting();
				}else{
					updateRenting(id)
				}
				
			}else{
				highlightErrorFields()
			}
		});
	})
	
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
	
	
	function getRenting(id){
		jQuery.ajax({
			method:"GET",
			url:"${contextPath}/renting/getRentingModel/"+id
		}).done(function(data){
			loadRentingData(data)
		});	
	}
	
	function loadRentingData(data){
		
		jQuery("#id").val(data.id);
		jQuery("#name").val(data.name);
		jQuery("#numberOfRooms").val(data.numberOfRooms);
		jQuery("#price").val(data.price);
		jQuery("#type option[value="+data.type+"]").attr("selected","selected");
		loadRentingFacilityData(data.rentingFacilities)
		loadImageData(data.imageBase64s)
	}
	
	function loadRentingFacilityData(rentingFacilities){
		var html="";
		for(var i=0 ; i<rentingFacilities.length ; i++){
			if(i>0){
				html += '<hr>'
			}
			html += '<div class="row rentingFacility" id="rentingFacility-'+rentingFacilityCount+'" >'
			html += '<input type="hidden" class="rentingFacilityId" id="rentingFacilityId-'+rentingFacilityCount+'" value="'+rentingFacilities[i].id+'">'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
			html += '<label for="serviceId-'+rentingFacilityCount+'" class="col-form-label">Service</label>'
			html += '<select class="form-control serviceId" id="serviceId-'+rentingFacilityCount+'" name="serviceId">'
			for(var j=0;j<serviceModels.length;j++){
				
				html += '<option value="'+serviceModels[j].id+'"';
				if(rentingFacilities[i].serviceId == serviceModels[j].id ){
					html += ' selected '; 
				}
				html +=	' >'+serviceModels[j].serviceName+'</option>'
				
			}		
			
			html += '</select>'
			html += '<div class="errorFeedback" id="serviceId-'+ rentingFacilityCount+'-errorFeedback"></div>'
			html += '</div>'
			
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
			html += '<label for="units-'+rentingFacilityCount+'" class="col-form-label">Units</label>'
			html += '<input id="units-'+rentingFacilityCount+'" name="units" type="number" class="units form-control " value="'+rentingFacilities[i].units+'">'
			html += '<div class="errorFeedback" id="units-'+rentingFacilityCount+'-errorFeedback"></div>'
			html += '</div>'
			
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
			html += '<i class="actionButton RemoveRentingFacility fas fa-trash-alt" style = "color:red" id="RemoveRentingFacility-'+rentingFacilityCount+'" count ="'+rentingFacilityCount+'"></i>'
			html += '</div>'
			html +='</div>'
			
			rentingFacilityCount++
		}
		
		jQuery("#rentingFacilities").append(html);
	}
	
	function loadImageData(base64s){
		var html="";
		for(var i = 0 ; i< base64s.length ; i++){
			html += '<div class="row rentImageRow" id="rentImageRow-'+imageCounts+'">'
			html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2"></div>'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<img src="data:image/png;base64,'+base64s[i]+'" class="img-thumbnail rentImage" alt="Renting image" id="rentImage-'+imageCounts+'">'
			html += '</div>'
			html += '<div class="form-group col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1 align-middle">'
			html += '<i class="actionButton removeImage  fas fa-trash-alt fa-lg" style = "color:red" id="removeImage-'+imageCounts+'" index ="'+imageCounts+'"></i>'
			html += '</div>'
			html += '</div>'
			
			imageCounts++;
		}
		jQuery("#displayImages").append(html)
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
		validateNumberOfRooms();
		
		if(mode =="save"){
			doesRentingeNameExists()
		}
		
		validateRentingFacilities();
		
		validateServiceName();
		
		validateImages();
		return !errorFields.length > 0;
		
	}
	
	function doesRentingeNameExists(){
		var name=jQuery("#name").val()

		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/renting/rentingExists/"+name,
			async: false,
			success:function(data){
				if(data == "true"){
					var errorField = {};
					errorField.id = "name"
					errorField.message = "Renting Name already exists";
					errorFields.push(errorField)
				}
			}
		});
	}
	function validateImages(){
		if(jQuery(".rentImageRow").length == 0){
			var errorField = {};
			errorField.id = "images"
			errorField.message = "Please add Images for renting";
			errorFields.push(errorField)
		}
	}
	function validateServiceName(){
		if(jQuery(".rentingFacility").length > 0){
			for(var i = 0 ; i < jQuery(".serviceId").length; i++){

			    for(var j= 0 ; j<jQuery(".serviceId").length ; j++){
			        
			        if(jQuery(jQuery(".serviceId")[i]).val()==jQuery(jQuery(".serviceId")[j]).val() && i!=j){
			        	var errorField = {};
						errorField.id = jQuery(jQuery(".serviceId")[j]).attr("id")
						errorField.message = "Cannot add same facility twice";
						errorFields.push(errorField)
			        }
			    }
			}
		}
	}
	
	function validateRentingFacilities(){
		
		if(jQuery(".rentingFacility").length == 0){
			var errorField = {};
			errorField.id = "rentingFacilities"
			errorField.message = "Please add renting facilities";
			errorFields.push(errorField)
		}

	}
	
	function validateNumberOfRooms(){
		
		var type=jQuery("#type").val();
		var charge = jQuery("#numberOfRooms").val();
		
		if("flat"== type && (charge.trim()=="")){
			var errorField = {};
			errorField.id = "numberOfRooms"
			errorField.message = "Number of rooms should be filled for 'Flat type' rentings";
			errorFields.push(errorField)
			
		}
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

	
	function readFile(input){
		var errorFiles = [];
		for(var i = 0 ; i< input.files.length ; i++){
			if(input.files[i].type == "image/jpeg" || input.files[i].type == "image/png"){
				files.push(input.files[i])
				getBase64(input.files[i],function(e){
					jQuery("#displayImages").append(getImagesHTML(e.target.result))
				})
			}else{
				errorFiles.push(input.files[i].name)
			}
		} 
		
		if(errorFiles.length >0){
			
			alertify.alert("<div style='color:red'>"+errorFiles + " are invalid files. Only upload .png or .jpg files</div>").setHeader("<b>Error Files</b>");
		
		}
		jQuery("#rentingImage").val("");
	}
	
	function getBase64(file, onLoadCallback) {
		
	    var reader = new FileReader();
	    reader.readAsDataURL(file);
	    reader.onload = onLoadCallback;
	    reader.onerror = function(error) {
	        console.log('Error when converting PDF file to base64: ', error);
	    };
	}
	
	function getImagesHTML(base64){
		var html="";
		html += '<div class="row rentImageRow" id="rentImageRow-'+imageCounts+'">'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2"></div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<img src="'+base64+'" class="img-thumbnail rentImage" alt="Renting image" id="rentImage-'+imageCounts+'">'
		html += '</div>'
		html += '<div class="form-group col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1 align-middle">'
		html += '<i class="actionButton removeImage  fas fa-trash-alt fa-lg" style = "color:red" id="removeImage-'+imageCounts+'" index ="'+imageCounts+'"></i>'
		html += '</div>'
		html += '</div>'
		
		imageCounts++;
		return html;
	}
	
	
	function getRentingFacilityHTML(){
		var html="";
		if(rentingFacilityCount>0){
			html += '<hr>'
		}
		html += '<div class="row rentingFacility" id="rentingFacility-'+rentingFacilityCount+'">'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<input type="hidden" class="rentingFacilityId" id="rentingFacilityId-"'+rentingFacilityCount+'">'
		html += '<label for="serviceId-'+rentingFacilityCount+'" class="col-form-label">Service</label>'
		html += '<select class="form-control serviceId" id="serviceId-'+rentingFacilityCount+'" name="serviceId">'
		for(var i=0;i<serviceModels.length;i++){
			
			html += '<option value="'+serviceModels[i].id+'" >'+serviceModels[i].serviceName+'</option>'
			
		}		
		
		html += '</select>'
		html += '<div class="errorFeedback" id="serviceId-'+ rentingFacilityCount+'-errorFeedback"></div>'
		html += '</div>'
		
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<label for="units-'+rentingFacilityCount+'" class="col-form-label">Units</label>'
		html += '<input id="units-'+rentingFacilityCount+'" name="units" type="number" class="units form-control " value="">'
		html += '<div class="errorFeedback" id="units-'+rentingFacilityCount+'-errorFeedback"></div>'
		html += '</div>'
		
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-6 col-sm-12 col3">'
		html += '<i class="actionButton RemoveRentingFacility fas fa-trash-alt" style = "color:red" id="RemoveRentingFacility-'+rentingFacilityCount+'" count ="'+rentingFacilityCount+'"></i>'
		html += '</div>'
		html +='</div>'
		
		rentingFacilityCount++
		
		return html;
	}
	
	function getSevices(){
		
		jQuery.ajax({
			method : "GET",
			url:"${contextPath}/service/getServiceModels"
		}).done(function(data){
			serviceModels = data;
		})	
			
	}

	
	function saveRenting(){
		
		var renting = getRentingData(mode)
	
		jQuery.ajax({
			
			method : "POST",
			url : "${contextPath}/renting",
			contentType: 'application/json; charset=UTF-8',		
			data : renting
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listRentings.jsp";
		});
	}
	
	function updateRenting(id){
		var renting = getRentingData(mode)
		
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/renting/"+id,
			contentType: 'application/json; charset=UTF-8',		
			data : renting
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listRentings.jsp";
		});
	}
	
	function getRentingData(mode){
		
		var rentingData= new Object();
		if(mode=="edit"){
			rentingData.id=jQuery("#id").val();
		}
		rentingData.name=jQuery("#name").val();
		rentingData.type=jQuery("#type").val();
		rentingData.numberOfRooms=jQuery("#numberOfRooms").val();
		rentingData.price=jQuery("#price").val();
		rentingData.rentingFacilities = getRentingFacilitiesData(mode);
		rentingData.imageBase64s = getImageData(mode)
		return JSON.stringify(rentingData);
	}
	
	function getImageData(mode){
		var images = []
		
		jQuery(".rentImageRow").each(function(){
			images.push($(this).find('.rentImage').attr("src"))
			
		})
		
		return images;
	}
	
	function getRentingFacilitiesData(mode){
		var rentingFacilities = []
		
		jQuery(".rentingFacility").each(function(){
			var rentingFacility = new Object();
			if(mode=="edit"){
				rentingFacility.id=$(this).find('.rentingFacilityId').val();
			}
			rentingFacility.serviceId = $(this).find('.serviceId').val();
			rentingFacility.units = $(this).find('.units').val();
			rentingFacilities.push(rentingFacility)
		})

		return rentingFacilities;
	}
	
</script>

<Style>
	.RemoveRentingFacility{
		padding-top : 40px;
	}
	
	.removeImage{
		padding-top: 50%;
	}
	
	.rentImageRow{
		padding-top:10px;
	}
</Style>

</html>

