package com.rdongol.rentcollection.service.datatable;

import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("contractListDataTableBackend")
public class ContractListDataTableBackend extends AbstractDataTableBackend {

	@Override
	protected void initializeTableColumns() {
		tableColumns.add("renting.name");
		tableColumns.add("rentee.first_name");
		tableColumns.add("contract.start_date");
		tableColumns.add("contract.payment_type");
		tableColumns.add("contract.last_paid_date");
		tableColumns.add("contract.expire_date");

	}

	@Override
	protected void setSelectCriteria() {
		selectCriteria = "Select contract.id,renting.name,rentee.first_name,contract.start_date , contract.payment_type , contract.last_paid_date,contract.expire_date ";

	}

	@Override
	protected void setFromCriteria() {
		fromCriteria = " From contract , renting , rentee  ";

	}

	@Override
	protected void setWhereCriteria() {
		whereCriteria = " where contract.renting_id=renting.id and contract.rentee_id=rentee.id ";

	}

	@SuppressWarnings("unchecked")
	@Override
	protected List<List<String>> getQueryResults() {
		List<List<String>> tableData = new LinkedList<List<String>>();
		Query query = entityManager.createNativeQuery(getQuery());
		List<Object[]> rentings = query.getResultList();
		for (Object[] renting : rentings) {

			List<String> data = new LinkedList<String>();

			data.add(String.valueOf(renting[1]));
			data.add(String.valueOf(renting[2]));
			data.add(String.valueOf(renting[3]));
			data.add(String.valueOf(renting[4]));
			data.add(String.valueOf(renting[5]));
			data.add(String.valueOf(renting[6]));
			data.add(getActionButtons(String.valueOf(renting[0])));

			tableData.add(data);
		}

		return tableData;
	}

	protected String getActionButtons(String contractId) {
		
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getDeleteContractAction(contractId));
		actionButtons.append(" ");
		actionButtons.append(getContractDetailsAction(contractId));
		actionButtons.append(" ");
		actionButtons.append(getBillContractAaction(contractId));

		return actionButtons.toString();
	}

	protected String getDeleteContractAction(String contractId) {

		StringBuffer deleteContract = new StringBuffer();
		deleteContract.append("<i class='actionButton deleteContract fas fa-trash-alt' contractId='" + contractId
				+ "' title='terminate contract' style = 'color:#FF686B'></i>");
		return deleteContract.toString();

	}

	protected String getContractDetailsAction(String contractId) {
		StringBuffer contractDetails = new StringBuffer();
		contractDetails.append("<i class='actionButton details fas fa-info-circle' contractId='" + contractId
				+ "' title='details' style = 'color:#666666'> </i>");
		return contractDetails.toString();
	}

	protected String getBillContractAaction(String contractId) {

		StringBuffer billContract = new StringBuffer();
		billContract.append("<i class='actionButton billContract fas fa-file-invoice-dollar' contractId='" + contractId
				+ "' title='bill contract' ></i>");
		return billContract.toString();

	}

	protected BigInteger getTotalRecords() {

		StringBuffer query = new StringBuffer();
		query.append(" Select count(distinct(contract.id)) ");
		query.append(fromCriteria);
		query.append(whereCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();

	}

	protected BigInteger getTotalFilteredRecords() {
		StringBuffer query = new StringBuffer();
		query.append(" Select count(distinct(contract.id)) ");
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(searchFilterCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();
	}

}
