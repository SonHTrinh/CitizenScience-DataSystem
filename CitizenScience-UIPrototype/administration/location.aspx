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
                  <div class="form-group col-6">
                        <label for="inputCreateName">Name</label>
                        <input type="text" class="form-control" id="inputCreateName" aria-describedby="nameCreateHelp">
                        <small id="nameCreateHelp" class="form-text text-muted">The name you would like to give to this Location</small>
                  </div>
                  <div class="form-group col-6">
                        <select id="selectCreateWatershed"class="form-control">
                    
                        </select>
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

            // This function returns the HTML for the 'Action' buttons for each row in the DataTable
            function RenderActions(data, type, row, meta) {
                // Create a div to hold the buttons
                var buttonRow = $(document.createElement('div'))
                    .addClass('row');

                // Create the 'Edit' and 'Archive' buttons using the data from the row
                var buttonEdit = EditBtn(row.LocationID);
                var buttonArchive = ArchiveBtn(row.LocationID);

                // Create columns to place buttons inside
                var buttonLeftColumn = $(document.createElement('div'))
                    .addClass('col-12')
                    .append(buttonEdit);

                //var buttonRightColumn = $(document.createElement('div'))
                //    .addClass('col-6')
                //    .append(buttonArchive);

                // Add the 2 button columns to the row
                buttonRow.append(buttonLeftColumn);
                //buttonRow.append(buttonRightColumn);

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

            // This function fills out the data in the 'Create Modal' before displaying it
            function PopulateCreateModal() {
                $('#inputCreateName').val('');
                $('#inputCreateLatitude').val('');
                $('#inputCreateLongitude').val('');

                //$('#selectCreateWatershed').val('');
            }

            // This function fills out the fields in the 'Edit Modal' before displaying it
            function PopulateEditModal(data) {
                $('#inputEditName').val(data.sensorName);
                $('#inputEditLatitude').val(data.latitude);
                $('#inputEditLongitude').val(data.longitude);

                //$('#select').val('');
            }

            // This function fills out the fields in the 'Archive Modal' before displaying it
            function PopulateArchiveModal(data) {
                $('#archiveLocationName').text(data.sensorName);
            }
            
            // This variable holds the Datatable
            var table = $('#DataTable').DataTable({
                ajax: {
                    // The location to HTTP GET the data for the table
                    url: 'http://localhost:63073/api.asmx/Locations',
                    dataSrc: ''
                },
                columns: [
                    // The 'Name' column of the table's data
                    { data: 'SensorName' },
                    { data: 'WatershedID' },
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
                    //var watershedId = 
                    var latitude = $('#inputEditLatitude').val();
                    var longitude = $('#inputEditLongitude').val();

                    var requestData = { id: data.LocationID, name: name }

                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: 'http://localhost:63073/api.asmx/UpdateLocation',
                        data: JSON.stringify(requestData),
                        dataType: 'JSON',
                        success: function (responseData) {
                            console.log('SUCCESS');
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
                //var watershedId = 
                var latitude = $('#inputCreateLatitude').val();
                var longitude = $('#inputCreateLongitude').val();

                var requestData = {
                    name: name,
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
                        console.log('SUCCESS');
                        console.log(responseData);

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
