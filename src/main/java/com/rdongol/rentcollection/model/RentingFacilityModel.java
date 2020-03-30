package com.rdongol.rentcollection.model;

public class RentingFacilityModel {

	private long serviceId;
	
	private long units;

	public long getServiceId() {
		return serviceId;
	}

	public void setServiceId(long serviceId) {
		this.serviceId = serviceId;
	}

	public long getUnits() {
		return units;
	}

	public void setUnits(long units) {
		this.units = units;
	}

	public RentingFacilityModel(long serviceId, long units) {
		super();
		this.serviceId = serviceId;
		this.units = units;
	}
	
	
}
