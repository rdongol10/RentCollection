package com.rdongol.rentcollection.model;

public class BillContractServiceModel {

	private long rentingFacilityId;
	private String serviceName;
	private String serviceType;
	private double serviceCharge;
	private long lastUnit;
	private long currentUnit;

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

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public double getServiceCharge() {
		return serviceCharge;
	}

	public void setServiceCharge(double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

}
