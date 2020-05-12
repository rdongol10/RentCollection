package com.rdongol.rentcollection.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class RenteeDependentModel {

	private long id;

	private String firstName;

	private String lastName;

	private String middleName;

	private String phoneNumber;

	private long citizenshipNumber;

	private String relationship;

	private String emailId;

	private String address;

	private String sex;

	private String dob;

	private String renteeDependentImageBase64;

	public RenteeDependentModel() {

	}

	public RenteeDependentModel(RenteeDependent renteeDependent) {

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		this.id = renteeDependent.getId();
		this.firstName = renteeDependent.getFirstName();
		this.lastName = renteeDependent.getLastName();
		this.middleName = renteeDependent.getMiddleName();
		this.phoneNumber = renteeDependent.getPhoneNumber();
		this.citizenshipNumber = renteeDependent.getCitizenshipNumber();
		this.emailId = renteeDependent.getEmailId();
		this.address = renteeDependent.getAddress();
		this.sex = renteeDependent.getSex();
		this.relationship = renteeDependent.getRelationship();
		this.dob = df.format(renteeDependent.getDob());

	}

	public RenteeDependentModel(long id, String firstName, String lastName, String middleName, String phoneNumber,
			long citizenshipNumber, String relationship, String emailId, String address, String sex, String dob,
			String renteeDependentImageBase64) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.middleName = middleName;
		this.phoneNumber = phoneNumber;
		this.citizenshipNumber = citizenshipNumber;
		this.relationship = relationship;
		this.emailId = emailId;
		this.address = address;
		this.sex = sex;
		this.dob = dob;
		this.renteeDependentImageBase64 = renteeDependentImageBase64;
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

	public String getRelationship() {
		return relationship;
	}

	public void setRelationship(String relationship) {
		this.relationship = relationship;
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

	public String getRenteeDependentImageBase64() {
		return renteeDependentImageBase64;
	}

	public void setRenteeDependentImageBase64(String renteeDependentImageBase64) {
		this.renteeDependentImageBase64 = renteeDependentImageBase64;
	}

}
