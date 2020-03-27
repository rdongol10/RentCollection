package com.rdongol.rentcollection.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.Service;
import com.rdongol.rentcollection.model.ServiceDetail;

public interface ServiceDetailRepository extends CrudRepository<ServiceDetail, Long> {

	@Query(value="select s from ServiceDetail s where s.service= :service")
	List<ServiceDetail> getServiceDetailByServiceId(Service service);
}
