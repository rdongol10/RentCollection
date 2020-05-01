package com.rdongol.rentcollection.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rdongol.rentcollection.model.Renting;
import com.rdongol.rentcollection.model.RentingContractModel;
import com.rdongol.rentcollection.model.RentingDisplayModal;
import com.rdongol.rentcollection.model.RentingModel;
import com.rdongol.rentcollection.service.ImageService;
import com.rdongol.rentcollection.service.RentingService;
import com.rdongol.rentcollection.service.datatable.AbstractDataTableBackend;

@RestController
@RequestMapping("/renting")
public class RentingController {

	@Autowired
	private RentingService rentingService;

	@Autowired
	private ImageService imageService;

	@Autowired
	@Qualifier("rentingListDataTableBackend")
	private AbstractDataTableBackend rentingListDataTableBackend;

	@PostMapping
	public ResponseEntity<Renting> create(@RequestBody RentingModel rentingModel) throws Exception {

		Renting renting = rentingService.save(rentingModel);
		imageService.save(renting.getId(), "RENTING", rentingModel.getImageBase64s());

		return ResponseEntity.ok(renting);

	}

	@PutMapping("/{id}")
	public ResponseEntity<Renting> update(@PathVariable long id, @RequestBody RentingModel rentingModel)
			throws Exception {

		Renting renting = rentingService.update(id, rentingModel);
		imageService.deleteImages(renting.getId(), "RENTING");
		imageService.save(renting.getId(), "RENTING", rentingModel.getImageBase64s());
		return ResponseEntity.ok(renting);
	}

	@PostMapping("/listRentings")
	public String listRentings(@RequestBody String dataTableRequest) throws Exception {
		rentingListDataTableBackend.intialize(dataTableRequest);
		return rentingListDataTableBackend.getTableData();
	}

	@PutMapping("/toggleStatus/{id}")
	public int toggleStatus(@PathVariable long id) {
		return rentingService.toggleStatus(id);
	}

	@GetMapping("/rentingExists/{name}")
	public String doesRentingExists(@PathVariable String name) {

		if (rentingService.existsRentingByName(name)) {
			return "true";
		}

		return "false";
	}

	@GetMapping("/getRentingModel/{id}")
	public ResponseEntity<RentingModel> getRengingModel(@PathVariable long id) {

		return ResponseEntity.ok(rentingService.getRentingModel(id));

	}

	@GetMapping("/getAvailableRentings")
	public ResponseEntity<List<RentingContractModel>> getAvailableRentings() {
		return ResponseEntity.ok(rentingService.getAvailableRentingContractModels());
	}

	@GetMapping("/getRentingDetails/{id}")
	public ResponseEntity<RentingDisplayModal> getRentingDetails(@PathVariable long id) {
		return ResponseEntity.ok(rentingService.getRentingDetails(id));
	}

}
