package com.rdongol.rentcollection.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.model.RentingFacilityModel;
import com.rdongol.rentcollection.model.RentingModel;
import com.rdongol.rentcollection.repository.RentingRepository;

@Service
public class RentingService {

	@Autowired
	private RentingRepository rentingRepository;
	
	@Autowired
	private ServiceService serviceService;

	public List<Renting> findAll() {

		return (List<Renting>) rentingRepository.findAll();
	}

	public Renting findById(Long id) {
		Optional<Renting> renting = rentingRepository.findById(id);

		if (!renting.isPresent()) {
			return null;
		}

		return renting.get();
	}

	public Renting save(Renting renting) {
		return rentingRepository.save(renting);
	}
	
	public void deleteById(Long id) {
		rentingRepository.deleteById(id);
	}

	public List<RentingFacility> getRentingFacilities(Long id) {

		if (findById(id) == null) {
			ResponseEntity.badRequest().build();
		}

		return findById(id).getRentingFacility();
	}
	
	public Renting save(RentingModel rentingModel) {

		Renting renting = new Renting(rentingModel);

		List<RentingFacility> rentingFacilities = new LinkedList<RentingFacility>();

		for (RentingFacilityModel rentingFacilityModel : rentingModel.getRentingFacilities()) {

			RentingFacility rentingFacility = new RentingFacility(rentingFacilityModel);
			long serviceId = rentingFacilityModel.getServiceId();
			com.rdongol.rentcollection.model.Service service = serviceService.findById(serviceId);

			if (service != null) {
				rentingFacility.setService(service);
			}

			rentingFacility.setRenting(renting);
			rentingFacilities.add(rentingFacility);
		}

		renting.setRentingFacility(rentingFacilities);
		renting.setStatus(1);
		return rentingRepository.save(renting);
	}
	
	public int toggleStatus(long id ) {
		
		if (findById(id) == null) {
			ResponseEntity.badRequest().build();
		}
		
		Renting renting = findById(id);
		
		int status=1;
		if(renting.getStatus() ==1) {
			status=0;
		}
		
		return rentingRepository.updateRentingStatus(id, status);
	}

}
