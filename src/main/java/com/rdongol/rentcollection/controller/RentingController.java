package com.rdongol.rentcollection.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingModel;
import com.rdongol.rentcollection.service.ImageService;
import com.rdongol.rentcollection.service.RentingService;
import com.rdongol.rentcollection.service.datatable.AbstractDataTableBackend;

@RestController
@RequestMapping("/renting")
public class RentingController {

	@Autowired
	private RentingService rentingService;
	
	@Autowired
	@Qualifier("rentingListDataTableBackend")
	private AbstractDataTableBackend rentingListDataTableBackend;
	
	@Autowired
	private ImageService imageService;
	
	@PostMapping
	public ResponseEntity<Renting> create(@RequestPart("renting") RentingModel rentingModel ,@RequestPart("file") MultipartFile[] file ) {
		
		
		Renting renting = rentingService.save(rentingModel);
		imageService.save(renting.getId(), "RENTING", file);
		return ResponseEntity.ok(renting);
		
	}
	
	@PostMapping("/listRentings")
	public String listRentings(@RequestBody String dataTableRequest) throws Exception {
		rentingListDataTableBackend.intialize(dataTableRequest);
		return rentingListDataTableBackend.getTableData();
	}
	
	@PutMapping("/toggleStatus/{id}")
	public int toggleStatus(@PathVariable long id) {
		return rentingService.toggleStatus(id);
	}
	
	@GetMapping("/rentingExists/{name}")
	public String doesRentingExists(@PathVariable String name) {
		
		if (rentingService.existsRentingByName(name)) {
			return "true";
		}

		return "false";
	}
	
}
