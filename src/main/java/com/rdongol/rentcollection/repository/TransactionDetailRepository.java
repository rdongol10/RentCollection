package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.TransactionDetail;

public interface TransactionDetailRepository extends CrudRepository<TransactionDetail, Long> {

}
