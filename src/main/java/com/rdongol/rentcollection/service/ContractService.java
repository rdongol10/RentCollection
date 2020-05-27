package com.rdongol.rentcollection.service;

import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.BillContractServiceModel;
import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.ContractLog;
import com.rdongol.rentcollection.model.ContractModel;
import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.model.Transaction;
import com.rdongol.rentcollection.repository.ContractRepository;

@Service
public class ContractService {

	@Autowired
	private ContractRepository contractRepository;

	@Autowired
	private RenteeService renteeService;

	@Autowired
	private RentingService rentingService;

	@Autowired
	private TransactionService transactionService;

	@Autowired
	private ContractLogService contractLogService;

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
		contract.setStartDate(new Date());

		contract.setExpireDate(getExpireDate(new Date(), 1));

		return save(contract);
	}

	public Date getExpireDate(Date previousExpiredDate, int numberOfMpnths) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(previousExpiredDate);
		calendar.add(Calendar.DAY_OF_MONTH, 30 * numberOfMpnths);
		return calendar.getTime();
	}

	public void deleteById(Long id) {
		contractRepository.deleteById(id);
	}

	public List<Contract> getContractByRenting(Renting renting) {
		return contractRepository.getContractByRenting(renting);
	}

	public List<Contract> getContractByRentee(Rentee rentee) {
		return contractRepository.getContractByRentee(rentee);
	}

	public List<BillContractServiceModel> getBillContractServiceModels(long contractId) {
		Contract contract = findById(contractId);
		if (contract == null) {
			ResponseEntity.badRequest().build();
		}

		Renting renting = contract.getRenting();

		List<RentingFacility> rentingFacilities = renting.getRentingFacility();

		List<BillContractServiceModel> billContractServiceModels = new LinkedList<BillContractServiceModel>();
		if (rentingFacilities == null || rentingFacilities.isEmpty()) {
			return billContractServiceModels;
		}

		for (RentingFacility rentingFacility : rentingFacilities) {
			BillContractServiceModel billContractServiceModel = new BillContractServiceModel();
			billContractServiceModel.setRentingFacilityId(rentingFacility.getId());
			billContractServiceModel.setLastUnit(rentingFacility.getUnits());
			com.rdongol.rentcollection.model.Service service = rentingFacility.getService();

			billContractServiceModel.setServiceName(service.getName());
			billContractServiceModel.setServiceType(service.getType());

			billContractServiceModel.setServiceCharge(service.getCharge());

			billContractServiceModels.add(billContractServiceModel);

		}

		return billContractServiceModels;

	}

	public boolean areAllBillsCleared(long contractId) {
		List<Transaction> transactions = transactionService.getUnpaidBills(contractId);
		return transactions.size() <= 0;
	}

	public void terminateContract(long contractId) {
		Contract contract = findById(contractId);
		if (contract == null) {
			ResponseEntity.badRequest().build();
		}

		ContractLog contractLog = contractLogService.getContractLogByContractId(contractId);
		contractLog.setTerminatedDate(new Date());

		deleteById(contractId);

	}

	public void payAndTerminatecontract(Transaction transaction) {

		transactionService.payTransaction(transaction, true);
		terminateContract(transaction.getContractId());
	}

	public int countExpiredContracts() {
		return contractRepository.countExpiredContracts();
	}
}
