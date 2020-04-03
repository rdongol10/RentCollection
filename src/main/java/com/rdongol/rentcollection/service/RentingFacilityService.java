package com.rdongol.rentcollection.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.model.RentingFacilityModel;
import com.rdongol.rentcollection.repository.RentingFacilityRepository;

@Service
public class RentingFacilityService {

	@Autowired
	private RentingFacilityRepository rentingFacilityRepository;

	public List<RentingFacility> findAll() {
		return (List<RentingFacility>) rentingFacilityRepository.findAll();
	}

	public RentingFacility findById(Long id) {
		Optional<RentingFacility> rentingFacility = rentingFacilityRepository.findById(id);

		if (!rentingFacility.isPresent()) {
			return null;
		}

		return rentingFacility.get();

	}

	public RentingFacility save(RentingFacility rentingFacility) {
		return rentingFacilityRepository.save(rentingFacility);
	}

	public void deleteById(Long id) {
		rentingFacilityRepository.deleteById(id);
	}

	public void deleteAll(List<RentingFacility> rentingFacilities) {
		rentingFacilityRepository.deleteAll(rentingFacilities);
	}

	public List<RentingFacility> getRentingFacilitiesByService(com.rdongol.rentcollection.model.Service service) {
		return rentingFacilityRepository.getRentingFacilityByService(service);
	}

	public List<RentingFacility> getRentingFacilitiesByRengint(Renting renting) {
		return rentingFacilityRepository.getRentingFacilityByRenting(renting);
	}

	public List<RentingFacilityModel> getRentingFacilityModels(Renting renting) {
		List<RentingFacility> rentingFacilities = getRentingFacilitiesByRengint(renting);

		List<RentingFacilityModel> rentingFacilityModels = new LinkedList<RentingFacilityModel>();
		for (RentingFacility rentingFacility : rentingFacilities) {
			rentingFacilityModels.add(new RentingFacilityModel(rentingFacility));
		}
		return rentingFacilityModels;
	}

}
