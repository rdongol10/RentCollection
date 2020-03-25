<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Service</title>
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
							 						Add Service
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the user</p>
								 			</div>
										</div>
								 	</div>
								 	
							 		<form id="serviceForm">
									 	<div class="card-body">
								 			<div class="row">
								 				<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="name" class="col-form-label">Name<span class="requiredField">*</span></label>
	                                                <input id="name" name="name" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="name-errorFeedback"></div>
	                                            </div>
	                                            
	                                           <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="minimumCharge" class="col-form-label">Minimum Charge</label>
	                                                <input id="minimumCharge" name="minimumCharge" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="minimumCharge-errorFeedback"></div>
	                                            </div>
	                                            
	                                            <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
	                                                <label for="charge" class="col-form-label">Charge</label>
	                                                <input id="charge" name="charge" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="charge-errorFeedback"></div>
	                                            </div>
    
                                                <div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
                                            
		                                            <label for="type" class="col-form-label">Type</label>
													<select class="form-control" id="type" name="type">
														<option value="fixed" >Fixed</option>
														<option value="unit" >Unit</option>
													</select>
		
													<div class="errorFeedback" id="sex-errorFeedback">
													</div>
												</div>									 			
								 			</div>
									 	</div>
									 	
									 	<div class="card-body border-top" id="serviceDetails">
									 		<div class="row">
                                    	    	<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-9">
                                    	    		Service Details
                                    	    	</div>
                                    	    	
                                    	    	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
											        <Button class="btn btn-success topAddButton" id="addServiceDetail" >
												    	<i class="fas fa-plus"></i>  &nbsp; Add Service Details
													</Button>
													
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
	
	var serviceDetailsCount = 0;
	jQuery(document).ready(function() {
		
		jQuery("#type").on("change",function(){
			if(jQuery(this).val() == "fixed"){
				jQuery("#serviceDetails").hide();
			}else{
				jQuery("#serviceDetails").show();
			}
		})
		
		jQuery("#addServiceDetail").on("click",function(){
			event.preventDefault();
			jQuery("#serviceDetails").append(getServiceDetail())
			
		})
	});
	
	function getServiceDetail(){
		var html="";
		
		html += '<div class="row" id="serviceDetail-"'+serviceDetailsCount+'>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="rate-"'+serviceDetailsCount+' class="col-form-label">Rate<span class="requiredField">*</span></label>'
		html += '<input id="rate-"'+serviceDetailsCount+' name="rate" type="text" class="form-control requiredInputs" value="">'
		html += '<div class="errorFeedback" id="rate-"'+serviceDetailsCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="volumeCutoff-"'+serviceDetailsCount+' class="col-form-label">Volume Cutoff</label>'
		html += '<input id="volumeCutoff-"'+serviceDetailsCount+' name="volumeCutoff" type="number" class="form-control requiredInputs" value="">'
		html += '<div class="errorFeedback" id="volumeCutoff-"'+serviceDetailsCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">'
		html += '<label for="serviceCharge-"'+serviceDetailsCount+' class="col-form-label">Service Charge</label>'
		html += '<input id="serviceCharge-"'+serviceDetailsCount+' name="serviceCharge" type="number" class="form-control requiredInputs" value="">'
		html += '<div class="errorFeedback" id="serviceCharge-"'+serviceDetailsCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '</div>'
		
		serviceDetailsCount++;
		
		return html;
	}
	
	

	
	
</script>
</html>