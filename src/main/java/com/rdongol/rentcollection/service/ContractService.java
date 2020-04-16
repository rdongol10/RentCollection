package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.repository.ContractRepository;

@Service
public class ContractService {

	@Autowired
	private ContractRepository contractRepository;

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

	public void deleteById(Long id) {
		contractRepository.deleteById(id);
	}

}
