package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Contract;

public interface ContractRepository extends CrudRepository<Contract, Long> {

}
