﻿<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.gallery" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Manage Gallery   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!-- CSS  -->
    <link rel="stylesheet" href="../../style/custom/administration-gallery.css" />
        

    <div class="row mb-4">
        <div class="col-12">
            <button type="button" id="createLocation" class="btn btn-success float-left">
                <i class="fa fa-plus">&nbsp; Create New Location</i>
            </button>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-12">
            <table class="table table-striped table-hover table-bordered" style="width: 100%;" id="DataTable">
                <thead>
                <tr>
                    <th></th>
                    <th scope="col">Name</th>
                    <th scope="col">Description</th>
                    <th scope="col"></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    
    
    
    
    <!-- Create Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="createModalLabel">Create Location</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-row">
                  <div class="form-group col-12">
                        <label for="inputCreateName">Name</label>
                        <input type="text" class="form-control inputname" id="inputCreateName">
                        <div class="invalid-feedback">
                            Location Name must be ...
                        </div>
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-12">
                    <label for="selectCreateWatershed">Watershed</label>
                    <select id="selectCreateWatershed" class="form-control selectwatershed">
                    </select>
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-6">
                      <label for="inputCreateLatitude">Latitude</label>
                      <input type="text" class="form-control inputlatitude" id="inputCreateLatitude">
                    <div class="invalid-feedback">
                        Latitude must be ...
                    </div>
                  </div>
                  <div class="form-group col-6">
                      <label for="inputCreateLongitude">Longitude</label>
                      <input type="text" class="form-control inputlongitude" id="inputCreateLongitude">
                    <div class="invalid-feedback">
                        Longitude must be ...
                    </div>
                  </div>
              </div>
              <div class="row">
                  <div class="form-group col-12">
                      <input type="file" value="Browse" id="inputCreateImageBrowse" />
                  </div>
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="createClose">Close</button>
            <button type="button" class="btn btn-success" id="createSubmit">Create</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="editModalLabel">Edit Location</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-row">
                  <div class="form-group col-12">
                        <label for="inputEditName">Name</label>
                        <input type="text" class="form-control inputname" id="inputEditName" required>
                        <div class="invalid-feedback">
                            Location Name must be ...
                        </div>
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-12">
                    <label for="selectEditWatershed">Watershed</label>
                    <select id="selectEditWatershed" class="form-control selectwatershed" required>
                    </select>
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-6">
                      <label for="inputEditLatitude">Latitude</label>
                      <input type="text" class="form-control inputlatitude" id="inputEditLatitude" required>
                    <div class="invalid-feedback">
                        Latitude must be ...
                    </div>
                  </div>
                  <div class="form-group col-6">
                      <label for="inputEditLongitude">Longitude</label>
                      <input type="text" class="form-control inputlongitude" id="inputEditLongitude" required>
                    <div class="invalid-feedback">
                        Longitude must be ...
                    </div>
                  </div>
              </div>
              <div class="row text-center">
                  <div class="form-group col-12">
                      <span id="imageEditID" class="invisible"></span>
                      <img id="imageEdit" width="200" height="200" />
                  </div>
              </div>
              <div class="row">
                  <div class="form-group col-12">
                      <input type="file" value="Browse" id="inputEditImageBrowse" onchange="editImageDirty()"/>
                  </div>
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="editClose">Close</button>
            <button type="button" class="btn btn-info" id="editSubmit">Save changes</button>
          </div>
        </div>
      </div>
    </div>
    
    

    <script>
        var editImageIsDirty = false;

        function editImageDirty() {
            editImageIsDirty = true;
        }

        $(document).ready(function () {
            var table;
            var editData;


            // Add event listener for opening and closing details
            $('#DataTable').on('click', 'td.details-control', function () {

                var tr = $(this).closest('tr');
                var row = table.row(tr);

                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                }
                else {
                    // Open this row
                    row.child(format(row.data())).show();
                    tr.addClass('shown');
                }
            });

            // This fuction builds the DataTable. Because locations only store watershedIDs we must make a mapping of the watershed IDs to Names
            function initDataTable() {


                // Get all the watershed names and map them with thier IDs THEN build the datatable
                $.ajax({
                    type: 'GET',
                    contentType: 'application/json; charset=utf-8',
                    url: '../../api.asmx/AllAlbumDetails',
                    dataType: 'JSON'
                }).done(function (responseData) {
                    console.log(responseData);

                    // Build the DataTable
                    table = $('#DataTable').DataTable({
                        data: responseData,
                        columns: [
                            {
                                "className": 'details-control',
                                "orderable": false,
                                "data": null,
                                "defaultContent": ''
                            },
                            { "data": "Name" },
                            { "data": "Description" }
                        ]
                    });

                });
            }

            function format(albumDetailObj) {
                var placeholder = $(document.createElement('div'));

                var table = $(document.createElement('table'))
                    .css('padding', '0');

                albumDetailObj.ImageList.forEach(function (image) {

                    var tableRow = $(document.createElement('tr'));

                    var filename = $(document.createElement('td'))
                        .text(image.Filename);

                    tableRow.append(filename);
                    table.append(tableRow);
                });

                placeholder.append(table);
                return placeholder.html();
            }


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

            // This function fills out the data in the 'Create Modal' before displaying it
            function PopulateCreateModal() {

            }


            // This function fills out the fields in the 'Edit Modal' before displaying it
            function PopulateEditModal(data) {

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


                if (editImageIsDirty) {
                    var fileUpload = $('#inputEditImageBrowse').get(0);
                    var files = fileUpload.files;

                    var formData = new FormData();

                    for (var i = 0; i < files.length; i++) {
                        formData.append(files[i].name, files[i]);
                    }

                    formData.append('description', requestData.name);
                    formData.append('file', $('#inputEditImageBrowse')[0].files[0]);

                    $.ajax({
                        type: "POST",
                        url: "<%= Global.Url_Prefix() %>/images/location/set.ashx",
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
                                url: '<%= Global.Url_Prefix() %>/api.asmx/UpdateLocation',
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
                        },
                        error: function (errorData) {
                            console.log('Error Saving Image');
                        }
                    });
                } else {
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: '<%= Global.Url_Prefix() %>/api.asmx/UpdateLocation',
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
                }
                
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

                formData.append('description', requestData.name);
                formData.append('file', $('#inputCreateImageBrowse')[0].files[0]);

                // Save the image, get the new image ID THEN save the location w/ the image ID info
                $.ajax({
                    type: "POST",
                    url: "<%= Global.Url_Prefix() %>/images/location/set.ashx",
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
                            url: '<%= Global.Url_Prefix() %>/api.asmx/CreateLocation',
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
                    error: function(errorData) {
                        console.log('Error Saving Image');
                    }
                });
            });

        });
    </script>
</asp:Content>
