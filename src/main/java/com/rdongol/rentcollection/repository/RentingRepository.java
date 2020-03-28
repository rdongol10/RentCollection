package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Renting;

public interface RentingRepository extends CrudRepository<Renting, Long> {

}
