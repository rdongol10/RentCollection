package com.rdongol.rentcollection.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class RenteeDependent {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;
	
	@ManyToOne
	@JoinColumn(name = "rentee_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Rentee rentee;
	
	private String firstName;
	
	private String lastName;
	
	private String middleName;
	
	private String phoneNumber;
	
	private long citizenshipNumber;
	
	private String relationship;
	
	private String emailId;
	
	private String address;
	
	public RenteeDependent(long id, String firstName, String lastName, String middleName, String phoneNumber,
			long citizenshipNumber, String relationship, String emailId, String address) {
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
	
	
}
