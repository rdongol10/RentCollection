package com.rdongol.rentcollection.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class TransactionDetail {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@ManyToOne
	@JoinColumn(name = "transaction_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Transaction transaction;

	private long rentingFacilityId;

	private String serviceName;

	private long lastUnit;

	private long currentUnit;

	private double charge;

	private double serviceCharge;

	private double minimumCharge;

	private double total;

	@OneToMany(mappedBy = "transactionDetail", cascade = CascadeType.ALL)
	private List<TransactionServiceDetail> transactionServiceDetail;

	public TransactionDetail() {

	}

	public TransactionDetail(long id, Transaction transaction, long rentingFacilityId, String serviceName,
			long lastUnit, long currentUnit, double serviceCharge, double minimumCharge, double total,
			List<TransactionServiceDetail> transactionServiceDetail, double charge) {
		super();
		this.id = id;
		this.transaction = transaction;
		this.rentingFacilityId = rentingFacilityId;
		this.serviceName = serviceName;
		this.lastUnit = lastUnit;
		this.currentUnit = currentUnit;
		this.serviceCharge = serviceCharge;
		this.minimumCharge = minimumCharge;
		this.total = total;
		this.transactionServiceDetail = transactionServiceDetail;
		this.charge = charge;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Transaction getTransaction() {
		return transaction;
	}

	public void setTransaction(Transaction transaction) {
		this.transaction = transaction;
	}

	public long getRentingFacilityId() {
		return rentingFacilityId;
	}

	public void setRentingFacilityId(long rentingFacilityId) {
		this.rentingFacilityId = rentingFacilityId;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public long getLastUnit() {
		return lastUnit;
	}

	public void setLastUnit(long lastUnit) {
		this.lastUnit = lastUnit;
	}

	public long getCurrentUnit() {
		return currentUnit;
	}

	public void setCurrentUnit(long currentUnit) {
		this.currentUnit = currentUnit;
	}

	public double getCharge() {
		return charge;
	}

	public void setCharge(double charge) {
		this.charge = charge;
	}

	public double getServiceCharge() {
		return serviceCharge;
	}

	public void setServiceCharge(double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

	public double getMinimumCharge() {
		return minimumCharge;
	}

	public void setMinimumCharge(double minimumCharge) {
		this.minimumCharge = minimumCharge;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public List<TransactionServiceDetail> getTransactionServiceDetail() {
		return transactionServiceDetail;
	}

	public void setTransactionServiceDetail(List<TransactionServiceDetail> transactionServiceDetail) {
		this.transactionServiceDetail = transactionServiceDetail;
	}

}
