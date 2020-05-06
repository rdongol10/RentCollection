function getRenteeDetailsHTML(data){
	var html = '';
		
	html += '<div class="row">'
	
	html += '<div class="col-3">'
	html += '<img class="displayImage profileDisplayImage" src="data:image/png;base64,'+data.renteeImageBase64+'">'
	html += '</div>'
	
	html += '<div class="col-4">'
	html += '<label class="col-form-lable">Name : ' + data.firstName +'  ' +data.lastName +'</label><br>'
	html += '<label class="col-form-lable">DOB : ' + data.dob +'</label><br>'
	html += '<label class="col-form-lable">Sex : ' + data.sex +'</label><br>'
	html += '<label class="col-form-lable">Number : ' + data.phoneNumber +'</label><br>'
	html += '<label class="col-form-lable">Citizenship Number : ' + data.citizenshipNumber +'</label>'
	html += '</div>'
	
	html += '</div>'
	
	
	if(data.renteeDependentModels !=null && data.renteeDependentModels.length > 0){
		html += '<hr>'
		
		html += '<div class="row">'
		html += '<div class="col-3">'
		html += '<label class="col-form-lable"><h3>Dependents</h3></label>'
		html += '</div>'
		html += '</div>' 
				
		for(var i =0 ; i<data.renteeDependentModels.length ; i++){
			html += '<hr>'
			html += '<div class="row">'
				
			html += '<div class="col-3">'
			html += '<img class="displayImage profileDisplayImage" src="data:image/png;base64,'+data.renteeDependentModels[i].renteeDependentImageBase64+'">'
			html += '</div>'
			
			html += '<div class="col-4">'
			html += '<label class="col-form-lable">Name : ' + data.renteeDependentModels[i].firstName +'  ' +data.renteeDependentModels[i].lastName +'</label><br>'
			html += '<label class="col-form-lable">DOB : ' + data.renteeDependentModels[i].dob +'</label><br>'
			html += '<label class="col-form-lable">Sex : ' + data.renteeDependentModels[i].sex +'</label><br>'
			html += '<label class="col-form-lable">Number : ' + data.renteeDependentModels[i].phoneNumber +'</label><br>'
			html += '<label class="col-form-lable">Relationship : ' + data.renteeDependentModels[i].relationship +'</label>'
			html += '</div>'
			
			html += '</div>'
		}
	}
	return html
}

