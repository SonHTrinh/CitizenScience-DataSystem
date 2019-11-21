<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="location.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.location" %>

<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Manage Locations   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!-- Scripts -->

    <!-- Javascript -->
    <script src="../../js/administration-location.js"></script>


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
                        <th scope="col">Sensor Location</th>
                        <th scope="col">Watershed</th>
                        <th scope="col">Latitude</th>
                        <th scope="col">Longitude</th>
                        <th scope="col">Edit</th>
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
                            <label for="inputCreateName">Name:</label>
                            <label style="color: red;">*</label>
                            <input type="text" class="form-control inputname" id="inputCreateName">
                            <div class="invalid-feedback">
                                Please provide a location name
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="selectCreateWatershed">Watershed:</label>
                            <label style="color: red;">*</label>
                            <select id="selectCreateWatershed" class="form-control selectwatershed">
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-6">
                            <label for="inputCreateLatitude">Latitude:</label>
                            <label style="color: red;">*</label>
                            <input type="text" class="form-control inputlatitude" id="inputCreateLatitude">
                            <div class="invalid-feedback">
                                Please provide a location latitude
                            </div>
                        </div>
                        <div class="form-group col-6">
                            <label for="inputCreateLongitude">Longitude:</label>
                            <label style="color: red;">*</label>
                            <input type="text" class="form-control inputlongitude" id="inputCreateLongitude">
                            <div class="invalid-feedback">
                                Please provide a location longitude
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="form-group col-12">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="inputCreateImageBrowse" accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*">
                                <label class="custom-file-label" for="inputCreateImageBrowse" id="lblInputCreateImageBrowse">Choose Profile Image File <label style="color: red;">*</label></label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="createClose">Close</button>
                    <button type="button" class="btn btn-info" id="createSubmit">Create</button>
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
                            <label for="inputEditName">Name:</label>
                            <label style="color: red;">*</label>
                            <input type="text" class="form-control inputname" id="inputEditName" required>
                            <div class="invalid-feedback">
                                Please provide a location name
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="selectEditWatershed">Watershed:</label>
                            <label style="color: red;">*</label>
                            <select id="selectEditWatershed" class="form-control selectwatershed" required>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-6">
                            <label for="inputEditLatitude">Latitude:</label>
                            <label style="color: red;">*</label>
                            <input type="text" class="form-control inputlatitude" id="inputEditLatitude" required>
                            <div class="invalid-feedback">
                                Please provide a location latitude
                            </div>
                        </div>
                        <div class="form-group col-6">
                            <label for="inputEditLongitude">Longitude:</label>
                            <label style="color: red;">*</label>
                            <input type="text" class="form-control inputlongitude" id="inputEditLongitude" required>
                            <div class="invalid-feedback">
                                Please provide a location longitude
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
</asp:Content>
