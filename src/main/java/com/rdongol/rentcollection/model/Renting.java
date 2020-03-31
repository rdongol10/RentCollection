package com.rdongol.rentcollection.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Renting {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	private String name;
	
	private String type;

	private int numberOfRooms;

	private double price;

	private int status;
	
	@OneToMany(mappedBy = "renting" , cascade = CascadeType.ALL)
	private List<RentingFacility> rentingFacility;

	public Renting() {
		
	}
	
	public Renting(long id, String name, String type, int numberOfRooms, double price, int status,
			List<RentingFacility> rentingFacility) {
		super();
		this.id = id;
		this.name = name;
		this.type = type;
		this.numberOfRooms = numberOfRooms;
		this.price = price;
		this.status = status;
		this.rentingFacility = rentingFacility;
	}

	public Renting(RentingModel rentingModel) {

		this.id = rentingModel.getId();
		this.name = rentingModel.getName();
		this.type = rentingModel.getType();
		this.numberOfRooms = rentingModel.getNumberOfRooms();
		this.price = rentingModel.getPrice();
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getNumberOfRooms() {
		return numberOfRooms;
	}

	public void setNumberOfRooms(int numberOfRooms) {
		this.numberOfRooms = numberOfRooms;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<RentingFacility> getRentingFacility() {
		return rentingFacility;
	}

	public void setRentingFacility(List<RentingFacility> rentingFacility) {
		this.rentingFacility = rentingFacility;
	}
	
}
