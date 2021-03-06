﻿var editImageIsDirty = false;
var fileList = [];

function editImageDirty() {
	editImageIsDirty = true;
}

function populateAddNewImage(albumObj) {
	$('#editAddNewImage').off('#editAddNewImage').click(function() {

	});
}

function populateManageImages(albumObj) {
	$('#editAddNewImage').off('#editAddNewImage').click(function () {

	});
}

$(document).ready(function () {
	var table;
	var editData;


	$('#customFile').change(function (evnt) {
		var fileInput = document.getElementById('customFile').files;
		fileList = [];
		$('#viewAddingItems').empty();

		for (var i = 0; i < fileInput.length; i++) {
			fileList.push(fileInput[i]);
			var row = $(document.createElement('div'))
				.addClass('form-row');
			var alertItem = $(document.createElement('div'))
				.attr('id', 'alert-upload-file-' + i)
				.addClass('alert alert-secondary w-100')
				.attr('role', 'alert')
				.text(fileInput[i].name);

			row.append(alertItem);
			$('#viewAddingItems').append(row);

		}
	});

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

	// This fuction builds the DataTable. Because locations only store watershedIDs we must make a mapping of the watershed IDs to Names
	function initDataTable() {
		table = $('#DataTable').DataTable({
			ajax: {
				// The location to HTTP GET the data for the table
				url: '../../api.asmx/AllAlbum',
				dataSrc: ''
			},
			order: [[0, "asc"]],
			columns: [
				{
					data: "Name",
					width: "20%"
				},
				{
					data: "Description",
					width: "65%"
				},
				{
					data: null,
					render: RenderActions,
					orderable: false,
					width: '15%'
				}
			]
		});
	}

	$('#createAlbum').click(function () {
		$('#inputCreateName').val('');
		$('#inputCreateDescription').val('');
		$('#createModal').modal('show');
	});

	$('#createSubmit').click(function () {		
		if ($("#inputCreateName").val() != "" &&
			$("#inputCreateDescription").val() != "" &&
			$("#inputCreateImageBrowse").val() != "")
		{
			var fileUpload = $('#inputCreateImageBrowse').get(0);
			var files = fileUpload.files;

			var formData = new FormData();

			for (var i = 0; i < files.length; i++) {
				formData.append(files[i].name, files[i]);
			}

			formData.append('filename', $('#inputCreateImageBrowse')[0].files[0].name);
			formData.append('file', $('#inputCreateImageBrowse')[0].files[0]);

			// Save the image, get the new image ID THEN save the location w/ the image ID info
			$.ajax({
				type: "POST",
				url: "../../images/set.ashx",
				contentType: false,
				processData: false,
				data: formData,
				success: function (dataResponse) {
					console.log("Image created with ID: " + dataResponse);

					var requestData = {
						Name: $('#inputCreateName').val(),
						Description: $('#inputCreateDescription').val(),
						ImageID: dataResponse
					};

					// Save the location data
					$.ajax({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: '../../api.asmx/CreateAlbum',
						data: JSON.stringify(requestData),
						dataType: 'JSON',
						success: function (responseData) {
							console.log('Album Creation Successful');
							console.log(requestData);

							$('#createModal').modal('hide');
							table.ajax.reload();
						},
						error: function (errorData) {
							console.log('Error Saving Album Data');
							console.log(errorData);
						}
					});
				},
				error: function (errorData) {
					console.log('Error Saving Image');
				}
			});
		}
	});

	$('#createModal').on('hidden.bs.modal', function (e) {


	});

	$('#editModal').on('hidden.bs.modal', function (e) {

	});


	// initialize the DataTable
	initDataTable();

	// This function returns the HTML for the 'Action' buttons for each row in the DataTable
	function RenderActions(data, type, row, meta) {
		// Create a div to hold the buttons
		var buttonRow = $(document.createElement('div'))
			.addClass('row');

		// Create the 'Edit' and 'Archive' buttons using the data from the row
		var buttonEdit = EditBtn(row.AlbumID);
		var buttonView = ViewBtn(row.AlbumID);

		// Create div wrapper to place buttons inside
		var wrapper1 = $(document.createElement('div'))
			.addClass('col-6 float-right')
			.append(buttonEdit);

		var wrapper2 = $(document.createElement('div'))
			.addClass('col-6 float-left')
			.append(buttonView);

		buttonRow.append(wrapper2);
		buttonRow.append(wrapper1);

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
			.attr('id', 'btnAlbumEdit' + id)
			.attr('type', 'button')
			.addClass('editButton')
			.addClass('btn-info')
			.addClass('btn-block')
			.append(icon);

		return button;
	}

	function ViewBtn(id) {
		var button = $(document.createElement('button'));
		var icon = $(document.createElement('i'));

		icon.addClass('far')
			.addClass('fa-image');

		button.addClass('btn')
			.attr('id', 'btnAlbumView' + id)
			.attr('type', 'button')
			.addClass('viewButton')
			.addClass('btn-warning')
			.addClass('btn-block')
			.append(icon);

		return button;
	}

	// This function fills out the data in the 'Create Modal' before displaying it
	function PopulateCreateModal() {

	}

	$('#inputCreateImageBrowse').change(function() {
		var filename = $('#inputCreateImageBrowse')[0].files[0].name;
		$('#lblCreateImageFile').html(filename);
	});

	// This function fills out the fields in the 'Edit Modal' before displaying it
	function PopulateEditModal(data) {
		console.log(data);

		$("#inputEditName").prop("readonly", data.IsLocationAlbum);

		$('#inputEditName').val(data.Name);
		$('#inputEditDescription').val(data.Description);

		$('#editSubmit').off().click(function () {

			//TODO: validation check of EDIT modal fields
			if ($("#inputEditName").val() != "" &&
				$("#inputEditDescription").val() != "")
			{
				var requestData = {
					AlbumID: data.AlbumID,
					Name: $('#inputEditName').val(),
					Description: $('#inputEditDescription').val()
				};

				$.ajax({
					type: 'POST',
					contentType: 'application/json; charset=utf-8',
					url: '../../api.asmx/UpdateAlbum',
					data: JSON.stringify(requestData),
					dataType: 'JSON',
					success: function (responseData) {
						console.log('Edit Successful');
						console.log(responseData);

						table.ajax.reload();
						$('#editModal').modal('hide');
					},
					error: function (errorData) {
						console.log('ERROR');
						console.log(errorData);
					}
				});
			}
		});
	}

	function isPrimaryImageSelected() {
		var selectedImageName = $('#viewImageSelect option:selected').text();
		var primaryPrefix = '(P) ';

		return selectedImageName.substring(0, 4) == primaryPrefix;
	}

	$('#viewImageSelect').on('change',
		function () {
			var imageId = $('#viewImageSelect').val();
			$('#viewSelectedImage').attr('src', '../../images/get.ashx?id=' + imageId);

			console.log('Image "' + imageId + '" Selected');
			
			if (isPrimaryImageSelected()) {
				$('#deleteSubmit').prop('disabled', true);
				$('#makePrimarySubmit').prop('disabled', true);
			} else {
				$('#deleteSubmit').prop('disabled', false);
				$('#makePrimarySubmit').prop('disabled', false);
			}
		});

	$('#deleteSubmit').on('click',
		function() {
			var imageId = $('#viewImageSelect').val();

			if (!isPrimaryImageSelected()) {
				var requestData = { imageId: imageId };

				$.ajax({
					type: 'POST',
					contentType: 'application/json; charset=utf-8',
					url: '../../api.asmx/DeleteImageById',
					data: JSON.stringify(requestData),
					dataType: 'JSON',
					success: function (responseData) {
						console.log('Deleted Image ' + imageId);

						$('#viewModal').modal('hide');
					},
					error: function (errorData) {
						console.log('ERROR');
						console.log(errorData);
					}
				});
			}
		});



	function PopulateViewModal(data) {
		$('.viewAddNewItem').hide();
		$('.viewManageItem').show();
		$('#viewAddNewImage a').removeClass('active');
		$('#viewManageImages a').addClass('active');
		$('#viewImageSelect').empty();
		$('#viewSelectedImage').attr('src', '');


		fileList = [];

		$('#viewAddNewImage').off('#editAddNewImage').click(function () {
			$('#viewAddNewImage a').addClass('active');
			$('#viewManageImages a').removeClass('active');

			$('.viewAddNewItem').show();
			$('.viewManageItem').hide();
		});

		$('#viewManageImages').off('#editManageImages').click(function () {
			$('#viewAddNewImage a').removeClass('active');
			$('#viewManageImages a').addClass('active');

			$('.viewAddNewItem').hide();
			$('.viewManageItem').show();
		});

		$.get('../../api.asmx/GetAlbumProfileImageDetails?albumid=' + data.AlbumID).done(function (responseProfileImage) {
			var profileImage = responseProfileImage;

			$.get('../../api.asmx/GetAlbumImagesDetails?albumid=' + data.AlbumID).done(function(responseAlbumImages) {

				console.log(responseAlbumImages);
				var selector = $('#viewImageSelect');

				responseAlbumImages.forEach(function(image) {
					var newElement = $(document.createElement('option'));
					newElement.attr('value', image.ImageID);

					if (image.ImageID == profileImage.ImageID) {
						newElement.text('(P) ' + image.Filename);
					} else {
						newElement.text(image.Filename);
					}
					
					selector.append(newElement);
				});

				selector.val(profileImage.ImageID).change();

			}).always(function(response) {
				//Display the modal
				$('#viewModal').modal('show');
			});
		});

		$('#makePrimarySubmit').off().on('click',
			function () {
				var imageId = $('#viewImageSelect').val();

				if (!isPrimaryImageSelected()) {

					var requestData = { imageId: imageId, albumId: data.AlbumID };

					$.ajax({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: '../../api.asmx/SetImageIDAsAlbumProfileImageID',
						data: JSON.stringify(requestData),
						dataType: 'JSON',
						success: function (responseData) {
							console.log('Edit Successful');
							console.log(responseData);

							$('#viewModal').modal('hide');
						},
						error: function (errorData) {
							console.log('ERROR');
							console.log(errorData);
						}
					});
				}
			});

		$('#addNewSubmit').off().click(function () {

			fileList.forEach(function (file) {
				var formData = new FormData();
				
				formData.append('file', file);
				formData.append('filename', file.name);
				console.log(formData);

				var requestParams = {
					url: '../../images/album/add.ashx?id=' + data.AlbumID,
					data: formData,
					contentType: false,
					success: function() {
						console.log("Success Uploading " + file.name);
					},
					processData: false
				}

				$.post(requestParams).done(function() {
					$('#viewModal').modal('hide');
					$('#viewAddingItems').empty();
				});


			});
		});
	}

	// The function when the 'Create New Watershed' button gets clicked
	$('#createLocation').click(function () {
		//Populate the Create Modal
		PopulateCreateModal();

		//Display the modal
		$('#createModal').modal('show');
	});


	$('#DataTable').on('click', '.viewButton', function () {
		//Get Data for the the row
		viewData = table.row($(this).parents('tr')).data();
		$('#imageView').attr("src", "");

		//Put the data in the Edit Modal
		PopulateViewModal(viewData);

		$('#viewSubmit').prop("onclick", null);
	});

});