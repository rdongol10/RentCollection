package com.rdongol.rentcollection.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

public class RenteeModel {

	private long id;

	private String firstName;

	private String lastName;

	private String middleName;

	private String phoneNumber;

	private long citizenshipNumber;

	private String emailId;

	private String address;

	private String sex;

	private String dob;
	
	private String renteeImageBase64;
	
	private String citizenshipImageBase64;
	
	private String citizenshipBackImageBase64;
	
	private List<RenteeDependentModel> renteeDependentModels;

	public RenteeModel() {
		
	}
	
	public RenteeModel(Rentee rentee) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		this.id = rentee.getId();
		this.firstName = rentee.getFirstName();
		this.lastName = rentee.getLastName();
		this.middleName = rentee.getMiddleName();
		this.phoneNumber = rentee.getPhoneNumber();
		this.citizenshipNumber = rentee.getCitizenshipNumber();
		this.emailId = rentee.getEmailId();
		this.address = rentee.getAddress();
		this.sex = rentee.getSex();
		this.dob = df.format(rentee.getDob());
	}
	
	public RenteeModel(long id, String firstName, String lastName, String middleName, String phoneNumber,
			long citizenshipNumber, String emailId, String address, String sex, String dob, String renteeImageBase64,
			String citizenshipImageBase64, String citizenshipBackImageBase64,
			List<RenteeDependentModel> renteeDependentModels) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.middleName = middleName;
		this.phoneNumber = phoneNumber;
		this.citizenshipNumber = citizenshipNumber;
		this.emailId = emailId;
		this.address = address;
		this.sex = sex;
		this.dob = dob;
		this.renteeImageBase64 = renteeImageBase64;
		this.citizenshipImageBase64 = citizenshipImageBase64;
		this.citizenshipBackImageBase64 = citizenshipBackImageBase64;
		this.renteeDependentModels = renteeDependentModels;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public long getCitizenshipNumber() {
		return citizenshipNumber;
	}

	public void setCitizenshipNumber(long citizenshipNumber) {
		this.citizenshipNumber = citizenshipNumber;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getRenteeImageBase64() {
		return renteeImageBase64;
	}

	public void setRenteeImageBase64(String renteeImageBase64) {
		this.renteeImageBase64 = renteeImageBase64;
	}

	public String getCitizenshipImageBase64() {
		return citizenshipImageBase64;
	}

	public void setCitizenshipImageBase64(String citizenshipImageBase64) {
		this.citizenshipImageBase64 = citizenshipImageBase64;
	}

	public String getCitizenshipBackImageBase64() {
		return citizenshipBackImageBase64;
	}

	public void setCitizenshipBackImageBase64(String citizenshipBackImageBase64) {
		this.citizenshipBackImageBase64 = citizenshipBackImageBase64;
	}

	public List<RenteeDependentModel> getRenteeDependentModels() {
		return renteeDependentModels;
	}

	public void setRenteeDependentModels(List<RenteeDependentModel> renteeDependentModels) {
		this.renteeDependentModels = renteeDependentModels;
	}
	
}
