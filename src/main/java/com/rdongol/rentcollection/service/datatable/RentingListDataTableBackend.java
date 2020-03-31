package com.rdongol.rentcollection.service.datatable;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("rentingListDataTableBackend")
public class RentingListDataTableBackend extends AbstractDataTableBackend {

	@Override
	protected void initializeTableColumns() {
		tableColumns.add("name");
		tableColumns.add("type");
		tableColumns.add("number_of_rooms");
		tableColumns.add("price");
		tableColumns.add("status");
	}

	@Override
	protected void setSelectCriteria() {
		selectCriteria = " Select id,name,type,number_of_rooms,price,status ";

	}

	@Override
	protected void setFromCriteria() {
		fromCriteria = " From RENTING ";

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
			data.add(getActionButtons(String.valueOf(renting[0]), Integer.valueOf(renting[5].toString())));

			tableData.add(data);
		}
		
		return tableData;

	}

	protected String getActionButtons(String rentingId , int active ) {
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getEditRengingAction(rentingId));
		actionButtons.append(" ");
		actionButtons.append(getDeleteRentingAction(rentingId,active));
		return actionButtons.toString();
	}

	protected String getEditRengingAction(String rentingId) {
		StringBuffer editRenting = new StringBuffer();
		editRenting.append("<i class='actionButton editRenting fas fa-edit' rentingId='" + rentingId + "' title='edit' style = 'color:blue'> </i>");
		return editRenting.toString();
	}

	protected String getDeleteRentingAction(String rentingId, int active) {

		StringBuffer deleteService = new StringBuffer();
		if(active ==1 ) {
			deleteService.append("<i class='actionButton toggleRenting fas fa-toggle-off' rentingId='" + rentingId+ "' title='disable' style = 'color:red'></i>");
		}else {
			deleteService.append("<i class='actionButton toggleRenting fas fa-toggle-on' rentingId='" + rentingId+ "' title='enable' style = 'color:green'></i>");
		}
		return deleteService.toString();
	}

}
