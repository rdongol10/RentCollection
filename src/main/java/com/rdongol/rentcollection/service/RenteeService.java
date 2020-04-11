package com.rdongol.rentcollection.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeDependent;
import com.rdongol.rentcollection.model.RenteeDependentModel;
import com.rdongol.rentcollection.model.RenteeModel;
import com.rdongol.rentcollection.repository.RenteeRepository;

@Service
public class RenteeService {

	@Autowired
	private RenteeRepository renteeRepository;
	
	@Autowired
	private RenteeDependentService renteeDependentService;
	
	@Autowired
	private ImageService imageService;
	
	

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
	
	public Rentee save(RenteeModel renteeModel) {

		Rentee rentee = save(new Rentee(renteeModel));
		
		List<RenteeDependent> renteeDependents = new LinkedList<RenteeDependent>();
		for (RenteeDependentModel renteeDependentModel : renteeModel.getRenteeDependentModels()) {
			RenteeDependent renteeDependent = renteeDependentService.save(new RenteeDependent(renteeDependentModel));

			imageService.save(renteeDependent.getId(), "RenteeDependentProfile",
					renteeDependentModel.getRenteeDependentImageBase64());


			renteeDependent.setRentee(rentee);
			renteeDependents.add(renteeDependent);

		}

		rentee.setRenteeDependent(renteeDependents);

		save(rentee);

		imageService.save(rentee.getId(), "RenteeProfile", renteeModel.getRenteeImageBase64());
		imageService.save(rentee.getId(), "RenteeCitizenShip", renteeModel.getCitizenshipImageBase64());
		imageService.save(rentee.getId(), "RenteeCitizenShipBack", renteeModel.getCitizenshipBackImageBase64());

		return rentee;
	}

	public void deleteById(Long id) {
		renteeRepository.deleteById(id);
	}
	
	
}
