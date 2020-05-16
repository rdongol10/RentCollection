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

import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.RenteeModel;
import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingDisplayModal;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.model.RentingFacilityModel;
import com.rdongol.rentcollection.model.RentingModel;
import com.rdongol.rentcollection.model.Select2Model;
import com.rdongol.rentcollection.repository.RentingRepository;

@Service
public class RentingService {

	@Autowired
	private RentingRepository rentingRepository;

	@Autowired
	private ServiceService serviceService;

	@Autowired
	private RentingFacilityService rentingFacilityService;

	@Autowired
	private ImageService imageService;

	@Autowired
	private ContractService contractService;

	@PersistenceContext
	protected EntityManager entityManager;

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

	public Renting update(long id, RentingModel rentingModel) {
		if (findById(id) == null) {
			ResponseEntity.badRequest().build();
		}

		Renting currentRenting = findById(id);

		adjustRentingFacilitiesForUpdate(currentRenting, rentingModel.getRentingFacilities());

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
		renting.setStatus(currentRenting.getStatus());

		return rentingRepository.save(renting);
	}

	private void adjustRentingFacilitiesForUpdate(Renting renting, List<RentingFacilityModel> rentingFacilityModels) {
		List<RentingFacility> currentRentingFacilities = rentingFacilityService.getRentingFacilitiesByRengint(renting);

		if (currentRentingFacilities == null || currentRentingFacilities.isEmpty()) {
			return;
		}

		if (rentingFacilityModels == null || rentingFacilityModels.isEmpty()) {
			rentingFacilityService.deleteAll(currentRentingFacilities);
			return;
		}

		List<RentingFacility> rentingFacilitiesToDelete = getRentingFacilitiesToDelete(currentRentingFacilities,
				rentingFacilityModels);
		if (!rentingFacilitiesToDelete.isEmpty()) {
			rentingFacilityService.deleteAll(currentRentingFacilities);
		}

	}

	private List<RentingFacility> getRentingFacilitiesToDelete(List<RentingFacility> currentRentingFacilities,
			List<RentingFacilityModel> rentingFacilityModels) {

		List<RentingFacility> rentingFacilitiesToDelete = new LinkedList<RentingFacility>();

		for (RentingFacility curRentingFacility : currentRentingFacilities) {
			boolean delete = true;
			for (RentingFacilityModel rentingFacilityModel : rentingFacilityModels) {
				if (curRentingFacility.getId() == rentingFacilityModel.getId()) {
					delete = false;
					break;
				}
			}

			if (delete) {
				rentingFacilitiesToDelete.add(curRentingFacility);
			}
		}
		return rentingFacilitiesToDelete;
	}

	public int toggleStatus(long id) {

		if (findById(id) == null) {
			ResponseEntity.badRequest().build();
		}

		Renting renting = findById(id);

		int status = 1;
		if (renting.getStatus() == 1) {
			status = 0;
		}

		return rentingRepository.updateRentingStatus(id, status);
	}

	public boolean existsRentingByName(String name) {
		return rentingRepository.existsRentingByName(name);
	}

	public RentingModel getRentingModel(long id) {
		Renting renting = findById(id);

		if (renting == null) {
			ResponseEntity.badRequest().build();
		}

		RentingModel rentingModel = new RentingModel(renting);
		rentingModel.setRentingFacilities(rentingFacilityService.getRentingFacilityModels(renting));
		rentingModel.setImageBase64s(imageService.getImageBase64s(renting.getId(), "RENTING"));
		return rentingModel;

	}

	public List<Select2Model> getAllRentingForSelect2(String searchParam) {
		List<Renting> rentings = getRentings(searchParam, false);
		List<Select2Model> select2Models = new LinkedList<Select2Model>();

		if (searchParam == null || searchParam.trim().isEmpty()) {
			return select2Models;
		}

		for (Renting renting : rentings) {
			Select2Model select2Model = new Select2Model();
			select2Model.setId(String.valueOf(renting.getId()));
			select2Model.setText(renting.getName());
			select2Models.add(select2Model);
		}

		return select2Models;
	}

	public List<Select2Model> getAvailableRentingsForSelect2(String searchParam) {
		List<Renting> rentings = getRentings(searchParam, true);
		List<Select2Model> select2Models = new LinkedList<Select2Model>();

		if (searchParam == null || searchParam.trim().isEmpty()) {
			return select2Models;
		}

		for (Renting renting : rentings) {
			Select2Model select2Model = new Select2Model();
			select2Model.setId(String.valueOf(renting.getId()));
			select2Model.setText(renting.getName());
			select2Models.add(select2Model);
		}

		return select2Models;
	}

