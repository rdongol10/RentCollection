package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.ContractLog;

public interface ContractLogRepository extends CrudRepository<ContractLog, Long> {
	
	@Query(value = "select c from ContractLog c where c.contractId = :contractId ")
	List<ContractLog> getContractLogByContractId(long contractId);
}
