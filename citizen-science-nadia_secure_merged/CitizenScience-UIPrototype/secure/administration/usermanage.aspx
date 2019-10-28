<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="usermanage.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.usermanage" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Manage Admins   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="row mb-4">
        <div class="col-12">
            <button type="button" id="createAdmin" class="btn btn-success float-left">
                <i class="fa fa-plus">&nbsp; New Admin</i>
            </button>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-12">
            <table class="table table-striped table-hover table-bordered" style="width: 100%;" id="DataTable">
                <thead>
                    <tr>
                        <th scope="col">TUID</th>       
                        <th scope="col">Active Status</th>       
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
            <h5 class="modal-title" id="createModalLabel">Add Administrator</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                <label for="inputCreateTUID">TUID</label>
                <input type="text" class="form-control inputtuid" id="inputCreateTUID" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    TUID must be ...
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
            <h5 class="modal-title" id="editModalLabel">Edit Admin</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
               <div class="form-group">
                <label for="inputEditTUID">TUID</label>
                <input type="text" class="form-control inputtuid" id="inputEditTUID" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Accessnet must be ...
                </div>
              </div> 
              <div class="form-group">
                <label for="inputEditActive">Active Status</label>
                <input type="checkbox" class="form-control inputactive" id="inputEditActive" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Active must be ...
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

            // This function returns the HTML for the 'Action' buttons for each row in the DataTable
            function RenderAdminActions(data, type, row, meta) {
                // Create a div to hold the buttons
                var buttonRow = $(document.createElement('div'))
                    .addClass('row');

                // Create the 'Edit' and 'Archive' buttons using the data from the row
                var buttonEdit = EditAdminBtn(row.AdminID);

                // Create columns to place buttons inside
                var buttonLeftColumn = $(document.createElement('div'))
                    .addClass('col-12')
                    .append(buttonEdit);

                // Add the button columns to the row
                buttonRow.append(buttonLeftColumn);

                // Return the HTML that makes up the row > (column > button > icon)*2
                return buttonRow.prop('outerHTML');
            }

            // This function takes an ID and returns a 'Edit' button; The ID is used to make the id attribute
            function EditAdminBtn(id) {
                var button = $(document.createElement('button'));
                var icon = $(document.createElement('i'));

                icon.addClass('far')
                    .addClass('fa-edit');

                button.addClass('btn')
                    .attr('id', 'btnAdminEdit' + id)
                    .attr('type', 'button')
                    .addClass('editButton')
                    .addClass('btn-info')
                    .addClass('btn-block')
                    .append(icon);

                return button;
            }

            // This function fills out the data in the 'Create Modal' before displaying it
            function PopulateCreateModal() {
                $('#inputCreateTUID').val('');
            }

            // This function fills out the fields in the 'Edit Modal' before displaying it
            function PopulateEditModal(data) {
                $('#inputEditTUID').val(data.TUID);
                $('#inputEditActive').prop("checked", data.Active);
            }

            // This variable holds the Datatable
            var table = $('#DataTable').DataTable({
                ajax: {
                    // The location to HTTP GET the data for the table
                    url: '<%= Global.Url_Prefix() %>/api.asmx/Admins',
                    dataSrc: ''
                },
                columns: [
                    // The 'TUID' column of the table's data
                    { data: 'TUID' },                 
                    // The 'Active' column of the table's data
                    { data: 'Active' },                 
                    // The 'Action' column of the table
                    {
                        data: null,
                        orderable: false,
                        width: '10%',
                        render: RenderAdminActions
                    }
                ]
            });

            // The function when the 'Create New Admin' button gets clicked
            $('#createAdmin').click(function () {
                //Populate the Create Modal
                PopulateCreateModal();

                //Display the modal
                $('#createModal').modal('show');
            });

            // The function when the any 'Edit' button in the DataTable gets clicked
            $('#DataTable').on('click', '.editButton', function () {
                //Get Data for the the row
                var data = table.row($(this).parents('tr')).data();

                editData = data;
                console.log(data);

                //Put the data in the Edit Modal
                PopulateEditModal(data);

                //Display the modal
                $('#editModal').modal('show');

            });

            function BuildCreateAdmin() {
                var TUID = $('#inputCreateTUID').val();           

                return {
                    tuid: TUID
                };
            }

            function BuildEditAdmin(data) {
                var TUID = $('#inputEditTUID').val();             
                var Active = $('#inputEditActive').prop("checked");             
                return {
                    id: data.AdminID,
                    tuid: TUID,
                    active: Active
                };
            }

            function ValidateAdminRequest(requestData) {
                $('.inputtuid').removeClass('is-invalid');
                $('.inputactive').removeClass('is-invalid');


                //  CHECK IF INPUTTED ACCESSNET PRESENT IN TEMPLE'S RECORDS


                var regexTUID = /^[\w ]+$/;

                hasValidTUID = regexTUID.test(requestData.tuid);

                console.log("Valid Accessnet: " + hasValidTUID);

                if (hasValidTUID) {
                    $('.inputtuid').addClass('is-valid');
                    $('.inputactive').addClass('is-valid');
                } else {
                    $('.inputtuid').addClass('is-invalid');
                    $('.inputactive').addClass('is-invalid');
                }

                return (hasValidTUID);
            }

            $('#editSubmit').click(function () {
                var requestData = BuildEditAdmin(editData)
                var isValidRequest = ValidateAdminRequest(requestData);
                console.log('Is Edit Form Submission Valid?: ' + isValidRequest);
                console.log(requestData)

                if (isValidRequest) {
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: '<%= Global.Url_Prefix() %>/api.asmx/UpdateAdmin',
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
                }

            });

            // This function runs when the 'Create Modal' gets submitted
            $('#createSubmit').click(function () {

                var requestData = BuildCreateAdmin()
                var isValidRequest = ValidateAdminRequest(requestData);
                console.log('Is Creation Form Submission Valid?: ' + isValidRequest);

                if (isValidRequest) {
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: '<%= Global.Url_Prefix() %>/api.asmx/CreateAdmin',
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
                }
            });

            $('#createModal').on('hidden.bs.modal', function (e) {
                $('.inputtuid').removeClass('is-invalid');
                $('.inputtuid').removeClass('is-valid');             
            });

            $('#editModal').on('hidden.bs.modal', function (e) {
                $('.inputtuid').removeClass('is-invalid');
                $('.inputtuid').removeClass('is-valid');    
                $('.inputactive').removeClass('is-invalid');
                $('.inputactive').removeClass('is-valid');    
            });
        });
    </script>
</asp:Content>
