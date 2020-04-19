package com.rdongol.rentcollection.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ContractLog {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;
	private long contractId;
	private long rentingId;
	private long renteeId;
	private Date startDate;
	private Date terminatedDate;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getContractId() {
		return contractId;
	}

	public void setContractId(long contractId) {
		this.contractId = contractId;
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getTerminatedDate() {
		return terminatedDate;
	}

	public void setTerminatedDate(Date terminatedDate) {
		this.terminatedDate = terminatedDate;
	}

}
