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

	private Date lastPaidDate;

	private Date expireDate;

	public Contract() {

	}

	public Contract(long id, Rentee rentee, Renting renting, Date startDate, Date lastPaidDate,
			Date expireDate) {
		super();
		this.id = id;
		this.rentee = rentee;
		this.renting = renting;
		this.startDate = startDate;
		this.lastPaidDate = lastPaidDate;
		this.expireDate = expireDate;
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

	public Date getLastPaidDate() {
		return lastPaidDate;
	}

	public void setLastPaidDate(Date lastPaidDate) {
		this.lastPaidDate = lastPaidDate;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

}
