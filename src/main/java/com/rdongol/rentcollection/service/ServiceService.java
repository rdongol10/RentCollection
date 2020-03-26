package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.ServiceDetail;
import com.rdongol.rentcollection.repository.ServiceRepository;

@Service
public class ServiceService {

	@Autowired
	private ServiceRepository serviceRepository;

	public List<com.rdongol.rentcollection.model.Service> findAll() {
		return (List<com.rdongol.rentcollection.model.Service>) serviceRepository.findAll();
	}

	public com.rdongol.rentcollection.model.Service findById(Long id) {

		Optional<com.rdongol.rentcollection.model.Service> service = serviceRepository.findById(id);

		if (!service.isPresent()) {
			return null;
		}
		return service.get();
	}

	public com.rdongol.rentcollection.model.Service save(com.rdongol.rentcollection.model.Service service) {

		List<ServiceDetail> serviceDetails = service.getServiceDetail();

		if (serviceDetails != null) {
			for (ServiceDetail detail : serviceDetails) {
				detail.setService(service);
			}
		}

		service.setActive(1);
		return serviceRepository.save(service);

	}

	public void deleteById(Long id) {
		serviceRepository.deleteById(id);
	}
	
	public boolean existServiceByName(String name) {
		return serviceRepository.existsServiceByName(name);
	}

}
