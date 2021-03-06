﻿var editImageIsDirty = false;

function editImageDirty() {
	editImageIsDirty = true;
}

$(document).ready(function () {
	var table;
	var editData;

	// This fuction builds the DataTable. Because locations only store watershedIDs we must make a mapping of the watershed IDs to Names
	function initDataTable() {

		var watershedMap = new Map();

		// Get all the watershed names and map them with thier IDs THEN build the datatable
		$.ajax({
			type: 'GET',
			contentType: 'application/json; charset=utf-8',
			url: '../../api.asmx/ReadAllWatersheds',
			dataType: 'JSON'
		}).done(function (responseData) {

			responseData.forEach(function (watershed) {
				watershedMap.set(watershed.WatershedID, watershed.WatershedName);
			});

			// Build the DataTable
			table = $('#DataTable').DataTable({
				ajax: {
					// The location to HTTP GET the data for the table
					url: '../../api.asmx/ReadAllLocation',
					dataSrc: ''
				},
				order: [[1, "asc"]],
				columns: [
					// The 'Name' column of the table's data
					{ data: 'SensorName' },
					// This function is used to get and display the 'WatershedName' in the table. Because locations only store watershed ID, it must be looked up
					{
						data: null,
						render: function (data, type, row, meta) {
							return watershedMap.get(data.WatershedID);
						}
					},
					{ data: 'Latitude' },
					{ data: 'Longitude' },
					// The 'Action' column of the table
					{
						data: null,
						orderable: false,
						width: '10%',
						render: RenderActions
					}
				]
			});

		});
	}

	$('#inputCreateImageBrowse').change(function () {
		var filename = $('#inputCreateImageBrowse')[0].files[0].name;
		$('#lblInputCreateImageBrowse').html(filename);
	});

	function BuildCreateLocation() {
		var Name = $('#inputCreateName').val();
		var WatershedId = $('#selectCreateWatershed').val();
		var Latitude = $('#inputCreateLatitude').val();
		var Longitude = $('#inputCreateLongitude').val();

		return {
			name: Name,
			watershedId: WatershedId,
			latitude: Latitude,
			longitude: Longitude
		}
	}

	function BuildEditLocation(id) {
		var LocationId = id;
		var Name = $('#inputEditName').val();
		var WatershedId = $('#selectEditWatershed').val();
		var Latitude = $('#inputEditLatitude').val();
		var Longitude = $('#inputEditLongitude').val();
		var ImageId = $('#imageEditID').val();

		return {
			id: LocationId,
			name: Name,
			watershedId: WatershedId,
			latitude: Latitude,
			longitude: Longitude,
			imageId: ImageId
		}
	}

	$('#createModal').on('hidden.bs.modal', function (e) {
		$('.inputname').removeClass('is-invalid');
		$('.inputname').removeClass('is-valid');

		$('.inputlatitude').removeClass('is-invalid');
		$('.inputlatitude').removeClass('is-valid');

		$('.inputlongitude').removeClass('is-invalid');
		$('.inputlongitude').removeClass('is-valid');

		$('.selectwatershed').removeClass('is-invalid');
		$('.selectwatershed').removeClass('is-valid');

	});

	$('#editModal').on('hidden.bs.modal', function (e) {
		$('.inputname').removeClass('is-invalid');
		$('.inputname').removeClass('is-valid');

		$('.inputlatitude').removeClass('is-invalid');
		$('.inputlatitude').removeClass('is-valid');

		$('.inputlongitude').removeClass('is-invalid');
		$('.inputlongitude').removeClass('is-valid');

		$('.selectwatershed').removeClass('is-invalid');
		$('.selectwatershed').removeClass('is-valid');

	});

	function ValidateLocationRequest(dataRequest) {
		var feedback;

		$('.inputname').removeClass('is-invalid');
		$('.inputlatitude').removeClass('is-invalid');
		$('.inputlongitude').removeClass('is-invalid');

		var regexName = /^[\w ]+$/;
		var regexGPS = /^-?\d+\.\d+\,\s?-?\d+\.\d+$/;

		hasValidName = regexName.test(dataRequest.name);
		hasValidLatitude = (!isNaN(dataRequest.latitude) && dataRequest.latitude <= 90 && dataRequest.latitude >= -90 && dataRequest.latitude != "");
		hasValidLongitude = (!isNaN(dataRequest.longitude) && dataRequest.longitude <= 90 && dataRequest.longitude >= -90 && dataRequest.longitude != "");

		console.log("Valid Name: " + hasValidName);
		console.log("Valid Latitude: " + hasValidLatitude);
		console.log("Valid Longitude: " + hasValidLongitude);

		if (hasValidName) {
			$('.inputname').addClass('is-valid');
		} else {
			$('.inputname').addClass('is-invalid');
		}

		if (hasValidLatitude) {
			$('.inputlatitude').addClass('is-valid');
		} else {
			$('.inputlatitude').addClass('is-invalid');
		}

		if (hasValidLongitude) {
			$('.inputlongitude').addClass('is-valid');
		} else {
			$('.inputlongitude').addClass('is-invalid');
		}

		$('.selectwatershed').addClass('is-valid');


		return (hasValidName && hasValidLatitude && hasValidLongitude);
	}

	// initialize the DataTable
	initDataTable();

	// This function returns the HTML for the 'Action' buttons for each row in the DataTable
	function RenderActions(data, type, row, meta) {
		// Create a div to hold the buttons
		var buttonRow = $(document.createElement('div'))
			.addClass('row');

		// Create the 'Edit' and 'Archive' buttons using the data from the row
		var buttonEdit = EditBtn(row.LocationID);

		// Create div wrapper to place buttons inside
		var wrapper = $(document.createElement('div'))
			.addClass('col-12')
			.append(buttonEdit);

		buttonRow.append(wrapper);

		// Return the HTML that makes up the row > (column > button > icon)*2
		return buttonRow.prop('outerHTML');
	}

	// This function takes an ID and returns a 'Edit' button; The ID is used to make the id attribute
	function EditBtn(id) {
		var button = $(document.createElement('button'));
		var icon = $(document.createElement('i'));

		icon.addClass('far')
			.addClass('fa-edit');

		button.addClass('btn')
			.attr('id', 'btnLocationEdit' + id)
			.attr('type', 'button')
			.addClass('editButton')
			.addClass('btn-info')
			.addClass('btn-block')
			.append(icon);

		return button;
	}

	// This function fills out the select element in the Create modal
	function PopulateCreateWatershedSelect() {
		$('#selectCreateWatershed').empty();

		$.ajax({
			type: 'GET',
			contentType: 'application/json; charset=utf-8',
			url: '../../api.asmx/ReadAllWatersheds',
			dataType: 'JSON',
			success: function (responseData) {

				responseData.forEach(function (watershed) {
					var id = watershed.WatershedID;
					var name = watershed.WatershedName;
					var option = $(document.createElement('option'));

					option.attr('value', id).text(name);

					$('#selectCreateWatershed').append(option);
				});

			},
			error: function (errorData) {
				console.log('ERROR');
				console.log(errorData);
			}
		});
	}

	// This function fills out the select element in the Edit modal and auto selects the correct watershed from the dropdown
	function PopulateEditWatershedSelect(watershedId) {
		$('#selectEditWatershed').empty();

		$.ajax({
			type: 'GET',
			contentType: 'application/json; charset=utf-8',
			url: '../../api.asmx/ReadAllWatersheds',
			dataType: 'JSON',
			success: function (responseData) {

				responseData.forEach(function (watershed) {
					var id = watershed.WatershedID;
					var name = watershed.WatershedName;
					var option = $(document.createElement('option'));

					option.attr('value', id).text(name);

					if (id == watershedId) {
						option.attr('selected', 'selected');
					}

					$('#selectEditWatershed').append(option);
				});

			},
			error: function (errorData) {
				console.log('ERROR');
				console.log(errorData);
			}
		});
	}

	// This function fills out the data in the 'Create Modal' before displaying it
	function PopulateCreateModal() {
		$('#inputCreateName').val('');
		$('#inputCreateLatitude').val('');
		$('#inputCreateLongitude').val('');
		$('#inputCreateImageBrowse').val('');

		PopulateCreateWatershedSelect();
	}


	// This function fills out the fields in the 'Edit Modal' before displaying it
	function PopulateEditModal(data) {
		editImageIsDirty = false;
		$('#inputEditName').val(data.SensorName);
		$('#inputEditLatitude').val(data.Latitude);
		$('#inputEditLongitude').val(data.Longitude);
		$('#inputEditImageBrowse').val('');
		$('#imageEdit').attr("src", "../../images/location/get.ashx?locationid=" + data.LocationID + "&cache=" + Date.now());
		$('#imageEditID').val(data.ProfileImageID);

		PopulateEditWatershedSelect(data.WatershedID);
	}

	// The function when the 'Create New Watershed' button gets clicked
	$('#createLocation').click(function () {
		//Populate the Create Modal
		PopulateCreateModal();

		//Display the modal
		$('#createModal').modal('show');
	});



	// The function when the any 'Edit' button in the DataTable gets clicked
	$('#DataTable').on('click', '.editButton', function () {
		//Get Data for the the row
		editData = table.row($(this).parents('tr')).data();
		$('#imageEdit').attr("src", "");

		//Put the data in the Edit Modal
		PopulateEditModal(editData);

		//Display the modal
		$('#editModal').modal('show');

		$('#editSubmit').prop("onclick", null);


	});

	$('#editSubmit').click(function () {
		var requestData = BuildEditLocation(editData.LocationID);

		var isValidRequest = ValidateLocationRequest(requestData);
		console.log('Is Edit Form Submission Valid?: ' + isValidRequest);
		if (!isValidRequest) return;

		$.ajax({
			type: 'POST',
			contentType: 'application/json; charset=utf-8',
			url: '../../api.asmx/UpdateLocation',
			data: JSON.stringify(requestData),
			dataType: 'JSON',
			success: function (responseData) {
				console.log('Edit Successful');
				console.log(responseData);

				$('#editModal').modal('hide');
				table.ajax.reload();
			},
			error: function (errorData) {
				console.log('ERROR');
				console.log(errorData);
			}
		});

	});



	// This function runs when the 'Create Modal' gets submitted
	$('#createSubmit').click(function () {
		var requestData = BuildCreateLocation();
		console.log(requestData);
		var isValidRequest = ValidateLocationRequest(requestData);
		console.log('Is Create Form Text Submission Valid?: ' + isValidRequest);
		if (!isValidRequest) return;

		var fileUpload = $('#inputCreateImageBrowse').get(0);
		var files = fileUpload.files;

		var formData = new FormData();

		for (var i = 0; i < files.length; i++) {
			formData.append(files[i].name, files[i]);
		}

		formData.append('filename', requestData.name);
		formData.append('file', $('#inputCreateImageBrowse')[0].files[0]);

		// Save the image, get the new image ID THEN save the location w/ the image ID info
		$.ajax({
			type: "POST",
			url: "../../images/location/set.ashx",
			contentType: false,
			processData: false,
			data: formData,
			success: function (dataResponse) {
				console.log("Image created with ID: " + dataResponse);

				// Add the image ID to the new location data
				Object.assign(requestData, { imageId: dataResponse });

				// Save the location data
				$.ajax({
					type: 'POST',
					contentType: 'application/json; charset=utf-8',
					url: '../../api.asmx/CreateLocation',
					data: JSON.stringify(requestData),
					dataType: 'JSON',
					success: function (responseData) {
						console.log('Location Creation Successful');
						console.log(requestData);

						$('#createModal').modal('hide');
						table.ajax.reload();
					},
					error: function (errorData) {
						console.log('Error Saving Location Data');
						console.log(errorData);
					}
				});
			},
			error: function (errorData) {
				console.log('Error Saving Image');
			}
		});
	});

});