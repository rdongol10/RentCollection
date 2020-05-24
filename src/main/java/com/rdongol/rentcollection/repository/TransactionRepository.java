package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Transaction;

public interface TransactionRepository extends CrudRepository<Transaction, Long> {

	@Query( value = "Select t from Transaction t where t.contractId = :contractId and t.paid=0")
	List<Transaction> getUnpaidBills(long contractId);
}
