package com.rdongol.rentcollection.model;

import java.util.List;

public class RentingDisplayModal {

	private List<String> imageBase64s;

	private String name;

	private String type;

	private int numberOfRooms;

	private double price;

	private List<RentingFacility> rentingFacilities;

	private RenteeModel renteeModel;

	public RentingDisplayModal() {

	}

	public RentingDisplayModal(List<String> imageBase64s, String name, String type, int numberOfRooms, double price,
			List<RentingFacility> rentingFacilities, RenteeModel renteeModel) {
		super();
		this.imageBase64s = imageBase64s;
		this.name = name;
		this.type = type;
		this.numberOfRooms = numberOfRooms;
		this.price = price;
		this.rentingFacilities = rentingFacilities;
		this.renteeModel = renteeModel;
	}

	public List<String> getImageBase64s() {
		return imageBase64s;
	}

	public void setImageBase64s(List<String> imageBase64s) {
		this.imageBase64s = imageBase64s;
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

	public List<RentingFacility> getRentingFacilities() {
		return rentingFacilities;
	}

	public void setRentingFacilities(List<RentingFacility> rentingFacilities) {
		this.rentingFacilities = rentingFacilities;
	}

	public RenteeModel getRenteeModel() {
		return renteeModel;
	}

	public void setRenteeModel(RenteeModel renteeModel) {
		this.renteeModel = renteeModel;
	}
	
	


}
