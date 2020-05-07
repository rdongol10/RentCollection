package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.TransactionDetail;
import com.rdongol.rentcollection.repository.TransactionDetailRepository;

@Service
public class TransactionDetailService {

	@Autowired
	private TransactionDetailRepository transactionDetailRepository;
	
	public List<TransactionDetail> findAll() {
		return (List<TransactionDetail>) transactionDetailRepository.findAll();
	}

	public TransactionDetail findById(Long id) {

		Optional<TransactionDetail> transactionDetail = transactionDetailRepository.findById(id);

		if (!transactionDetail.isPresent()) {
			return null;
		}

		return transactionDetail.get();

	}

	public TransactionDetail save(TransactionDetail transactionDetail) {
		return transactionDetailRepository.save(transactionDetail);
	}

	public void deleteById(Long id) {
		transactionDetailRepository.deleteById(id);
	}
}
