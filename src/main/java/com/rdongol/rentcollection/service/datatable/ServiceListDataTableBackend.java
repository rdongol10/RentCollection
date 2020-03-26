package com.rdongol.rentcollection.service.datatable;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("serviceListDataTableBackend")
public class ServiceListDataTableBackend extends AbstractDataTableBackend {

	@Override
	protected void initializeTableColumns() {
		tableColumns.add("name");
		tableColumns.add("minimum_charge");
		tableColumns.add("charge");
		tableColumns.add("type");
		tableColumns.add("active");
	}

	@Override
	protected void setSelectCriteria() {
		selectCriteria = " Select id,name,minimum_charge,charge,type,active ";

	}

	@Override
	protected void setFromCriteria() {
		fromCriteria = " From SERVICE ";
	}

	@Override
	protected List<List<String>> getQueryResults() {
		List<List<String>> tableData = new LinkedList<List<String>>();
		Query query = entityManager.createNativeQuery(getQuery());
		List<Object[]> services = query.getResultList();
		for (Object[] service : services) {

			List<String> data = new LinkedList<String>();

			data.add(String.valueOf(service[1]));
			data.add(String.valueOf(service[2]));
			data.add(String.valueOf(service[3]));
			data.add(String.valueOf(service[4]));
			data.add(Integer.valueOf(service[5].toString()) == 1 ? "Active" : "Inactive");
			data.add(getActionButtons(String.valueOf(service[0])));

			tableData.add(data);
		}

		return tableData;
	}

	protected String getActionButtons(String serviceId) {
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getEditServiceAction(serviceId));
		actionButtons.append(" ");
		actionButtons.append(getDeleteServiceAction(serviceId));
		return actionButtons.toString();
	}

	protected String getEditServiceAction(String serviceId) {
		StringBuffer editUser = new StringBuffer();
		editUser.append("<i class='actionButton editService fas fa-edit' serviceId='" + serviceId
				+ "' style = 'color:blue'> </i>");
		return editUser.toString();
	}

	protected String getDeleteServiceAction(String serviceId) {

		StringBuffer deleteUser = new StringBuffer();
		deleteUser.append("<i class='actionButton deleteUser fas fa-trash-alt' serviceId='" + serviceId
				+ "' style = 'color:red'></i>");
		return deleteUser.toString();
	}

}
