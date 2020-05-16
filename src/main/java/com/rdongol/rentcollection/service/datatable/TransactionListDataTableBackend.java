package com.rdongol.rentcollection.service.datatable;

import java.io.StringReader;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Qualifier("transactionListDataTableBackend")
public class TransactionListDataTableBackend extends AbstractDataTableBackend {

	public Date startBilledDate = null;
	public Date endBilledDate = null;
	public int renteeId = 0;
	public int rentingId = 0;

	@Override
	public void intialize(String dataTableRequest) {

		if (dataTableRequest == null || dataTableRequest.isEmpty()) {
			return;
		}

		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode rootNode = mapper.readTree(new StringReader(dataTableRequest));
			String billedDate = rootNode.get("billedDate").asText();
			if (billedDate != null && !billedDate.trim().equals("")) {
				DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
				startBilledDate = df.parse(billedDate.split("-")[0].trim());
				endBilledDate = df.parse(billedDate.split("-")[1].trim());
			}

			if (rootNode.get("renteeId").asText() != null && !rootNode.get("renteeId").asText().trim().equals("")) {
				renteeId = rootNode.get("renteeId").asInt();
			}

			if (rootNode.get("rentingId").asText() != null && !rootNode.get("rentingId").asText().trim().equals("")) {
				rentingId = rootNode.get("rentingId").asInt();
			}

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
		query.append(orderCriteria);
		query.append(paginationCriteria);
		return query.toString();

	}

	@Override
	protected void initializeTableColumns() {

		tableColumns.add("transaction.id");
		tableColumns.add("renting.name");
		tableColumns.add("rentee.first_name");
		tableColumns.add("transaction.billed_date");
		tableColumns.add("transaction.paid_date");
		tableColumns.add("transaction.total_charge");
		tableColumns.add("transaction.note");

	}

	@Override
	protected void setSelectCriteria() {

		selectCriteria = " Select  transaction.id , renting.name , rentee.first_name ,rentee.middle_name, rentee.last_name , transaction.billed_date , transaction.paid_date, transaction.total_charge , transaction.note ";

	}

	@Override
	protected void setFromCriteria() {

		fromCriteria = "  From transaction , contract_log , renting , rentee ";

	}

	@Override
	protected void setWhereCriteria() {

		whereCriteria = " WHERE transaction.contract_id = contract_log.contract_id and  contract_log.rentee_id = rentee.id and contract_log.renting_id=renting.id";
		if ((startBilledDate != null && endBilledDate != null) || renteeId > 0 || rentingId > 0) {

			if (startBilledDate != null && endBilledDate != null) {
				DateFormat startDate = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
				DateFormat endDate = new SimpleDateFormat("yyyy-MM-dd 23:59:59");

				whereCriteria += " AND transaction.billed_date between '" + startDate.format(startBilledDate)
						+ "' AND '" + endDate.format(endBilledDate) + "'";

			}

			if (renteeId > 0) {

				whereCriteria += " AND rentee.id = '" + renteeId + "'";
			}

			if (rentingId > 0) {

				whereCriteria += " AND renting.id = '" + rentingId + "'";
			}

		}
	}

	@SuppressWarnings("unchecked")
	@Override
	protected List<List<String>> getQueryResults() {
		List<List<String>> tableData = new LinkedList<List<String>>();
		Query query = entityManager.createNativeQuery(getQuery());
		List<Object[]> objects = query.getResultList();
		for (Object[] object : objects) {
			List<String> data = new LinkedList<String>();
			data.add(String.valueOf(object[0]));
			data.add(String.valueOf(object[1]));
			data.add(getFullName(String.valueOf(object[2]), String.valueOf(object[3]), String.valueOf(object[4])));
			data.add(formatDate(object[5]));
			data.add(formatDate(object[6]));
			data.add(String.valueOf(object[7]));
			data.add(String.valueOf(object[8]));
			data.add(" ");

			tableData.add(data);

		}
		return tableData;
	}

	protected String getFullName(String firstName, String middleName, String lastName) {
		StringBuffer fullName = new StringBuffer();
		if (firstName != null && !firstName.trim().equals("")) {
			fullName.append(firstName);
		}

		if (middleName != null && !middleName.trim().equals("")) {
			fullName.append(" " + middleName);
		}

		if (lastName != null && !lastName.trim().equals("")) {
			fullName.append(" " + lastName);
		}
		return fullName.toString();

	}

	@Override
	protected BigInteger getTotalRecords() {

		StringBuffer query = new StringBuffer();
		query.append(" Select count(distinct(transaction.id)) ");
		query.append(fromCriteria);
		query.append(whereCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();

	}

	@Override
	protected BigInteger getTotalFilteredRecords() {
		StringBuffer query = new StringBuffer();
		query.append(" Select count(distinct(transaction.id)) ");
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(searchFilterCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();
	}
	
	protected void setSearchFilterCriteria() {

		if (searchValue == null || searchValue.isEmpty() || searchValue.trim().equals("")) {
			searchFilterCriteria = "";
			return;
		}

		StringBuffer searchFilter = new StringBuffer();

		if (whereCriteria == null || whereCriteria.isEmpty()) {
			setWhereCriteria();
		}

		if (!whereCriteria.toUpperCase().contains("WHERE")) {
			searchFilter.append(" WHERE ");
		}else {
			searchFilter.append(" AND ");
		}

		searchFilter.append(" ( ");

		int length = 1;
		for (String tableColumn : tableColumns) {

			if(tableColumn.equalsIgnoreCase("rentee.first_name")) {
				searchFilter.append(" rentee.first_name Like '%" + searchValue + "%' OR rentee.middle_name Like '%" + searchValue + "%' OR rentee.last_name Like '%" + searchValue + "%' ");
			}else {

				searchFilter.append(tableColumn + " Like '%" + searchValue + "%'");
				
			}
			if (length != tableColumns.size()) {
				searchFilter.append(" OR ");
			}
			length++;
		}

		searchFilter.append(" ) ");

		searchFilterCriteria = searchFilter.toString();

	}

}
