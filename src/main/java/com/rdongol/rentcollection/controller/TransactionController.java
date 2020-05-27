package com.rdongol.rentcollection.controller;

import java.io.StringReader;
import java.util.Arrays;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rdongol.rentcollection.model.BillContractServiceModel;
import com.rdongol.rentcollection.model.Transaction;
import com.rdongol.rentcollection.model.TransactionDetailModel;
import com.rdongol.rentcollection.service.TransactionService;
import com.rdongol.rentcollection.service.datatable.AbstractDataTableBackend;

@RestController
@RequestMapping("/transaction")
public class TransactionController {

	@Autowired
	TransactionService transactionService;

	@Autowired
	@Qualifier("transactionListDataTableBackend")
	private AbstractDataTableBackend transactionListDataTableBackend;

	@PostMapping("/calculateBill")
	public ResponseEntity<TransactionDetailModel> calculateBill(@RequestBody String billData) throws Exception {
		ObjectMapper mapper = new ObjectMapper();

		JsonNode rootNode = mapper.readTree(new StringReader(billData));
		int numberOfMonths = rootNode.get("numberOfMonths").asInt();
		long contractId = rootNode.get("contractId").asLong();
		List<BillContractServiceModel> billContractServiceModels = mapper.readValue(
				rootNode.get("billContractServices").toString(), new TypeReference<List<BillContractServiceModel>>() {
				});

		return ResponseEntity
				.ok(transactionService.getTransactionDetail(contractId, numberOfMonths, billContractServiceModels));

	}

	@PostMapping("/calculateForTermination")
	public ResponseEntity<TransactionDetailModel> calculateForTermination(@RequestBody String billData)
			throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(new StringReader(billData));
		long contractId = rootNode.get("contractId").asLong();
		List<BillContractServiceModel> billContractServiceModels = mapper.readValue(
				rootNode.get("billContractServices").toString(), new TypeReference<List<BillContractServiceModel>>() {
				});
		return ResponseEntity.ok(transactionService.calculateForTermination(contractId, billContractServiceModels));
	}

	@PostMapping("/billInvoice")
	public ResponseEntity<Transaction> billTransaction(@RequestBody Transaction transaction) {
		return ResponseEntity.ok(transactionService.billTransaction(transaction));
	}

	@PostMapping("/payInvoice")
	public ResponseEntity<Transaction> payTransaction(@RequestBody Transaction transaction) {
		return ResponseEntity.ok(transactionService.payTransaction(transaction, true));
	}

	
	@PutMapping("/payInvoice/{id}")
	public ResponseEntity<Transaction> payTransaction(@PathVariable long id) {

		return ResponseEntity.ok(transactionService.payTransaction(id, false));

	}

	@PutMapping("/payInvoices")
	public ResponseEntity<List<Transaction>> payTransactions(@RequestBody String ids) {

		List<String> transactionIds = Arrays.asList(ids.split(","));
		return ResponseEntity.ok(transactionService.payTransactions(transactionIds, false));

	}

	@PostMapping("/listTransactions")
	public String listTransactions(@RequestBody String dataTableRequest) throws Exception {
		transactionListDataTableBackend.intialize(dataTableRequest);
		return transactionListDataTableBackend.getTableData();
	}

	@GetMapping("/getTransactionDetail/{id}")
	public ResponseEntity<TransactionDetailModel> getTransactionDetail(@PathVariable long id) {
		return ResponseEntity.ok(transactionService.getTransactionDetail(id));
	}
	
	@GetMapping("/countUnpaidBills")
	public int countUnpaidBills() {
		return transactionService.countUnpaidBills();
	}

}
