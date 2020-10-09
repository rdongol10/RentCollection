package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.ContractLog;
import com.rdongol.rentcollection.repository.ContractLogRepository;

@Service
public class ContractLogService {

	@Autowired
	private ContractLogRepository contractLogRepository;

	public List<ContractLog> findAll() {

		return (List<ContractLog>) contractLogRepository.findAll();
	}

	public ContractLog findById(long id) {
		Optional<ContractLog> contractLog = contractLogRepository.findById(id);

		if (!contractLog.isPresent()) {
			return null;
		}

		return contractLog.get();
	}

	public ContractLog save(ContractLog contractLog) {
		return contractLogRepository.save(contractLog);
	}

	public ContractLog save(Contract contract) {
		ContractLog contractLog = new ContractLog();
		contractLog.setContractId(contract.getId());
		contractLog.setRenteeId(contract.getRentee().getId());
		contractLog.setRentingId(contract.getRenting().getId());
		contractLog.setStartDate(contract.getStartDate());
		save(contractLog);
		return contractLog;
	}

	public void deleteById(Long id) {
		contractLogRepository.deleteById(id);
	}
	
	public ContractLog getContractLogByContractId(long contractId) {
		List<ContractLog> contractLogs = contractLogRepository.getContractLogByContractId(contractId);
		if (contractLogs != null && !contractLogs.isEmpty()) {
			return contractLogs.get(0);
		}

		return null;
	}

}
