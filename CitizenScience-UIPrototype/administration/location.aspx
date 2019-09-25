<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="location.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.location" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
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
                        <th scope="col">Serial</th>
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
                        <input type="text" class="form-control" id="inputCreateName">
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-12">
                    <label for="selectCreateWatershed">Watershed</label>
                    <select id="selectCreateWatershed" class="form-control">
                    </select>
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-12">
                        <label for="inputCreateSerial">Serial Number</label>
                        <input type="text" class="form-control" id="inputCreateSerial">
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-6">
                      <label for="inputCreateLatitude">Latitude</label>
                      <input type="text" class="form-control" id="inputCreateLatitude">
                  </div>
                  <div class="form-group col-6">
                      <label for="inputCreateLongitude">Longitude</label>
                      <input type="text" class="form-control" id="inputCreateLongitude">
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
                  <div class="form-group col-6">
                        <label for="inputEditName">Name</label>
                        <input type="text" class="form-control" id="inputEditName">
                  </div>
                  <div class="form-group col-6">
                      <label for="selectEditeWatershed">Watershed</label>
                        <select id="selectEditWatershed"class="form-control">
                        </select>
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group col-6">
                      <label for="inputEditLatitude">Latitude</label>
                      <input type="text" class="form-control" id="inputEditLatitude">
                  </div>
                  <div class="form-group col-6">
                      <label for="inputEditLongitude">Longitude</label>
                      <input type="text" class="form-control" id="inputEditLongitude">
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

    <!-- Archive Modal -->
    <div class="modal fade" id="archiveModal" tabindex="-1" role="dialog" aria-labelledby="archiveModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="archiveModalLabel">Archive Location</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <p>Would you like to archive the data for location '<span id="archiveLocationName" style="font-weight: bold;"></span>'?</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="archiveClose">Close</button>
            <button type="button" class="btn btn-warning" id="archiveSubmit">Archive</button>
          </div>
        </div>
      </div>
    </div>


    <script>
        $(document).ready(function () {

            // This variable holds the Datatable
            var table = $('#DataTable').DataTable({
                ajax: {
                    // The location to HTTP GET the data for the table
                    url: 'http://localhost:63073/api.asmx/ReadAllLocation',
                    dataSrc: ''
                },
                columns: [
                    // The 'Name' column of the table's data
                    { data: 'SensorName' },
                    {
                        data: 'WatershedID',
                        render: RenderWatershed
                    },
                    { data: 'SerialNumber' },
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

            // TODO: Fix mulitple 'GET' calls from datatable
            // This function is used to get and display the 'WatershedName' in the table. Because locations only store watershed ID, it must be looked up
            function RenderWatershed(data, type, row, meta) {
                var currentCell = $('#DataTable').DataTable().cells({ "row": meta.row, "column": meta.col }).nodes(0);
                var requestData = { id: data };

                $.ajax({
                    type: 'GET',
                    contentType: 'application/json; charset=utf-8',
                    url: 'http://localhost:63073/api.asmx/ReadWatershed',
                    data: requestData,
                    dataType: 'JSON'
                }).done(function (responseData) {
                    $(currentCell).text(responseData.WatershedName);
                });

                return null;
            }

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

            /*
             * TODO: figure out if we want to add delete/archive
             * 
            // This function takes an ID and returns a 'Archive' button; The ID is used to make the id attribute
            function ArchiveBtn(id) {
                var button = $(document.createElement('button'));
                var icon = $(document.createElement('i'));

                icon.addClass('fas')
                    .addClass('fa-archive');

                button.addClass('btn')
                    .attr('id', 'btnLocationArchive' + id)
                    .attr('type', 'button')
                    .addClass('archiveButton')
                    .addClass('btn-warning')
                    .addClass('btn-block')
                    .append(icon);

                return button;
            }
            */

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
                $('#inputCreateSerial').val('');
                $('#inputCreateLatitude').val('');
                $('#inputCreateLongitude').val('');

                PopulateCreateWatershedSelect();
            }

            // This function fills out the fields in the 'Edit Modal' before displaying it
            function PopulateEditModal(data) {
                $('#inputEditName').val(data.SensorName);
                $('#inputEditLatitude').val(data.Latitude);
                $('#inputEditSerial').val(data.SerialNumber);
                $('#inputEditLongitude').val(data.Longitude);

                PopulateEditWatershedSelect(data.WatershedID);
            }

            /*
             * TODO: figure out if we want to add delete/archive
             * 
            // This function fills out the fields in the 'Archive Modal' before displaying it
            function PopulateArchiveModal(data) {
                $('#archiveLocationName').text(data.sensorName);
            }
            */
            
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
                var data = table.row($(this).parents('tr')).data();

                //Put the data in the Edit Modal
                PopulateEditModal(data);

                //Display the modal
                $('#editModal').modal('show');
                $('#editSubmit').click(function () {
                    var name = $('#inputEditName').val();
                    var watershedId = $('#selectEditWatershed').val();
                    var serial = $('#inputEditSerial').val();
                    var latitude = $('#inputEditLatitude').val();
                    var longitude = $('#inputEditLongitude').val();

                    var requestData = {
                        id: data.LocationID,
                        name: name,
                        watershedId: watershedId,
                        serial: serial,
                        latitude: latitude,
                        longitude: longitude
                    }

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
                });
            });

            // The function when any 'Archive' button in the DataTable gets clicked
            $('#DataTable').on('click', '.archiveButton', function () {
                //Get Data for the the row
                var data = table.row($(this).parents('tr')).data();

                //Put the data in the Edit Modal
                PopulateArchiveModal(data);

                //Display the modal
                $('#archiveModal').modal('show');
            });

            // This function runs when the 'Create Modal' gets submitted
            $('#createSubmit').click(function () {
                var name = $('#inputCreateName').val();
                var watershedId = $('#selectCreateWatershed').val();
                var serial = $('#inputCreateSerial').val();
                var latitude = $('#inputCreateLatitude').val();
                var longitude = $('#inputCreateLongitude').val();

                var requestData = {
                    name: name,
                    watershedId: watershedId,
                    serial: serial,
                    latitude: latitude,
                    longitude: longitude
                };
                

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

            // This function runs when the 'Edit Modal' gets submitted


            // This function runs when the 'Archive Modal' gets submitted
            $('#archiveSubmit').click(function () {

            });

        });
    </script>
</asp:Content>