	@SuppressWarnings("unchecked")
	public List<Renting> getRentings(String searchParam, boolean available) {
		StringBuilder stringQuery = new StringBuilder();
		stringQuery.append(
				" Select renting.id,renting.name,renting.type,renting.number_of_rooms,renting.price,renting.status From renting LEFT JOIN contract ON renting.id = contract.renting_id ");
		if (available) {
			stringQuery.append(" WHERE (contract.id is null ");
			stringQuery.append(" AND renting.status = 1 )");
		}
		stringQuery.append(" And renting.name like '%" + searchParam + "%' ");
		stringQuery.append(" GROUP BY renting.id ");

		Query query = entityManager.createNativeQuery(stringQuery.toString());
		List<Object[]> rentingObjects = query.getResultList();

		List<Renting> rentings = new LinkedList<Renting>();
		for (Object[] rentingObject : rentingObjects) {

			Renting renting = new Renting();
			renting.setId(Long.valueOf(rentingObject[0].toString()));
			renting.setName(rentingObject[1].toString());
			renting.setType(rentingObject[2].toString());
			renting.setNumberOfRooms(Integer.valueOf(rentingObject[3].toString()));
			renting.setPrice(Double.valueOf(rentingObject[4].toString()));
			renting.setStatus(Integer.valueOf(rentingObject[5].toString()));
			rentings.add(renting);

		}

		return rentings;
	}

	@SuppressWarnings("unchecked")
	public List<Renting> getAvailableRentings() {

		StringBuilder stringQuery = new StringBuilder();
		stringQuery.append(
				" Select renting.id,renting.name,renting.type,renting.number_of_rooms,renting.price,renting.status From renting LEFT JOIN contract ON renting.id = contract.renting_id ");
		stringQuery.append(" WHERE (contract.id is null AND renting.status = 1 )");
		stringQuery.append(" GROUP BY renting.id ");
		Query query = entityManager.createNativeQuery(stringQuery.toString());
		List<Object[]> rentingObjects = query.getResultList();

		List<Renting> rentings = new LinkedList<Renting>();
		for (Object[] rentingObject : rentingObjects) {

			Renting renting = new Renting();
			renting.setId(Long.valueOf(rentingObject[0].toString()));
			renting.setName(rentingObject[1].toString());
			renting.setType(rentingObject[2].toString());
			renting.setNumberOfRooms(Integer.valueOf(rentingObject[3].toString()));
			renting.setPrice(Double.valueOf(rentingObject[4].toString()));
			renting.setStatus(Integer.valueOf(rentingObject[5].toString()));
			rentings.add(renting);

		}

		return rentings;
	}

	public RentingDisplayModal getRentingDetails(long rentingId) {
		RentingDisplayModal rentingDisplayModal = new RentingDisplayModal();

		Renting renting = findById(rentingId);
		if (renting == null) {
			ResponseEntity.badRequest().build();
		}

		rentingDisplayModal.setImageBase64s(imageService.getImageBase64s(renting.getId(), "RENTING"));
		rentingDisplayModal.setName(renting.getName());
		rentingDisplayModal.setType(renting.getType());
		rentingDisplayModal.setNumberOfRooms(rentingDisplayModal.getNumberOfRooms());
		rentingDisplayModal.setPrice(renting.getPrice());
		rentingDisplayModal.setRentingFacilities(renting.getRentingFacility());
		rentingDisplayModal.setRenteeModel(getRenteeModelRentedTo(renting));

		return rentingDisplayModal;
	}

	public List<com.rdongol.rentcollection.model.Service> getServicesForRenting(long rentingId) {
		Renting renting = findById(rentingId);
		if (renting == null) {
			return null;
		}

		return getServicesForRenting(renting);
	}

	public List<com.rdongol.rentcollection.model.Service> getServicesForRenting(Renting renting) {

		List<com.rdongol.rentcollection.model.Service> services = new LinkedList<com.rdongol.rentcollection.model.Service>();
		List<RentingFacility> rentingFacilities = rentingFacilityService.getRentingFacilitiesByRengint(renting);
		for (RentingFacility rentingFacility : rentingFacilities) {
			services.add(rentingFacility.getService());
		}
		return services;
	}

	public Rentee getRenteeRentedTo(long rentingId) {
		Renting renting = findById(rentingId);
		if (renting == null) {
			return null;
		}

		return getRenteeRentedTo(renting);

	}

	public Rentee getRenteeRentedTo(Renting renting) {
		List<Contract> contracts = contractService.getContractByRenting(renting);
		if (contracts == null || contracts.isEmpty()) {
			return null;
		}

		Contract contract = contracts.get(0);

		Rentee rentee = contract.getRentee();

		return rentee;
	}

	public RenteeModel getRenteeModelRentedTo(long rentingId) {
		Renting renting = findById(rentingId);
		if (renting == null) {
			return null;
		}

		return getRenteeModelRentedTo(renting);
	}

	public RenteeModel getRenteeModelRentedTo(Renting renting) {
		Rentee rentee = getRenteeRentedTo(renting);
		if (rentee == null) {
			return null;
		}

		RenteeModel renteeModel = new RenteeModel(rentee);
		renteeModel.setRenteeImageBase64(imageService.getImageBase64(rentee.getId(), "RenteeProfile"));
		return renteeModel;
	}
}