function getRentingDetailsHTML(data){
	var html = '';
	html += '<div id="imageCarousel" class="carousel slide" data-ride="carousel">'
	html += '<ol class="carousel-indicators">'
	for(var i=0 ; i<data.imageBase64s.length ; i++){
		html += '<li data-target="#imageCarousel" data-slide-to="0" '
		html += 'class="active"'
		html += '></li>'
	}
	html += '</ol>'
	html += '<div class="carousel-inner">'
	for(var i=0 ; i<data.imageBase64s.length ; i++){
		html += '<div class="carousel-item' 
		if(i==0){
			html += " active "
		}
		html += '">'
		html += '<img src="data:image/png;base64,'+data.imageBase64s[i]+'" class="d-block w-100" alt="...">'
		html += '</div>'
	}
	
	html += '</div>'
	html += '<a class="carousel-control-prev" href="#imageCarousel" role="button" data-slide="prev">'
	html += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>'
	html += '<span class="sr-only">Previous</span>'
	html += '</a>'
	html += '<a class="carousel-control-next" href="#imageCarousel" role="button" data-slide="next">'
	html += '<span class="carousel-control-next-icon" aria-hidden="true"></span>'
	html += '<span class="sr-only">Next</span>'
	html += '</a>'
	html += '</div>'
	html += '<br>'
	
	html += '<div class="row">'
	html += '<div class="col-3">'
	html += '<label class="col-form-lable">Name : '+ data.name+' </label>'
	html += '</div>'
	html += '<div class="col-3">'
	html += '<label class="col-form-lable">Number of Rooms : '+ data.numberOfRooms+' </label>'
	html += '</div>'
	html += '<div class="col-3">'
	html += '<label class="col-form-lable">Price : '+ data.price+' </label>'
	html += '</div>'
	html += '</div>' 
	
	if(data.rentingFacilities != null && data.rentingFacilities.length >0){
		html += '<hr>'
		html += '<div class="row">'
		html += '<div class="col-3">'
		html += '<label class="col-form-lable"><h4>Renting Facilities</h4></label>'
		html += '</div>'
		html += '</div>'
		
		html += '<div class="table-responsive">'
		html += '<table class="table table-bordered table-striped">'
		html += '<thead>'
		html += '<tr>'
		html += '<th scope="col">Name</th>'
		html += '<th scope="col">Type</th>'
		html += '<th scope="col">Charge/Minimum charge</th>'
		html += '<th scope="col">Meter reading</th>'
		html += '</tr>'
		html += '</thead>'
		
		html += '<tbody>'
		for(var i=0 ; i < data.rentingFacilities.length ; i++){
			html += '<tr>'
			
			html += '<td> ' +data.rentingFacilities[i].service.name +'</td>'
			html += '<td>' +data.rentingFacilities[i].service.type +' </td>'
			if(data.rentingFacilities[i].service.type == "unit"){
				html += '<td> ' +data.rentingFacilities[i].service.minimumCharge +' </td>'
				
				html += '<td> ' +data.rentingFacilities[i].units +' </td>'
			}else{
				html += '<td> ' +data.rentingFacilities[i].service.charge +' </td>'
				html += '<td> - </td>'
			}
			
			html += '</tr>'
			
			if(data.rentingFacilities[i].service.type == "unit"){
				var serviceDetails = data.rentingFacilities[i].service.serviceDetail;
				if(serviceDetails != null && serviceDetails.length>0 ){
					html += '<tr>'
					html += '<td colspan="4">'
					html += '<div class="table-responsive"> <h5 style="text-align: center;">Facility Detail</h5>'
					html += '<table class="table table-bordered table-striped">'
					html += '<thead>'
					html += '<tr>'
					html += '<th scope="col">Volume cutoff</th>'
					html += '<th scope="col">Rate</th>'
					html += '<th scope="col">ServiceCharge</th>'
					html += '</tr>'
					html += '</thead>'
					
					html += '<tbody>'
					for(var j= 0; j<serviceDetails.length ; j++){
						html += '<tr>'
						html += '<td> ' +serviceDetails[j].volumeCutoff +' </td>'

						html += '<td> ' +serviceDetails[j].rate +' </td>'
						html += '<td> ' +serviceDetails[j].serviceCharge +' </td>'

						html += '</tr>'
					}
					html += '</tbody>'
					html += '</table>'
					html += '</div>'
					html += '</td>'
					html += '</tr>'
				}
			}
		}
		
		
		html += '<tbody>'
		html += '</table>'
		html += '</div>'
		
	}
	
	if(data.renteeModel !=null){
		html += '<hr>'
		html += '<div class="row">'
		html += '<div class="col-3">'
		html += '<label class="col-form-lable"><h4>Rented To</h4></label>'
		html += '</div>'
		html += '</div>'
		
		html += '<div class="row">'
		
		html += '<div class="col-3">'
		html += '<img class="displayImage profileDisplayImage" src="data:image/png;base64,'+data.renteeModel.renteeImageBase64+'">'
		html += '</div>'
		html += '<div class="col-3">'
		html += '<label class="col-form-lable">Name : ' + data.renteeModel.firstName +'  ' +data.renteeModel.lastName +'</label>'
		html += '<label class="col-form-lable">DOB : ' + data.renteeModel.dob +'</label>'
		html += '<label class="col-form-lable">Sex : ' + data.renteeModel.sex +'</label>'
		html += '<label class="col-form-lable">Number : ' + data.renteeModel.phoneNumber +'</label>'
		html += '<label class="col-form-lable">Citizenship Number : ' + data.renteeModel.citizenshipNumber +'</label>'

		html += '</div>'
		
		html += '</div>'
	}
	
	
	
	return html;
}