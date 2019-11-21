<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="CitizenScience_UIPrototype.gallery" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Gallery   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!--Style links-->
    <link rel="stylesheet" href="/style/custom/gallery.css" />
    <!-- Javascript -->
    <script src="js/gallery.js"></script>

    <div class="container-fluid">
        <div class="row my-3">
            <div class="container pl-1">
                <ol class="breadcrumb bg-light">
                    <li class="breadcrumb-item">
                        <h3 class="d-inline">Citizen Science</h3>
                    </li>
                    <li class="breadcrumb-item active">
                        <h3 class="d-inline">Field Photos</h3>
                    </li>
                </ol>
            </div>
        </div>

        <!-- Html content -->
        <div class="container" id="album-placeholder"></div>

        <!--
        <div class="row my-4 justify-content-center">
            <div class="col-4 text-center">
                <button class="btn btn-dark">All</button>
                <button class="btn btn-dark">Locations</button>
                <button class="btn btn-dark">Volunteers</button>
            </div>
        </div>
        -->

        <!-- Rows with Album Elements will be appended here -->
    </div>
    
    <!-- Album Modal -->
    <div id="gallery-modal" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div id="carouselExampleControls" class="carousel slide" data-interval="false">
                                    <div id="album-image-placeholder" class="carousel-inner">
                                        <!-- Images will be appended to here -->
                                    </div>
                                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- <div class="modal-footer"> --%>
                <%--     <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> --%>
                <%--     <button type="button" class="btn btn-primary">Save changes</button> --%>
                <%-- </div> --%>
            </div>
        </div>
    </div>

</asp:Content>
