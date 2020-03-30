package com.rdongol.rentcollection.model;

import java.util.List;

public class RentingModel {
	private long id;

	private String name;
	
	private String type;

	private int numberOfRooms;

	private double price;

	private List<RentingFacilityModel> rentingFacilities;

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

	public List<RentingFacilityModel> getRentingFacilities() {
		return rentingFacilities;
	}

	public void setRentingFacilities(List<RentingFacilityModel> rentingFacilities) {
		this.rentingFacilities = rentingFacilities;
	}

	public RentingModel(long id, String type, int numberOfRooms, double price, List<RentingFacilityModel> rentingFacilities) {
	
		super();
		this.id = id;
		this.type = type;
		this.numberOfRooms = numberOfRooms;
		this.price = price;
		this.rentingFacilities = rentingFacilities;
	}
	
	@Override
	public String toString() {
		return "RentingModel [id=" + id + ", name=" + name + ", type=" + type + ", numberOfRooms=" + numberOfRooms
				+ ", price=" + price + ", rentingFacilities=" + rentingFacilities + "]";
	}

}
