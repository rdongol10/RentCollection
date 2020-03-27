package com.rdongol.rentcollection.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.Service;
import com.rdongol.rentcollection.model.ServiceDetail;
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

	@GetMapping("/{id}")
	public ResponseEntity<Service> findById(@PathVariable Long id) {
		return ResponseEntity.ok(serviceService.findById(id));
	}

	@PostMapping("/listServices")
	public String listUsers(@RequestBody String dataTableRequest) throws Exception {

		serviceListDataTableBackend.intialize(dataTableRequest);
		return serviceListDataTableBackend.getTableData();

	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Service> update(@PathVariable Long id , @RequestBody Service service){
		
		return ResponseEntity.ok(serviceService.update(id ,service));
		
	}
	
	@PutMapping("/toggleStatus/{id}")
	public int updateStatus(@PathVariable Long id ) {
		return serviceService.toggleActiveStatus(id);
	}
	
	@GetMapping("/getServiceDetails/{id}")
	public ResponseEntity<List<ServiceDetail>> getServiceDetails(@PathVariable Long id) {
		return ResponseEntity.ok(serviceService.getServiceDetails(id));
	}

}
