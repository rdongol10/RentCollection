package com.rdongol.rentcollection.service.datatable;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("renteeListDataTableBackend")
public class RenteeListDataTableBackend extends AbstractDataTableBackend {

	@Override
	protected void initializeTableColumns() {
		tableColumns.add("first_name");
		tableColumns.add("last_name");
		tableColumns.add("middle_name");
		tableColumns.add("address");
		tableColumns.add("sex");
		tableColumns.add("dob");
		tableColumns.add("citizenship_number");
		tableColumns.add("phone_number");
		tableColumns.add("email_id");

	}

	@Override
	protected void setSelectCriteria() {
		selectCriteria = " Select id ,first_name, last_name, middle_name, address, sex, dob, citizenship_number, phone_number, email_id ";
	}

	@Override
	protected void setFromCriteria() {
		fromCriteria = " From RENTEE ";

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
			data.add(String.valueOf(renting[7]));
			data.add(String.valueOf(renting[8]));
			data.add(String.valueOf(renting[9]));

			data.add(getActionButtons(String.valueOf(renting[0])));

			tableData.add(data);
		}

		return tableData;

	}

	protected String getActionButtons(String rentingId) {
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getEditRengingAction(rentingId));
		return actionButtons.toString();
	}

	protected String getEditRengingAction(String renteeId) {
		StringBuffer editRenting = new StringBuffer();
		editRenting.append("<i class='actionButton editRentee fas fa-edit' rentee='" + renteeId
				+ "' title='edit' style = 'color:blue'> </i>");
		return editRenting.toString();
	}

}
