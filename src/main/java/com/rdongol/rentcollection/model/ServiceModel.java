package com.rdongol.rentcollection.model;

public class ServiceModel {

	private Long id;
	private String serviceName;

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

	public ServiceModel(Long id, String serviceName) {
		super();
		this.id = id;
		this.serviceName = serviceName;
	}

}
