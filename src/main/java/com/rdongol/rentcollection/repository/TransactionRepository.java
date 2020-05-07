package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Transaction;

public interface TransactionRepository extends CrudRepository<Transaction, Long> {

}
