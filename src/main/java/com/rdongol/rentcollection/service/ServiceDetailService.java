package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.ServiceDetail;
import com.rdongol.rentcollection.repository.ServiceDetailRepository;

@Service
public class ServiceDetailService {

	@Autowired
	private ServiceDetailRepository serviceDetailRepository;

	public List<ServiceDetail> findAll() {
		return (List<ServiceDetail>) serviceDetailRepository.findAll();
	}

	public ServiceDetail findById(Long id) {
		Optional<ServiceDetail> serviceDetail = serviceDetailRepository.findById(id);
		if (!serviceDetail.isPresent()) {
			return null;
		}

		return serviceDetail.get();
	}

	public ServiceDetail save(ServiceDetail serviceDetail) {
		return serviceDetailRepository.save(serviceDetail);
	}

	public void deleteById(Long id) {
		serviceDetailRepository.deleteById(id);
	}

	public List<ServiceDetail> getServiceDetailByService(com.rdongol.rentcollection.model.Service service) {
		return serviceDetailRepository.getServiceDetailByServiceId(service);
	}

	public void deleteServiceDetails(List<ServiceDetail> serviceDetails) {
		serviceDetailRepository.deleteAll(serviceDetails);
	}

	public List<ServiceDetail> getServiceDetailByServiceIdOrderByVolumeCutoff(
			com.rdongol.rentcollection.model.Service service) {
		
		return serviceDetailRepository.getServiceDetailByServiceIdOrderByVolumeCutoff(service);

	}

}
