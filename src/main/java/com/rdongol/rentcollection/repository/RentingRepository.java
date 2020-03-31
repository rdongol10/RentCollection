package com.rdongol.rentcollection.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.rdongol.rentcollection.model.Renting;

@Transactional
public interface RentingRepository extends CrudRepository<Renting, Long> {

	@Modifying
	@Query(value= "Update Renting set status=:status where id=:id")
	int updateRentingStatus(long id , int status);
}
