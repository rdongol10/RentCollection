package com.rdongol.rentcollection.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.ContractModel;
import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.repository.ContractRepository;

@Service
public class ContractService {

	@Autowired
	private ContractRepository contractRepository;

	@Autowired
	private RenteeService renteeService;
	
	@Autowired 
	private RentingService rentingService;
	
	
	public List<Contract> findAll() {

		return (List<Contract>) contractRepository.findAll();
	}

	public Contract findById(long id) {
		Optional<Contract> contract = contractRepository.findById(id);

		if (!contract.isPresent()) {
			return null;
		}

		return contract.get();
	}

	public Contract save(Contract contract) {
		return contractRepository.save(contract);
	}
	
	public Contract save(ContractModel contractModel) {
		Contract contract = new Contract();
		Rentee rentee = renteeService.findById(contractModel.getRenteeId());

		if (rentee == null) {
			ResponseEntity.badRequest().build();
		}

		Renting renting = rentingService.findById(contractModel.getRentingId());
		if (renting == null) {
			ResponseEntity.badRequest().build();
		}

		contract.setRentee(rentee);
		contract.setRenting(renting);
		contract.setPaymentType(contractModel.getPaymentType());
		contract.setStartDate(new Date());

		return save(contract);
	}

	public void deleteById(Long id) {
		contractRepository.deleteById(id);
	}

}
