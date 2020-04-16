package com.rdongol.rentcollection.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Contract {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@ManyToOne
	@JoinColumn(name = "rentee_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Rentee rentee;

	@ManyToOne
	@JoinColumn(name = "renting_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Renting renting;

	private Date startDate;

	private Date endDate;

	private int active;

	private String paymentType;

	private Date lasPaidDate;

	public Contract() {

	}

	public Contract(long id, Rentee rentee, Renting renting, Date startDate, Date endDate, int active,
			String paymentType, Date lasPaidDate) {
		super();
		this.id = id;
		this.rentee = rentee;
		this.renting = renting;
		this.startDate = startDate;
		this.endDate = endDate;
		this.active = active;
		this.paymentType = paymentType;
		this.lasPaidDate = lasPaidDate;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Rentee getRentee() {
		return rentee;
	}

	public void setRentee(Rentee rentee) {
		this.rentee = rentee;
	}

	public Renting getRenting() {
		return renting;
	}

	public void setRenting(Renting renting) {
		this.renting = renting;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public Date getLasPaidDate() {
		return lasPaidDate;
	}

	public void setLasPaidDate(Date lasPaidDate) {
		this.lasPaidDate = lasPaidDate;
	}

}
