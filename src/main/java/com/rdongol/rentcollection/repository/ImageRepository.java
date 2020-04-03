package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Image;

public interface ImageRepository extends CrudRepository<Image, Long> {

	@Query(value = "Select i from Image i where i.objectType = :objectType and i.objectId = :objectid")
	List<Image> getImageByObjectTypeAndObjectId(String objectType, long objectid);
}
