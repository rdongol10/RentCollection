<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Bill Contract</title>
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
	                                                <input id="months" min = "0" name="months" type="number" class="form-control" value=''>
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
			
</body>

<script type="text/javascript">
	var id=0;
	
	jQuery(document).ready(function() {
		id= getURLParameter("id");
		if(id!=undefined){
			getServices(id)
		}
	});	
	
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
		
		html += '<div class="row">'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Service Name</div>'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Charge</div>'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Last Unit</div>'
		html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">Curent Unit</div>'
		html += '</div>'
		for(var i =0 ; i<data.length ; i++){
			html += '<br>'
			html += '<div class="row">'
			html += '<input type ="hidden" value="'+data[i].rentingFacilityId+'"  id="rentingFacilityId-'+i+'" >'
			html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2"  id="serviceName-'+i+'" >'+data[i].serviceName+'</div>'
			if(data[i].serviceType == "fixed"){
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2" id="serviceCharge-'+i+'" >'+data[i].serviceCharge+'</div>'
			}else{
				
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2" id="serviceCharge-'+i+'" >-</div>'
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2" id="lastUnit-'+i+'" >'+data[i].lastUnit+'</div>'
				html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2">'
				html += '<input type="number" id="currentUnit-'+i+'" class="form-control requiredInputs" min="0" count="'+i+'">'
				html += '</div>'
				html += '<div class="errorFeedback" id="currentUnit-'+i+'-errorFeedback"></div>'

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