package com.rdongol.rentcollection.model;

public class ContractModel {

	long rentingId;
	long renteeId;
	String paymentType;

	public ContractModel() {

	}

	public ContractModel(long rentingId, long renteeId, String paymentType) {
		super();
		this.rentingId = rentingId;
		this.renteeId = renteeId;
		this.paymentType = paymentType;
	}

	public long getRentingId() {
		return rentingId;
	}

	public void setRentingId(long rentingId) {
		this.rentingId = rentingId;
	}

	public long getRenteeId() {
		return renteeId;
	}

	public void setRenteeId(long renteeId) {
		this.renteeId = renteeId;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

}
