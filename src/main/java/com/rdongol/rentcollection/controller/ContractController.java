package com.rdongol.rentcollection.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.ContractModel;
import com.rdongol.rentcollection.service.ContractLogService;
import com.rdongol.rentcollection.service.ContractService;

@RestController
@RequestMapping("/contract")
public class ContractController {

	@Autowired
	private ContractService contractService;

	@Autowired
	private ContractLogService contractLogService;

	@PostMapping
	public ResponseEntity<Contract> create(@RequestBody ContractModel contractModel) {
		Contract contract = contractService.save(contractModel);
		contractLogService.save(contract);
		return ResponseEntity.ok(contract);
	}

}
