package com.rdongol.rentcollection.model;

public class ContractModel {

	long rentingId;
	long renteeId;

	public ContractModel() {

	}

	public ContractModel(long rentingId, long renteeId) {
		super();
		this.rentingId = rentingId;
		this.renteeId = renteeId;
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
}
