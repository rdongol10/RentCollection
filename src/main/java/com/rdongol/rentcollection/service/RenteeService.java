package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.repository.RenteeRepository;

@Service
public class RenteeService {

	@Autowired
	private RenteeRepository renteeRepository;

	public List<Rentee> findAll() {

		return (List<Rentee>) renteeRepository.findAll();
	}

	public Rentee findById(long id) {
		Optional<Rentee> rentee = renteeRepository.findById(id);

		if (!rentee.isPresent()) {
			return null;
		}

		return rentee.get();
	}

	public Rentee save(Rentee rentee) {
		return renteeRepository.save(rentee);
	}
	
	public void deleteById(Long id) {
		renteeRepository.deleteById(id);
	}
	
	
}
