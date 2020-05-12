package com.rdongol.rentcollection.model;

public class TransactionDetailModel {

	private Transaction transaction;
	private String rentingName;
	private String renteeName;
	private String address;
	private String number;

	public TransactionDetailModel() {

	}

	public TransactionDetailModel(Transaction transaction, String rentingName, String renteeName, String address,
			String number) {
		super();
		this.transaction = transaction;
		this.rentingName = rentingName;
		this.renteeName = renteeName;
		this.address = address;
		this.number = number;
	}

	public Transaction getTransaction() {
		return transaction;
	}

	public void setTransaction(Transaction transaction) {
		this.transaction = transaction;
	}

	public String getRentingName() {
		return rentingName;
	}

	public void setRentingName(String rentingName) {
		this.rentingName = rentingName;
	}

	public String getRenteeName() {
		return renteeName;
	}

	public void setRenteeName(String renteeName) {
		this.renteeName = renteeName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

}
