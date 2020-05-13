package com.rdongol.rentcollection.service;

import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.BillContractServiceModel;
import com.rdongol.rentcollection.model.Contract;
import com.rdongol.rentcollection.model.ContractLog;
import com.rdongol.rentcollection.model.Rentee;
import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingFacility;
import com.rdongol.rentcollection.model.ServiceDetail;
import com.rdongol.rentcollection.model.Transaction;
import com.rdongol.rentcollection.model.TransactionDetail;
import com.rdongol.rentcollection.model.TransactionDetailModel;
import com.rdongol.rentcollection.model.TransactionServiceDetail;
import com.rdongol.rentcollection.repository.TransactionRepository;

@Service
public class TransactionService {

	@Autowired
	private TransactionRepository transactionRepository;

	@Autowired
	private ContractService contractService;

	@Autowired
	private ServiceDetailService serviceDetailService;

	@Autowired
	private RentingFacilityService rentingFacilityService;

	@Autowired
	private ContractLogService contractLogService;

	@Autowired
	private RentingService rentingService;

	@Autowired
	private RenteeService renteeService;

	public List<Transaction> findAll() {
		return (List<Transaction>) transactionRepository.findAll();
	}

	public Transaction findById(Long id) {

		Optional<Transaction> transaction = transactionRepository.findById(id);

		if (!transaction.isPresent()) {
			return null;
		}

		return transaction.get();

	}

	public Transaction save(Transaction transaction) {
		return transactionRepository.save(transaction);
	}

	public void deleteById(Long id) {
		transactionRepository.deleteById(id);
	}

	public TransactionDetailModel getTransactDetail(Transaction transaction) {

		ContractLog contractLog = contractLogService.getContractLogByContractId(transaction.getContractId());

		Renting renting = rentingService.findById(contractLog.getRentingId());

		Rentee rentee = renteeService.findById(contractLog.getRenteeId());

		TransactionDetailModel transactionDetailModel = new TransactionDetailModel();

		transactionDetailModel.setTransaction(transaction);
		transactionDetailModel.setRentingName(renting.getName());
		transactionDetailModel.setRenteeName(rentee.getFirstName() + " " + rentee.getLastName());
		transactionDetailModel.setAddress(rentee.getAddress());
		transactionDetailModel.setNumber(rentee.getPhoneNumber());
		return transactionDetailModel;

	}

	public TransactionDetailModel getTransactionDetail(long contractId, int numberOfMonths,
			List<BillContractServiceModel> billContractServiceModels) {

		Transaction transaction = calculateBill(contractId, numberOfMonths, billContractServiceModels);

		return getTransactDetail(transaction);
	}

	public Transaction calculateBill(long contractId, int numberOfMonths,
			List<BillContractServiceModel> billContractServiceModels) {

		Contract contract = contractService.findById(contractId);
		if (contract == null) {
			ResponseEntity.badRequest().build();
		}

		Renting renting = contract.getRenting();

		Transaction transaction = new Transaction();

		transaction.setContractId(contractId);
		transaction.setNumberOfMonths(numberOfMonths);
		transaction.setContractCharge(renting.getPrice());
		transaction.setBilledDate(new Date());
		List<TransactionDetail> transactionDetails = new LinkedList<TransactionDetail>();
		for (BillContractServiceModel billContractServiceModel : billContractServiceModels) {

			TransactionDetail transactionDetail = calculateTransactionDetail(numberOfMonths, billContractServiceModel);
			if (transactionDetail != null) {

				transactionDetails.add(transactionDetail);

			}
		}

		transaction.setTransactionDetail(transactionDetails);

		transaction.setTotalCharge(getTransactionTotal(transactionDetails, renting.getPrice() * numberOfMonths));
		transaction.setNote(getTransactionNote(numberOfMonths, contract.getExpireDate()));
		return transaction;
	}
	
