package com.rdongol.rentcollection.controller;

import java.io.StringReader;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rdongol.rentcollection.model.BillContractServiceModel;
import com.rdongol.rentcollection.model.Transaction;
import com.rdongol.rentcollection.service.TransactionService;

@RestController
@RequestMapping("/transaction")
public class TransactionController {

	@Autowired
	TransactionService transactionService;

	@PostMapping("/calculateBill")
	public ResponseEntity<Transaction> calculateBill(@RequestBody String billData) throws Exception {
		ObjectMapper mapper = new ObjectMapper();

		JsonNode rootNode = mapper.readTree(new StringReader(billData));
		int numberOfMonths = rootNode.get("numberOfMonths").asInt();
		long contractId=rootNode.get("contractId").asLong();
		List<BillContractServiceModel> billContractServiceModels = mapper.readValue(
				rootNode.get("billContractServices").toString(), new TypeReference<List<BillContractServiceModel>>() {
				});

		return ResponseEntity.ok(transactionService.calculateBill(contractId,numberOfMonths, billContractServiceModels));

	}
}
