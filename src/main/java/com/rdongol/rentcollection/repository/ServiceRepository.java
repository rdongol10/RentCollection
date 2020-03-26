package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Service;

public interface ServiceRepository extends CrudRepository<Service, Long> {

	boolean existsServiceByName(String name);
}
