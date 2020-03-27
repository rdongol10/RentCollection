package com.rdongol.rentcollection.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.rdongol.rentcollection.model.Service;

@Transactional
public interface ServiceRepository extends CrudRepository<Service, Long> {

	boolean existsServiceByName(String name);

	@Modifying
	@Query(value ="Update Service set active=:active where id=:id")
	int updateServiceActiveStatus(Long id , int active);
	
}
