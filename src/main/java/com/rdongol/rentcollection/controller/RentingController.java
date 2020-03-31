package com.rdongol.rentcollection.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingModel;
import com.rdongol.rentcollection.service.ImageService;
import com.rdongol.rentcollection.service.RentingService;

@RestController
@RequestMapping("/renting")
public class RentingController {

	@Autowired
	private RentingService rentingService;
	
	@Autowired
	private ImageService imageService;
	
	@PostMapping
	public ResponseEntity<Renting> create(@RequestPart("renting") RentingModel rentingModel ,@RequestPart("file") MultipartFile[] file ) {
		
		
		Renting renting = rentingService.save(rentingModel);
		imageService.save(renting.getId(), "RENTING", file);
		return ResponseEntity.ok(renting);
		
	}
	
}
