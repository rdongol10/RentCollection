package com.rdongol.rentcollection.service.datatable;

import java.io.StringReader;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public abstract class AbstractDataTableBackend {
	protected int start;
	protected int length;
	protected int draw;
	protected String searchValue;
	protected Map<Integer, String> orderableMap;
	protected List<String> tableColumns = new LinkedList<String>();

	protected String selectCriteria;
	protected String fromCriteria;
	protected String whereCriteria;
	protected String searchFilterCriteria;
	protected String paginationCriteria;
	protected String orderCriteria;

	@PersistenceContext
	protected EntityManager entityManager;

	protected abstract void initializeTableColumns();

	protected abstract void setSelectCriteria();

	protected abstract void setFromCriteria();

	protected abstract List<List<String>> getQueryResults();

	protected void setWhereCriteria() {
		whereCriteria = "";
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

			searchFilter.append(tableColumn + " Like '%" + searchValue + "%'");
			if (length != tableColumns.size()) {
				searchFilter.append(" OR ");
			}
			length++;
		}

		searchFilter.append(" ) ");

		searchFilterCriteria = searchFilter.toString();

	}

	protected void setPaginationCriteria() {
		paginationCriteria = " Limit " + start + " , " + length;
	}

	protected void setOrderCriteria() {
		if (orderableMap == null || orderableMap.isEmpty()) {
			orderCriteria = "";
			return;
		}

		StringBuffer orderby = new StringBuffer();
		orderby.append(" ORDER BY ");
		int length = 1;
		for (Map.Entry<Integer, String> entry : orderableMap.entrySet()) {

			orderby.append(tableColumns.get(entry.getKey()));
			orderby.append(" " + entry.getValue());
			if (length < orderableMap.size()) {
				orderby.append(" , ");
			}
		}

		orderCriteria = orderby.toString();
	}

	public void intialize(String dataTableRequest) {
		initializeTableData(dataTableRequest);
		initializeTableColumns();
		intializeCriterias();
	}

	protected void initializeTableData(String dataTableRequest) {

		if (dataTableRequest == null || dataTableRequest.isEmpty()) {
			setDefaultTableData();
			return;
		}

		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode rootNode = mapper.readTree(new StringReader(dataTableRequest));
			draw = rootNode.get("draw").asInt();
			start = rootNode.get("start").asInt();
			length = rootNode.get("length").asInt();
			searchValue = rootNode.get("search").get("value").asText();

			JsonNode orderNodes = rootNode.get("order");
			orderableMap = new LinkedHashMap<Integer, String>();
			for (JsonNode orderNode : orderNodes) {
				orderableMap.put(orderNode.get("column").asInt(), orderNode.get("dir").asText());
			}
		} catch (Exception e) {
			e.printStackTrace();
			setDefaultTableData();
		}

	}

	protected void setDefaultTableData() {
		draw = 1;
		start = 0;
		length = 10;
		searchValue = "";
		orderableMap = new LinkedHashMap<Integer, String>();
	}

	protected void intializeCriterias() {
		setSelectCriteria();
		setFromCriteria();
		setWhereCriteria();
		setSearchFilterCriteria();
		setOrderCriteria();
		setPaginationCriteria();
	}

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

	protected BigInteger getTotalRecords() {

		StringBuffer query = new StringBuffer();
		query.append(" Select count(id) ");
		query.append(fromCriteria);
		query.append(whereCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();

	}
	
	protected BigInteger getTotalFilteredRecords() {
		StringBuffer query = new StringBuffer();
		query.append(" Select count(id) ");
		query.append(fromCriteria);
		query.append(whereCriteria);
		query.append(searchFilterCriteria);

		return (BigInteger) entityManager.createNativeQuery(query.toString()).getSingleResult();
	}

	public String getTableData() throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> tableData = new LinkedHashMap<String, Object>();

		tableData.put("recordsFiltered", getTotalFilteredRecords());
		tableData.put("recordsTotal", getTotalRecords());

		tableData.put("data", getQueryResults());
		tableData.put("draw", draw);

		return mapper.writeValueAsString(tableData);
	}
	
	protected String formatDate(Object object) {
		
		DateFormat df = new SimpleDateFormat("YYYY-MM-dd");
		if (object == null) {
			return "";
		}

		if (!(object instanceof Date)) {
			return "";
		}

		Date date = (Date) object;
		return df.format(date);

	}
}
