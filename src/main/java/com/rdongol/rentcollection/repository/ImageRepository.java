package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Image;

public interface ImageRepository extends CrudRepository<Image, Long> {

}
