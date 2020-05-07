package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.rdongol.rentcollection.model.Transaction;
import com.rdongol.rentcollection.repository.TransactionRepository;

public class TransactionService {

	@Autowired
	private TransactionRepository transactionRepository;

	public List<Transaction> findAll() {
		return (List<Transaction>) transactionRepository.findAll();
	}

	public Transaction findById(Long id) {

		Optional<Transaction> transaction = transactionRepository.findById(id);

		if (!transaction.isPresent()) {
			return null;
		}

		return transaction.get();

	}

	public Transaction save(Transaction transaction) {
		return transactionRepository.save(transaction);
	}

	public void deleteById(Long id) {
		transactionRepository.deleteById(id);
	}

}
