package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.TransactionServiceDetail;
import com.rdongol.rentcollection.repository.TransactionServiceDetailRepository;

@Service
public class TransactionServiceDetailService {

	@Autowired
	private TransactionServiceDetailRepository transactionServiceDetailRepository;

	public List<TransactionServiceDetail> findAll() {
		return (List<TransactionServiceDetail>) transactionServiceDetailRepository.findAll();
	}

	public TransactionServiceDetail findById(Long id) {

		Optional<TransactionServiceDetail> transactionServiceDetail = transactionServiceDetailRepository.findById(id);

		if (!transactionServiceDetail.isPresent()) {
			return null;
		}

		return transactionServiceDetail.get();

	}

	public TransactionServiceDetail save(TransactionServiceDetail transactionServiceDetail) {
		return transactionServiceDetailRepository.save(transactionServiceDetail);
	}

	public void deleteById(Long id) {
		transactionServiceDetailRepository.deleteById(id);
	}
}