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
		List<Object[]> rentees = query.getResultList();
		for (Object[] rentee : rentees) {

			List<String> data = new LinkedList<String>();

			data.add(String.valueOf(rentee[1]));
			data.add(String.valueOf(rentee[2]));
			data.add(String.valueOf(rentee[3]));
			data.add(String.valueOf(rentee[4]));
			data.add(String.valueOf(rentee[5]));
			data.add(String.valueOf(formatDate(rentee[6])));
			data.add(String.valueOf(rentee[7]));
			data.add(String.valueOf(rentee[8]));
			data.add(String.valueOf(rentee[9]));

			data.add(getActionButtons(String.valueOf(rentee[0])));

			tableData.add(data);
		}

		return tableData;

	}

	protected String getActionButtons(String renteeId) {
		StringBuffer actionButtons = new StringBuffer();
		actionButtons.append(getEditRenteeAction(renteeId));
		actionButtons.append(" ");
		actionButtons.append(getRenteeDetailsAction(renteeId));
		return actionButtons.toString();
	}

	protected String getEditRenteeAction(String renteeId) {
		StringBuffer editRentee = new StringBuffer();
		editRentee.append("<i class='actionButton editRentee fas fa-edit fa-lg' rentee='" + renteeId
				+ "' title='edit' style = 'color:#3559BA'> </i>");
		return editRentee.toString();
	}
	
	protected String getRenteeDetailsAction(String renteeId) {
		StringBuffer renteeDetails = new StringBuffer();
		renteeDetails.append("<i class='actionButton details fas fa-info-circle fa-lg' rentee='" + renteeId
				+ "' title='details' style = 'color:#666666'> </i>");
		return renteeDetails.toString();
	}

}
