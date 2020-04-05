package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Rentee;

public interface RenteeRepository extends CrudRepository<Rentee, Long> {

}
