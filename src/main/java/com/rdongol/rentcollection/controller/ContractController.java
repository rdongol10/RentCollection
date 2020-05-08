package com.rdongol.rentcollection.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.BillContractServiceModel;
import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.ContractModel;
import com.rdongol.rentcollection.service.ContractLogService;
import com.rdongol.rentcollection.service.ContractService;
import com.rdongol.rentcollection.service.datatable.AbstractDataTableBackend;

@RestController
@RequestMapping("/contract")
public class ContractController {

	@Autowired
	private ContractService contractService;

	@Autowired
	private ContractLogService contractLogService;

	@Autowired
	@Qualifier("contractListDataTableBackend")
	private AbstractDataTableBackend rentingListDataTableBackend;

	@PostMapping
	public ResponseEntity<Contract> create(@RequestBody ContractModel contractModel) {
		Contract contract = contractService.save(contractModel);
		contractLogService.save(contract);
		return ResponseEntity.ok(contract);
	}

	@PostMapping("/listContracts")
	public String listContracts(@RequestBody String dataTableRequest) throws Exception {
		rentingListDataTableBackend.intialize(dataTableRequest);
		return rentingListDataTableBackend.getTableData();
	}

	@GetMapping("/billContractService/{id}")
	public ResponseEntity<List<BillContractServiceModel>> getBillContractService(@PathVariable Long id) {

		return ResponseEntity.ok(contractService.getBillContractServiceModels(id));

	}

}
