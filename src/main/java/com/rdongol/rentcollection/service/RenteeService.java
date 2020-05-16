package com.rdongol.rentcollection.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeDependent;
import com.rdongol.rentcollection.model.RenteeDependentModel;
import com.rdongol.rentcollection.model.RenteeModel;
import com.rdongol.rentcollection.model.Select2Model;
import com.rdongol.rentcollection.repository.RenteeRepository;

@Service
public class RenteeService {

	@Autowired
	private RenteeRepository renteeRepository;

	@Autowired
	private RenteeDependentService renteeDependentService;

	@Autowired
	private ImageService imageService;
	
	@PersistenceContext
	protected EntityManager entityManager;

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
	
	@SuppressWarnings("unchecked")
	public List<Select2Model> getRenteesForSelect2(String searchParam) {
		List<Select2Model> select2Models = new LinkedList<Select2Model>();

		if (searchParam == null || searchParam.trim().isEmpty()) {
			return select2Models;
		}

		String stringQuery = "Select rentee.id ,rentee.first_name, rentee.last_name, rentee.middle_name From rentee where rentee.first_name like '%"
				+ searchParam + "%' OR rentee.last_name like '%" + searchParam + "%' OR rentee.middle_name like '%"
				+ searchParam + "%'";
		Query query = entityManager.createNativeQuery(stringQuery);
		List<Object[]> rentees = query.getResultList();
		for (Object[] rentee : rentees) {
			Select2Model select2Model = new Select2Model();
			select2Model.setId(rentee[0].toString());
			String firstName = rentee[1].toString();
			String lastName = rentee[2].toString();
			String middleName = rentee[3].toString();

			select2Model.setText(firstName + " " + middleName + " " + lastName);
			select2Models.add(select2Model);
		}
		return select2Models;
	}

}
