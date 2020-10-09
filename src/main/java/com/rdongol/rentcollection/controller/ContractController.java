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
import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.Transaction;
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
	private AbstractDataTableBackend contractListDataTableBackend;

	@PostMapping
	public ResponseEntity<Contract> create(@RequestBody ContractModel contractModel) {
		Contract contract = contractService.save(contractModel);

		if (contract == null) {
			return ResponseEntity.badRequest().build();

		}
		contractLogService.save(contract);
		return ResponseEntity.ok(contract);
	}

	@PostMapping("/listContracts")
	public String listContracts(@RequestBody String dataTableRequest) throws Exception {
		contractListDataTableBackend.intialize(dataTableRequest);
		return contractListDataTableBackend.getTableData();
	}

	@GetMapping("/billContractService/{id}")
	public ResponseEntity<List<BillContractServiceModel>> getBillContractService(@PathVariable Long id) {

		List<BillContractServiceModel> billContractServiceModels = contractService.getBillContractServiceModels(id);
		if (billContractServiceModels == null) {
			return ResponseEntity.badRequest().build();
		}

		return ResponseEntity.ok(contractService.getBillContractServiceModels(id));

	}

	@PostMapping("/expiredContracts")
	public String listExpiredConracts(@RequestBody String dataTableRequest) throws Exception {
		contractListDataTableBackend.intialize(dataTableRequest);
		return contractListDataTableBackend.getTableData();
	}

	@GetMapping("/getRentingFromContract/{id}")
	public ResponseEntity<Renting> getRentingFromContract(@PathVariable Long id) {
		Contract contract = contractService.findById(id);

		if (contract == null) {
			return ResponseEntity.badRequest().build();
		}

		return ResponseEntity.ok(contract.getRenting());
	}

	@GetMapping("/areAllBillsCleared/{id}")
	public boolean areAllBillsCleared(@PathVariable long id) {

		return contractService.areAllBillsCleared(id);
	}

	@PostMapping("/terminateContract")
	public void terminateContract(@RequestBody String id) {
		contractService.terminateContract(Long.valueOf(id));
	}

	@PostMapping("/payAndTerminateContract")
	public void payAndTerminateContract(@RequestBody Transaction transaction) {
		contractService.payAndTerminatecontract(transaction);
	}

	@GetMapping("/countExpiredContracts")
	public int countExpiredContracts() {
		return contractService.countExpiredContracts();
	}
}
