package com.rdongol.rentcollection.model;

public class RentingFacilityModel {

	private long id;

	private long serviceId;

	private long units;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

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

	public  RentingFacilityModel() {
	
	}

	public RentingFacilityModel(long id, long serviceId, long units) {
		super();
		this.id = id;
		this.serviceId = serviceId;
		this.units = units;
	}
	
	public  RentingFacilityModel(RentingFacility rentingFacility) {
		super();
		this.id=rentingFacility.getId();
		this.serviceId=rentingFacility.getService().getId();
		this.units=rentingFacility.getUnits();
	}

	@Override
	public String toString() {
		return "RentingFacilityModel [id=" + id + ", serviceId=" + serviceId + ", units=" + units + "]";
	}
	
	

}
