package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.model.Service;

public interface RentingFacilityRepository extends CrudRepository<RentingFacility, Long> {

	@Query(value = "select s from RentingFacility s where s.service = :service")
	List<RentingFacility> getRentingFacilityByService(Service service);

	@Query(value = "select s from RentingFacility s where s.renting = :renting")
	List<RentingFacility> getRentingFacilityByRenting(Renting renting);

}