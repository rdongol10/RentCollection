package com.rdongol.rentcollection.service.datatable;

import java.io.StringReader;
import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Qualifier("rentingListDataTableBackend")
public class RentingListDataTableBackend extends AbstractDataTableBackend {

	public boolean available = false;
	protected String groupCriteria;

	@Override
	public void intialize(String dataTableRequest) {

		if (dataTableRequest == null || dataTableRequest.isEmpty()) {
			return;
		}

		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode rootNode = mapper.readTree(new StringReader(dataTableRequest));
			available = rootNode.get("available").asBoolean();
		} catch (Exception e) {
			e.printStackTrace();
		}

		super.intialize(dataTableRequest);

	}

	@Override
	protected void intializeCriterias() {
		setSelectCriteria();
		setFromCriteria();
		setWhereCriteria();
		setSearchFilterCriteria();
		setGroupCriteria();
		setOrderCriteria();
		setPaginationCriteria();
	}

	@Override
	protected String getQuery() {

		StringBuffer query = new StringBuffer();
		query.append(selectCriteria);
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(searchFilterCriteria);
		query.append(groupCriteria);
		query.append(orderCriteria);
		query.append(paginationCriteria);
		return query.toString();
	}

	@Override
	protected void initializeTableColumns() {
		tableColumns.add("renting.name");
		tableColumns.add("renting.type");
		tableColumns.add("renting.number_of_rooms");
		tableColumns.add("renting.price");
		tableColumns.add("renting.status");
	}

	@Override
	protected void setSelectCriteria() {
		selectCriteria = " Select renting.id,renting.name,renting.type,renting.number_of_rooms,renting.price,renting.status, contract.id as contract_id ";

	}

	@Override
	protected void setFromCriteria() {
		fromCriteria = " From renting LEFT JOIN contract ON renting.id = contract.renting_id ";

	}

	protected void setWhereCriteria() {
		if (available) {
			whereCriteria = " WHERE (contract.id is null  AND renting.status = 1 ) ";
		} else {

			whereCriteria = "";

		}
	}

	public void setGroupCriteria() {
		groupCriteria = " GROUP BY renting.id ";
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
			data.add(Integer.valueOf(renting[5].toString()) == 1 ? "Active" : "Inactive");
			data.add(getActionButtons(String.valueOf(renting[0]), Integer.valueOf(renting[5].toString()), renting[6]));

			tableData.add(data);
		}

		return tableData;

	}

	protected String getActionButtons(String rentingId, int active, Object contractId) {
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getEditRengingAction(rentingId));
		actionButtons.append(" ");
		actionButtons.append(getDeleteRentingAction(rentingId, active, contractId));
		actionButtons.append(" ");
		actionButtons.append(getAddContractAction(rentingId, active, contractId));
		actionButtons.append(" ");
		actionButtons.append(getRentingDetailsAction(rentingId));
		return actionButtons.toString();
	}
	
	protected String getRentingDetailsAction(String rentingId) {
		StringBuffer rentingDetails = new StringBuffer();
		rentingDetails.append("<i class='actionButton details fas fa-info-circle fa-lg' rentingId='" + rentingId
				+ "' title='details' style = 'color:#666666'> </i>");
		return rentingDetails.toString();
	}

	protected String getEditRengingAction(String rentingId) {
		StringBuffer editRenting = new StringBuffer();
		editRenting.append("<i class='actionButton editRenting fas fa-edit fa-lg' rentingId='" + rentingId
				+ "' title='edit' style = 'color:#3559BA'> </i>");
		return editRenting.toString();
	}

	protected String getDeleteRentingAction(String rentingId, int active, Object contractId) {

		if (contractId != null) {
			return "";
		}

		StringBuffer deleteRenting = new StringBuffer();
		if (active == 1) {
			deleteRenting.append("<i class='actionButton toggleRenting fas fa-toggle-on fa-lg' rentingId='" + rentingId
					+ "' title='disable' style = 'color:#009B33'></i>");
		} else {
			deleteRenting.append("<i class='actionButton toggleRenting fas fa-toggle-off fa-lg' rentingId='" + rentingId
					+ "' title='enable' style = 'color:#FF686B'></i>");
		}
		return deleteRenting.toString();
	}

	protected String getAddContractAction(String rentingId, int active, Object contractId) {
		if (contractId != null) {
			return "";
		}

		if (active != 1) {
			return "";
		}
		StringBuffer contractRenting = new StringBuffer();

		contractRenting.append("<i class='actionButton contractRenting fas fa-file-signature fa-lg' rentingId='" + rentingId
				+ "' title='add contract' style ='color : #1CBC94' ></i>");
		return contractRenting.toString();
	}

	@Override
	protected BigInteger getTotalRecords() {

		StringBuffer query = new StringBuffer();
		query.append(" Select count(distinct(renting.id)) ");
		query.append(fromCriteria);
		query.append(whereCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();

	}

	@Override
	protected BigInteger getTotalFilteredRecords() {
		StringBuffer query = new StringBuffer();
		query.append(" Select count(distinct(renting.id)) ");
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(searchFilterCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();
	}
}
