<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Add Renting</title>
	<link href="<c:url value="/resources/css/fileDrop.css" />" rel="stylesheet">
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
								 				
								 				<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="name" class="col-form-label">Name<span class="requiredField">*</span></label>
	                                                <input id="name" name="name" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="name-errorFeedback"></div>
	                                            </div>
	                                            
							 				    <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
                                            
		                                            <label for="type" class="col-form-label">Type</label>
													<select class="form-control" id="type" name="type">
														<option value="flat" >Flat</option>
														<option value="room" >Room</option>
													</select>
		
													<div class="errorFeedback" id="type-errorFeedback">
													</div>
												</div>	
	                                            
	                                           <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="numberOfRooms" class="col-form-label">Number of Rooms</label>
	                                                <input id="numberOfRooms" name="numberOfRooms" type="number" class="form-control" value=''>
													<div class="errorFeedback" id="numberOfRooms-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="price" class="col-form-label">Price<span class="requiredField">*</span></label>
	                                                <input id="price" name="price" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="price-errorFeedback"></div>
	                                            </div>
    
								 			</div>
									 	</div>
									 	
									 	<div class="card-body border-top" id="rentingFacilities">
									 		<div class="row">
                                    	    	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
                                    	    		Renting Facilities
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
                                    	    		<div class="errorFeedback" id="rentingFacilities-errorFeedback">
													</div>
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
											        <Button class="btn btn-success topAddButton" id="addRentingFacility" >
												    	<i class="fas fa-plus"></i>  &nbsp; Add Renting Facility
													</Button>
													
												</div>
											</div>
									 	</div>
									 	
									 	<div class="card-body border-top" id="imageFiles">
									 		<div class="row">
									 			<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
                                    	    		Upload Renting Image
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

<script>
	
	var serviceModels;
	var rentingFacilityCount = 0 ;
	var errorFields= [];
	var mode ="save"
	var files =[];
	var id = 0;
		
		
	jQuery(document).ready(function(){

		getSevices();
		
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
			files.splice(index,1)
			displayImages()
		})
		
		
		jQuery("#addRenting").on("click",function(){
			event.preventDefault();
			saveRenting();
		});
	})
	
	function readFile(input){
		var errorFiles = []
		if(input.files && input.files.length >0 ){
			for(var i = 0 ; i< input.files.length ; i++){
				if(input.files[i].type == "image/jpeg" || input.files[i].type == "image/png"){
					files.push(input.files[i])
				}else{
					errorFiles.push(input.files[i].name)
					//TODO alert error files
				}
			} 
		}
		
		displayImages()
		jQuery("#rentingImage").val("");
		console.log(errorFiles)
	}
	
	function displayImages(){
		jQuery("#displayImages").html(getImagesHTML())
	}
	
	function getImagesHTML(){
		var html="";
		html +="<br>"
		for(var i = 0 ; i<files.length ; i ++){
			html += '<div class="row rentImage" id="rentImage-'+i+'">'
			html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2"></div>'
			html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
			html += '<img src="'+window.URL.createObjectURL(files[i])+'" class="img-thumbnail" alt="Renting image">'
			html += '</div>'
				html += '<div class="form-group col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1">'
			html += '<i class="actionButton removeImage fas fa-trash-alt" style = "color:red" id="removeImage-'+i+'" index ="'+i+'"></i>'
			html += '</div>'

			html += '</div>'
		}
		
		return html;
	}
	
	
	function getRentingFacilityHTML(){
		var html="";
		html += '<div class="row rentingFacility" id="rentingFacility-'+rentingFacilityCount+'">'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="serviceId-'+rentingFacilityCount+'" class="col-form-label">Service</label>'
		html += '<select class="form-control serviceId" id="serviceId-'+rentingFacilityCount+'" name="serviceId">'
		for(var i=0;i<serviceModels.length;i++){
			
			html += '<option value="'+serviceModels[i].id+'" >'+serviceModels[i].serviceName+'</option>'
			
		}		
		
		html += '</select>'
		html += '<div class="errorFeedback" id="serviceId-'+ rentingFacilityCount+'errorFeedback"></div>'
		html += '</div>'
		
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="units-'+rentingFacilityCount+'" class="col-form-label">Units</label>'
		html += '<input id="units-'+rentingFacilityCount+'" name="units" type="number" class="units form-control " value="">'
		html += '<div class="errorFeedback" id="units-'+rentingFacilityCount+'-errorFeedback"></div>'
		html += '</div>'
		
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<i class="actionButton RemoveRentingFacility fas fa-trash-alt" style = "color:red" id="RemoveRentingFacility-'+rentingFacilityCount+'" count ="'+rentingFacilityCount+'"></i>'
		html += '</div>'
		html +='</div>'
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
		
		formData = new FormData();

		var renting = getRentingData(mode)
	
		for(var i = 0 ; i<files.length ; i++){
			formData.append("file",files[i])
		}
		formData.append("renting", new Blob([
			renting
		],{
			 type: "application/json"
		})) ;
		
		jQuery.ajax({
			
			method : "POST",
			url : "${contextPath}/renting",
			processData: false,
			contentType: false,
			data : formData
			
		}).done(function(data){
			window.location.href="${contextPath}/resources/view/listRentings.jsp";
		});
	}
	
	function getRentingData(mode){
		
		var rentingData= new Object();
		rentingData.name=jQuery("#name").val();
		rentingData.type=jQuery("#type").val();
		rentingData.numberOfRooms=jQuery("#numberOfRooms").val();
		rentingData.price=jQuery("#price").val();
		rentingData.rentingFacilities = getRentingFacilitiesData(mode);
		
		return JSON.stringify(rentingData);
	}
	
	function getRentingFacilitiesData(mode){
		var rentingFacilities = []
		
		jQuery(".rentingFacility").each(function(){
			var rentingFacility = new Object();
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
		padding-top: 80px;
		float : right;
	}
</Style>

</html>

