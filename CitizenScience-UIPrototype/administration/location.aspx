<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="location.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.location" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Manage Locations   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    
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
                        <th scope="col">Name</th>
                        <th scope="col">Watershed</th>
                        <th scope="col">Latitude</th>
                        <th scope="col">Longitude</th>
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
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="editClose">Close</button>
            <button type="button" class="btn btn-info" id="editSubmit">Save changes</button>
          </div>
        </div>
      </div>
    </div>

    <script>
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
                    url: 'http://localhost:63073/api.asmx/ReadAllWatersheds',
                    dataType: 'JSON'
                }).done(function (responseData) {

                    responseData.forEach(function (watershed) {
                        watershedMap.set(watershed.WatershedID, watershed.WatershedName);
                    });

                    // Build the DataTable
                    table = $('#DataTable').DataTable({
                        ajax: {
                            // The location to HTTP GET the data for the table
                            url: 'http://localhost:63073/api.asmx/ReadAllLocation',
                            dataSrc: ''
                        },
                        columns: [
                            // The 'Name' column of the table's data
                            { data: 'SensorName' },
                            // This function is used to get and display the 'WatershedName' in the table. Because locations only store watershed ID, it must be looked up
                            {
                                data: null,
                                render: function(data, type, row, meta) {
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


            function BuildCreateLocation() {
                var Name = $('#inputCreateName').val();
                var WatershedId = $('#selectCreateWatershed').val();
                var Latitude = $('#inputCreateLatitude').val();
                var Longitude = $('#inputCreateLongitude').val();
                console.log('WATERSHEDID: ' + WatershedId);
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

                return {
                    id: LocationId,
                    name: Name,
                    watershedId: WatershedId,
                    latitude: Latitude,
                    longitude: Longitude
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

            function ValidateLocationRequest(dataRequest){
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
                    url: 'http://localhost:63073/api.asmx/ReadAllWatersheds',
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
                    url: 'http://localhost:63073/api.asmx/ReadAllWatersheds',
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

                PopulateCreateWatershedSelect();
            }


            // This function fills out the fields in the 'Edit Modal' before displaying it
            function PopulateEditModal(data) {
                $('#inputEditName').val(data.SensorName);
                $('#inputEditLatitude').val(data.Latitude);
                $('#inputEditLongitude').val(data.Longitude);

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

                if (isValidRequest) {
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: 'http://localhost:63073/api.asmx/UpdateLocation',
                        data: JSON.stringify(requestData),
                        dataType: 'JSON',
                        success: function (responseData) {
                            console.log('Edit Successful')
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
                console.log('Is Create Form Submission Valid?: ' + isValidRequest);

                $.ajax({
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    url: 'http://localhost:63073/api.asmx/CreateLocation',
                    data: JSON.stringify(requestData),
                    dataType: 'JSON',
                    success: function (responseData) {
                        console.log('Creation Sucessful');
                        console.log(requestData);

                        $('#createModal').modal('hide');
                        table.ajax.reload();
                    },
                    error: function (errorData) {
                        console.log('ERROR');
                        console.log(errorData);
                    }
                });

            });

        });
    </script>
</asp:Content>
