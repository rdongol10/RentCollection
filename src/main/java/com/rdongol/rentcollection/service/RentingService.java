package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.repository.RentingRepository;

@Service
public class RentingService {

	@Autowired
	private RentingRepository rentingRepository;

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

}
