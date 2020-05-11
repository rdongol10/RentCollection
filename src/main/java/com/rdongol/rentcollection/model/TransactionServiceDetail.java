package com.rdongol.rentcollection.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class TransactionServiceDetail {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@ManyToOne
	@JoinColumn(name = "transaction_detail_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private TransactionDetail transactionDetail;

	private String volumeCuttoff;

	private double rate;

	private long unit;

	private double serviceCharge;

	private double total;

	public TransactionServiceDetail() {

	}

	public TransactionServiceDetail(long id, TransactionDetail transactionDetail, String volumeCuttoff, double rate,
			long unit, double serviceCharge, double total) {
		super();
		this.id = id;
		this.transactionDetail = transactionDetail;
		this.volumeCuttoff = volumeCuttoff;
		this.rate = rate;
		this.unit = unit;
		this.serviceCharge = serviceCharge;
		this.total = total;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public TransactionDetail getTransactionDetail() {
		return transactionDetail;
	}

	public void setTransactionDetail(TransactionDetail transactionDetail) {
		this.transactionDetail = transactionDetail;
	}

	public String getVolumeCuttoff() {
		return volumeCuttoff;
	}

	public void setVolumeCuttoff(String volumeCuttoff) {
		this.volumeCuttoff = volumeCuttoff;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public long getUnit() {
		return unit;
	}

	public void setUnit(long unit) {
		this.unit = unit;
	}

	public double getServiceCharge() {
		return serviceCharge;
	}

	public void setServiceCharge(double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
