package com.rdongol.rentcollection.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.Service;
import com.rdongol.rentcollection.service.ServiceService;
import com.rdongol.rentcollection.service.datatable.AbstractDataTableBackend;

@RestController
@RequestMapping("/service")
public class ServiceController {
	@Autowired
	private ServiceService serviceService;
	
	@Autowired
	@Qualifier("serviceListDataTableBackend")
	private AbstractDataTableBackend serviceListDataTableBackend;


	@PostMapping
	public ResponseEntity<Service> create(@RequestBody Service service) {

		return ResponseEntity.ok(serviceService.save(service));

	}

	@GetMapping("/serviceExists/{name}")
	public String doesServiceExists(@PathVariable String name) {
		if (serviceService.existServiceByName(name)) {
			return "true";
		}

		return "false";
	}
	
	@PostMapping("/listServices")
	public String listUsers(@RequestBody String dataTableRequest) throws Exception {

		serviceListDataTableBackend.intialize(dataTableRequest);
		return serviceListDataTableBackend.getTableData();

	}

}