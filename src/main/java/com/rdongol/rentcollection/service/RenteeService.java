package com.rdongol.rentcollection.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeContractModel;
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

	public Rentee update(long id, RenteeModel renteeModel) {

		if (findById(id) == null) {

			ResponseEntity.badRequest().build();

		}

		adjustRenteeDependentsForUpdate(findById(id), renteeModel.getRenteeDependentModels());

		Rentee rentee = new Rentee(renteeModel);

		List<RenteeDependent> renteeDependents = new LinkedList<RenteeDependent>();
		for (RenteeDependentModel renteeDependentModel : renteeModel.getRenteeDependentModels()) {

			RenteeDependent renteeDependent = renteeDependentService.save(new RenteeDependent(renteeDependentModel));

			imageService.update(renteeDependent.getId(), "RenteeDependentProfile",
					renteeDependentModel.getRenteeDependentImageBase64());

			renteeDependent.setRentee(rentee);
			renteeDependents.add(renteeDependent);

		}
		rentee.setRenteeDependent(renteeDependents);
		imageService.update(rentee.getId(), "RenteeProfile", renteeModel.getRenteeImageBase64());
		imageService.update(rentee.getId(), "RenteeCitizenShip", renteeModel.getCitizenshipImageBase64());
		imageService.update(rentee.getId(), "RenteeCitizenShipBack", renteeModel.getCitizenshipBackImageBase64());

		return save(rentee);

	}

	private void adjustRenteeDependentsForUpdate(Rentee currentRentee,
			List<RenteeDependentModel> renteeDependentModels) {

		List<RenteeDependent> currentRenteeDepndents = renteeDependentService.getRenteeDependentByRentee(currentRentee);

		if (currentRenteeDepndents == null || currentRenteeDepndents.isEmpty()) {
			return;
		}

		if (renteeDependentModels == null || renteeDependentModels.isEmpty()) {
			renteeDependentService.deleteAll(currentRenteeDepndents);
			return;
		}

		List<RenteeDependent> renteeDependentsToDelete = getRenteeDependentsToDelete(currentRenteeDepndents,
				renteeDependentModels);
		if (!renteeDependentModels.isEmpty()) {
			renteeDependentService.deleteAll(renteeDependentsToDelete);
		}
	}

	public List<RenteeDependent> getRenteeDependentsToDelete(List<RenteeDependent> currentRenteeDepndents,
			List<RenteeDependentModel> renteeDependentModels) {

		List<RenteeDependent> renteeDependentsToDelete = new LinkedList<RenteeDependent>();

		for (RenteeDependent currentRenteeDependent : currentRenteeDepndents) {
			boolean delete = true;
			for (RenteeDependentModel renteeDependentModel : renteeDependentModels) {
				if (currentRenteeDependent.getId() == renteeDependentModel.getId()) {
					delete = false;
					break;
				}
			}

			if (delete) {
				renteeDependentsToDelete.add(currentRenteeDependent);
			}
		}
		return renteeDependentsToDelete;

	}

	public void deleteById(Long id) {
		renteeRepository.deleteById(id);
	}

	public RenteeModel getRenteeModel(long id) {
		Rentee rentee = findById(id);

		if (rentee == null) {
			ResponseEntity.badRequest().build();
		}

		RenteeModel renteeModel = new RenteeModel(rentee);

		renteeModel.setRenteeImageBase64(imageService.getImageBase64(rentee.getId(), "RenteeProfile"));
		renteeModel.setCitizenshipImageBase64(imageService.getImageBase64(rentee.getId(), "RenteeCitizenShip"));
		renteeModel.setCitizenshipBackImageBase64(imageService.getImageBase64(rentee.getId(), "RenteeCitizenShipBack"));
		renteeModel.setRenteeDependentModels(renteeDependentService.getRenteeDependentModels(rentee));

		return renteeModel;
	}

	public List<RenteeContractModel> getRenteeContractModels() {
		List<Rentee> rentees = findAll();
		List<RenteeContractModel> renteeContractModels = new LinkedList<RenteeContractModel>();
		for (Rentee rentee : rentees) {
			RenteeContractModel renteeContractModel = new RenteeContractModel(rentee.getId(),
					rentee.getFirstName() + " " + rentee.getMiddleName() + " " + rentee.getLastName());
			renteeContractModels.add(renteeContractModel);
		}

		return renteeContractModels;

	}

}
