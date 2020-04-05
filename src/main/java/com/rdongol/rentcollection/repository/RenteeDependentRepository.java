package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeDependent;

public interface RenteeDependentRepository extends CrudRepository<RenteeDependent, Long> {

	@Query(value = "select r from RenteeDependent r where r.rentee = :rentee")
	List<RenteeDependent> getRenteeDependentByRentee(Rentee rentee);
}
