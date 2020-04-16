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
		selectCriteria = " Select renting.id,renting.name,renting.type,renting.number_of_rooms,renting.price,renting.status, contract.id as contract_id, contract.end_date ";

	}

	@Override
	protected void setFromCriteria() {
		fromCriteria = " From renting LEFT JOIN contract ON renting.id = contract.renting_id ";

	}

	protected void setWhereCriteria() {
		if (available) {
			whereCriteria = " WHERE ((contract.id is null OR contract.end_date is null) AND renting.status = 1 ) ";
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
			data.add(getActionButtons(String.valueOf(renting[0]), Integer.valueOf(renting[5].toString()), renting[6],
					renting[7]));

			tableData.add(data);
		}

		return tableData;

	}

	protected String getActionButtons(String rentingId, int active, Object contractId, Object contractEndDate) {
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getEditRengingAction(rentingId));
		actionButtons.append(" ");
		actionButtons.append(getDeleteRentingAction(rentingId, active, contractId, contractEndDate));
		actionButtons.append(" ");
		actionButtons.append(getAddContractAction(rentingId, active, contractId, contractEndDate));
		return actionButtons.toString();
	}

	protected String getEditRengingAction(String rentingId) {
		StringBuffer editRenting = new StringBuffer();
		editRenting.append("<i class='actionButton editRenting fas fa-edit' rentingId='" + rentingId
				+ "' title='edit' style = 'color:blue'> </i>");
		return editRenting.toString();
	}

	protected String getDeleteRentingAction(String rentingId, int active, Object contractId, Object contractEndDate) {

		if (contractId != null && contractEndDate != null) {
			return "";
		}

		StringBuffer deleteRenting = new StringBuffer();
		if (active == 1) {
			deleteRenting.append("<i class='actionButton toggleRenting fas fa-toggle-off' rentingId='" + rentingId
					+ "' title='disable' style = 'color:red'></i>");
		} else {
			deleteRenting.append("<i class='actionButton toggleRenting fas fa-toggle-on' rentingId='" + rentingId
					+ "' title='enable' style = 'color:green'></i>");
		}
		return deleteRenting.toString();
	}

	protected String getAddContractAction(String rentingId, int active, Object contractId, Object contractEndDate) {
		if (contractId != null && contractEndDate != null) {
			return "";
		}

		StringBuffer contractRenting = new StringBuffer();

		contractRenting.append("<i class='actionButton contractRenting fas fa-plus' rentingId='" + rentingId
				+ "' title='add contract ' style = 'color:green'></i>");
		return contractRenting.toString();
	}
	
	
	@Override
	protected BigInteger getTotalRecords() {

		StringBuffer query = new StringBuffer();
		query.append(" Select count(renting.id) ");
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(groupCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();

	}

	@Override
	protected BigInteger getTotalFilteredRecords() {
		StringBuffer query = new StringBuffer();
		query.append(" Select count(renting.id) ");
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(searchFilterCriteria);
		query.append(groupCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();
	}
}
