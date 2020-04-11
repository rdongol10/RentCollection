package com.rdongol.rentcollection.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeModel;
import com.rdongol.rentcollection.service.RenteeService;

@RestController
@RequestMapping("/rentee")
public class RenteeController {

	@Autowired
	private RenteeService renteeService;
	
	@PostMapping
	public ResponseEntity<Rentee> create(@RequestBody RenteeModel renteeModel) throws Exception{
		
		return ResponseEntity.ok(renteeService.save(renteeModel));
	}
}
