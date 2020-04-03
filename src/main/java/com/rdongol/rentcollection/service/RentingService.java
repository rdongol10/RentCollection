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

	@Autowired
	private RentingFacilityService rentingFacilityService;

	@Autowired
	private ImageService imageService;

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
	
	private void adjustRentingFacilitiesForUpdate(Renting renting , List<RentingFacilityModel> rentingFacilityModels) {
		List<RentingFacility> currentRentingFacilities = rentingFacilityService.getRentingFacilitiesByRengint(renting);
		
		if(currentRentingFacilities == null || currentRentingFacilities.isEmpty() ) {
			return;
		}
		
		if(rentingFacilityModels == null || rentingFacilityModels.isEmpty()) {
			rentingFacilityService.deleteAll(currentRentingFacilities);
		}
		
		List<RentingFacility> rentingFacilitiesToDelete = getRentingFacilitiesToDelete(currentRentingFacilities , rentingFacilityModels);
		if(!rentingFacilitiesToDelete.isEmpty()) {
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
	
	
	

}
