package com.rdongol.rentcollection.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeDependent;
import com.rdongol.rentcollection.model.RenteeDependentModel;
import com.rdongol.rentcollection.repository.RenteeDependentRepository;

@Service
public class RenteeDependentService {

	@Autowired
	private RenteeDependentRepository renteeDependentRepository;

	@Autowired
	private ImageService imageService;

	public List<RenteeDependent> findAll() {

		return (List<RenteeDependent>) renteeDependentRepository.findAll();
	}

	public RenteeDependent findById(long id) {
		Optional<RenteeDependent> renteeDependent = renteeDependentRepository.findById(id);

		if (!renteeDependent.isPresent()) {
			return null;
		}

		return renteeDependent.get();
	}

	public RenteeDependent save(RenteeDependent renteeDependent) {
		return renteeDependentRepository.save(renteeDependent);
	}

	public void deleteById(Long id) {
		renteeDependentRepository.deleteById(id);
	}
	
	public void deleteAll(List<RenteeDependent> renteeDependents) {
		for (RenteeDependent renteeDependent : renteeDependents) {
			imageService.deleteImages(renteeDependent.getId(), "RenteeDependentProfile");
			deleteById(renteeDependent.getId());
		}
	}

	public List<RenteeDependent> getRenteeDependentByRentee(Rentee rentee) {
		return renteeDependentRepository.getRenteeDependentByRentee(rentee);
	}

	public List<RenteeDependentModel> getRenteeDependentModels(Rentee rentee) {
		List<RenteeDependent> renteeDependents = getRenteeDependentByRentee(rentee);
		List<RenteeDependentModel> renteeDependentModels = new LinkedList<RenteeDependentModel>();
		for (RenteeDependent renteeDependent : renteeDependents) {
			RenteeDependentModel renteeDependentModel = new RenteeDependentModel(renteeDependent);
			
			renteeDependentModel.setRenteeDependentImageBase64(
					imageService.getImageBase64(renteeDependent.getId(), "RenteeDependentProfile"));
		
			renteeDependentModels.add(renteeDependentModel);
		
		}
		return renteeDependentModels;
	}
}
