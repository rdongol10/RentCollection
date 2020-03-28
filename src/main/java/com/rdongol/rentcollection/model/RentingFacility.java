package com.rdongol.rentcollection.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class RentingFacility {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@ManyToOne
	@JoinColumn(name = "renting_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Renting renting;

	@ManyToOne
	@JoinColumn(name = "service_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Service service;

	private long units;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Renting getRenting() {
		return renting;
	}

	public void setRenting(Renting renting) {
		this.renting = renting;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public long getUnits() {
		return units;
	}

	public void setUnits(long units) {
		this.units = units;
	}
	
	
}
