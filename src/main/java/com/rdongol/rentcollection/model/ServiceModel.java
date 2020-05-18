package com.rdongol.rentcollection.model;

public class ServiceModel {

	private Long id;
	private String serviceName;
	private String serviceType;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public ServiceModel(Long id, String serviceName, String serviceType) {
		super();
		this.id = id;
		this.serviceName = serviceName;
		this.serviceType = serviceType;
	}

}