	private String getTransactionNote(int numberOfMonths, Date expireDate) {
		
		StringBuffer note = new StringBuffer();
		
		int monthCounts =-1;
		for(int i =1;i<=numberOfMonths ; i++) {
			Calendar paymentDate = Calendar.getInstance();
			paymentDate.setTime(expireDate);
			paymentDate.add(Calendar.DAY_OF_MONTH, monthCounts*30);
			note.append(paymentDate.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.US));
			note.append(" ");
			note.append(paymentDate.get(Calendar.YEAR));
			
			if(i<numberOfMonths) {
				note.append(" , ");
			}
			
			monthCounts++;
			
		}
		if(note.toString().trim().isEmpty()) {
			return "";
					
		}
		return "Invoice for " + note.toString();		
		
	}

	public TransactionDetail calculateTransactionDetail(int numberOfMonths,
			BillContractServiceModel billContractServiceModel) {

		RentingFacility rentingFacility = rentingFacilityService
				.findById(billContractServiceModel.getRentingFacilityId());

		if (rentingFacility == null) {
			return null;
		}
		com.rdongol.rentcollection.model.Service service = rentingFacility.getService();

		TransactionDetail transactionDetail = new TransactionDetail();

		transactionDetail.setRentingFacilityId(rentingFacility.getId());
		transactionDetail.setServiceName(service.getName());
		transactionDetail.setServiceCharge(0);
		transactionDetail.setMinimumCharge(0);

		if (service.getType().equalsIgnoreCase("fixed")) {

			transactionDetail.setCharge(service.getCharge());
			transactionDetail.setTotal(service.getCharge() * numberOfMonths);

		} else {

			transactionDetail.setMinimumCharge(service.getMinimumCharge());
			transactionDetail.setLastUnit(rentingFacility.getUnits());
			transactionDetail.setCurrentUnit(billContractServiceModel.getCurrentUnit());
			transactionDetail.setCharge(0);

			List<TransactionServiceDetail> transactionServiceDetails = calculateTransactionServiceDetails(
					billContractServiceModel, service);

			if (transactionServiceDetails != null && !transactionServiceDetails.isEmpty()) {
				transactionDetail.setTransactionServiceDetail(transactionServiceDetails);
				double serviceCharge = transactionServiceDetails.get(transactionServiceDetails.size() - 1)
						.getServiceCharge();

				transactionDetail.setServiceCharge(serviceCharge);

				transactionDetail.setTotal(getTotalTransactionDetail(transactionServiceDetails, serviceCharge,
						transactionDetail.getMinimumCharge()));

			}

		}

		return transactionDetail;
	}

	protected double getTransactionTotal(List<TransactionDetail> transactionDetails, double charge) {
		double total = 0;

		for (TransactionDetail transactionDetail : transactionDetails) {
			total += transactionDetail.getTotal();
		}

		return total + charge;

	}

	protected double getTotalTransactionDetail(List<TransactionServiceDetail> transactionServiceDetails,
			double serviceCharge, double minimumCharge) {

		double total = 0;
		for (TransactionServiceDetail transactionServiceDetail : transactionServiceDetails) {
			total += transactionServiceDetail.getTotal();
		}
		total += serviceCharge;

		if (total < minimumCharge) {
			return minimumCharge;
		}

		return total;
	}

	public List<TransactionServiceDetail> calculateTransactionServiceDetails(
			BillContractServiceModel billContractServiceModel, com.rdongol.rentcollection.model.Service service) {

		List<ServiceDetail> serviceDetails = serviceDetailService
				.getServiceDetailByServiceIdOrderByVolumeCutoff(service);

		long lastUnit = billContractServiceModel.getLastUnit();
		long currentUnit = billContractServiceModel.getCurrentUnit();

		long unitDifference = currentUnit - lastUnit;
		long ramainingUnit = unitDifference;
		int count = 1;

		List<TransactionServiceDetail> transactionServiceDetails = new LinkedList<TransactionServiceDetail>();

		for (ServiceDetail serviceDetail : serviceDetails) {

			TransactionServiceDetail transactionServiceDetail = new TransactionServiceDetail();

			long lowerRange = serviceDetail.getVolumeCutoff();
			long upperRange = 0;

			transactionServiceDetail.setRate(serviceDetail.getRate());
			transactionServiceDetail.setServiceCharge(serviceDetail.getServiceCharge());

			if (count < serviceDetails.size()) {

				ServiceDetail nextServiceDetail = serviceDetails.get(count);
				upperRange = nextServiceDetail.getVolumeCutoff();

				long unit = upperRange - lowerRange;

				transactionServiceDetail.setVolumeCuttoff(String.valueOf((upperRange - 1)));

				if (unit < ramainingUnit) {
					transactionServiceDetail.setUnit(unit);
					transactionServiceDetail.setTotal(unit * serviceDetail.getRate());
					ramainingUnit -= unit;
					transactionServiceDetails.add(transactionServiceDetail);

				} else {

					transactionServiceDetail.setUnit(ramainingUnit);
					transactionServiceDetail.setTotal(ramainingUnit * serviceDetail.getRate());
					transactionServiceDetails.add(transactionServiceDetail);
					break;

				}

			} else {

				String volumeCutoff = String.valueOf(serviceDetail.getVolumeCutoff()) + "+";
				transactionServiceDetail.setVolumeCuttoff(volumeCutoff);
				transactionServiceDetail.setUnit(ramainingUnit);
				transactionServiceDetail.setTotal(ramainingUnit * serviceDetail.getRate());
				transactionServiceDetails.add(transactionServiceDetail);

			}

			count++;
		}
		return transactionServiceDetails;
	}
}
