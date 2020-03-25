package com.rdongol.rentcollection.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.Service;
import com.rdongol.rentcollection.model.ServiceDetail;
import com.rdongol.rentcollection.service.ServiceService;

@RestController
@RequestMapping("/service")
public class ServiceController {
	@Autowired
	private ServiceService serviceService;
	
	@PostMapping
	public ResponseEntity<Service> create(@RequestBody Service service) {

		System.out.println(service);
		
		
		for(ServiceDetail detail : service.getServiceDetail()) {
			detail.setService(service);
		}
		
		return ResponseEntity.ok(serviceService.save(service ));

	}

}
