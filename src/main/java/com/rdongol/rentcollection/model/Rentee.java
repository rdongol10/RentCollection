package com.rdongol.rentcollection.model;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Rentee {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	private String firstName;

	private String lastName;

	private String middleName;

	private String phoneNumber;

	private long citizenshipNumber;

	private String emailId;

	private String address;

	private String sex;

	private Date dob;

	@OneToMany(mappedBy = "rentee", cascade = CascadeType.ALL)
	private List<RenteeDependent> renteeDependent;

	public Rentee() {

	}

	public Rentee(RenteeModel renteeModel) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.id = renteeModel.getId();
			this.firstName = renteeModel.getFirstName();
			this.lastName = renteeModel.getLastName();
			this.middleName = renteeModel.getMiddleName();
			this.phoneNumber = renteeModel.getPhoneNumber();
			this.citizenshipNumber = renteeModel.getCitizenshipNumber();
			this.emailId = renteeModel.getEmailId();
			this.address = renteeModel.getAddress();
			this.sex = renteeModel.getSex();
			this.dob = df.parse(renteeModel.getDob());
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public Rentee(long id, String firstName, String lastName, String middleName, String phoneNumber,
			long citizenshipNumber, String emailId, String address, String sex, Date dob,
			List<RenteeDependent> renteeDependent) {
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
		this.renteeDependent = renteeDependent;
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

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public List<RenteeDependent> getRenteeDependent() {
		return renteeDependent;
	}

	public void setRenteeDependent(List<RenteeDependent> renteeDependent) {
		this.renteeDependent = renteeDependent;
	}

}
