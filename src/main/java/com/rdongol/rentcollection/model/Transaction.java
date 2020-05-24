package com.rdongol.rentcollection.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Transaction {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	private long contractId;

	private Date billedDate;

	private int paid;

	private Date paidDate;

	private int numberOfMonths;

	private double contractCharge;

	private double charge;
	
	private double totalCharge;

	private String note;

	@OneToMany(mappedBy = "transaction", cascade = CascadeType.ALL)
	private List<TransactionDetail> transactionDetail;

	public Transaction() {

	}

	public Transaction(long id, String transactionNumber, long contractId, Date billedDate, int paid, Date paidDate,
			int numberOfMonths, double contractCharge,double charge , double totalCharge, List<TransactionDetail> transactionDetail,
			String note) {
		super();
		this.id = id;
		this.contractId = contractId;
		this.billedDate = billedDate;
		this.paid = paid;
		this.paidDate = paidDate;
		this.numberOfMonths = numberOfMonths;
		this.contractCharge = contractCharge;
		this.charge = charge;
		this.totalCharge = totalCharge;
		this.transactionDetail = transactionDetail;
		this.note = note;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getContractId() {
		return contractId;
	}

	public void setContractId(long contractId) {
		this.contractId = contractId;
	}

	public Date getBilledDate() {
		return billedDate;
	}

	public void setBilledDate(Date billedDate) {
		this.billedDate = billedDate;
	}

	public int getPaid() {
		return paid;
	}

	public void setPaid(int paid) {
		this.paid = paid;
	}

	public Date getPaidDate() {
		return paidDate;
	}

	public void setPaidDate(Date paidDate) {
		this.paidDate = paidDate;
	}

	public int getNumberOfMonths() {
		return numberOfMonths;
	}

	public void setNumberOfMonths(int numberOfMonths) {
		this.numberOfMonths = numberOfMonths;
	}

	public double getContractCharge() {
		return contractCharge;
	}

	public void setContractCharge(double contractCharge) {
		this.contractCharge = contractCharge;
	}
	
	public double getCharge() {
		return charge;
	}

	public void setCharge(double charge) {
		this.charge = charge;
	}

	public double getTotalCharge() {
		return totalCharge;
	}

	public void setTotalCharge(double totalCharge) {
		this.totalCharge = totalCharge;
	}

	public List<TransactionDetail> getTransactionDetail() {
		return transactionDetail;
	}

	public void setTransactionDetail(List<TransactionDetail> transactionDetail) {
		this.transactionDetail = transactionDetail;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
