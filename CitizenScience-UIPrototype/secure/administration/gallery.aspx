﻿<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.gallery" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Manage Gallery   |   Citizen Science
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
<!-- Scripts -->

    <!-- CSS  -->
    <link rel="stylesheet" href="../../style/custom/administration-gallery.css" />
    
    <!-- Javascript -->
    <script src="../../js/administration-gallery.js"></script> 
    

<!-- Page -->
    
    <!-- Create New Album button -->
    <div class="row mb-4">
        <div class="col-12">
            <button type="button" id="createAlbum" class="btn btn-success float-left">
                <i class="fa fa-plus">&nbsp; Create New Album</i>
            </button>
        </div>
    </div>

    <!-- Data Table -->
    <div class="row mt-2">
        <div class="col-12">
            <table class="table table-striped table-hover table-bordered" style="width: 100%;" id="DataTable">
                <thead>
                    <tr>
                        <!-- Table Column Header -->
                        <th scope="col">Album Name</th>
                        <th scope="col">Description</th>
                        <th scope="col" class="no-sort">Edit</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
    
    
<!-- Modals -->    
    
    <!-- Create New Album Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createModalLabel">Create Album</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="inputCreateName">Album Name:</label>
                            <label for="inputCreateName" style="color: red;">*</label>
                            <!-- Album Input Name Field -->
                            <input type="text" class="form-control inputname" id="inputCreateName">
                            <div class="invalid-feedback">
                                Please provide an album name
                            </div>
                        </div>
                        
                    </div>
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="inputCreateDescription">Description:</label>
                            <label for="inputCreateDescription" style="color: red;">*</label>
                            <!-- Album Input Description Field -->
                            <textarea type="text" class="form-control inputdescription" id="inputCreateDescription"></textarea>
                            <div class="invalid-feedback">
                                Please provide an album description
                            </div>
                        </div>
                        
                    </div>
                    <div class="row mt-2">
                        <div class="form-group col-12">
                            <div class="custom-file">
                                <!-- Profile Picture Input Field -->
                                <input type="file" class="custom-file-input" id="inputCreateImageBrowse" accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*"/>
                                <label class="custom-file-label" for="inputCreateImageBrowse" id="lblCreateImageFile">Choose Album Profile Image file</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="createClose">Close</button>
                    <!-- Album Create Submit -->
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
                    <h5 class="modal-title" id="editModalLabel">Edit Album</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="inputEditName">Album Name:</label>
                            <!-- Album Edit Name Input -->
                            <input type="text" class="form-control inputname" id="inputEditName">
                            <div class="invalid-feedback">
                                Please provide an album name
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="inputEditDescription">Description:</label>
                            <!-- Album Edit Description Input -->
                            <textarea class="form-control inputDescription" id="inputEditDescription"> </textarea>
                            <div class="invalid-feedback">
                                Please provide an album description
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="editClose">Close</button>
                    <!-- Edit Submit Button -->
                    <button type="button" class="btn btn-info" id="editSubmit">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Image View Modal -->
    <div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="viewModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewModalLabel">Manage Album Images</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-row mb-3">
                        <div class="col-12">
                            <ul class="nav nav-tabs">
                                <li class="nav-item" id="viewManageImages">
                                    <a class="nav-link active" href="#" >Manage Images</a>
                                </li>
                                <li class="nav-item" id="viewAddNewImage">
                                    <a class="nav-link" href="#">Add New Image</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="form-row viewManageItem" id="viewManageRow">
                        <div class="form-group col-12">
                            <!-- Manage Images Panel -->

                            <label for="viewImageSelect">Select Image</label>
                            <select class="form-control" id="viewImageSelect">
                            </select>
                        </div>

                    </div>
                    <div class="form-row viewManageItem justify-content-center" id="viewManageRow">
                        <!-- View selected image -->
                        <img width="250px" height="250px" id="viewSelectedImage"/>
                    </div>

                    <div class="form-row mt-5 viewAddNewItem" id="viewAddRow">
                        <div class="form-group col-12">
                            <!-- Add New Image Panel -->
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="customFile" accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*" multiple>
                                <label class="custom-file-label" for="customFile">Choose files</label>
                            </div>
                        </div>
                    </div>
                    <span id="viewAddingItems" class="viewAddNewItem mt-2 w-100">
                    </span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="viewClose">Close</button>
                    <!-- Image Buttons -->
                    <button type="button" class="btn btn-danger viewManageItem" id="deleteSubmit">Delete</button>
                    <button type="button" class="btn btn-info viewManageItem" id="makePrimarySubmit">Set As Primary Image</button>
                    <button type="button" class="btn btn-info viewAddNewItem" id="addNewSubmit">Upload</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
