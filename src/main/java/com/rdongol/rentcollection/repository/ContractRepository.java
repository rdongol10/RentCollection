package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.Renting;

public interface ContractRepository extends CrudRepository<Contract, Long> {

	@Query(value = "select c from Contract c where c.renting = :renting")
	List<Contract> getContractByRenting(Renting renting);

	@Query(value = "select c from Contract c where c.rentee = :rentee")
	List<Contract> getContractByRentee(Rentee rentee);
	
}
