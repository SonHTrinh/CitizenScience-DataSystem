<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="CitizenScience_UIPrototype.map" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Map   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="container-fluid">
        <%--<div class="row my-3">
            <div class="col-12 text-center">
                <h1>Citizen Science Data System</h1>
            </div>
        </div>--%>
        <div class="row my-4">
                <div class="dropdown float-left" style="margin-left: 10%;">
                  <button class="btn btn-dark dropdown-toggle px-5 py-2" type="button" id="ddBtnWatershed" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Watersheds
                  </button>
                  <div class="dropdown-menu" id="ddMenuWatershed" aria-labelledby="dropdownMenuButton"></div>
                </div>
                &nbsp;
                <div class="dropdown float-left invisible" id="locationdiv">
                  <button class="btn btn-dark dropdown-toggle px-5 py-2" type="button" id="ddBtnLocation" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                  <div class="dropdown-menu" id="ddMenuLocation" aria-labelledby="dropdownMenuButton"></div>
                </div>
        </div>

    </div>

    <div id="map" class="shadow-lg p-3 mb-5 bg-white rounded" ></div>

    <div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="max-width: 200%;">
        <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-4">
                                <div class="row">
                                    <div class="col-12">
                                        <img src="img" alt="watershed-location-profile" class="modalImage" style="max-width: 100%; max-height: 100%;"  />
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <p class="modalLink"></p>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <p style="font-weight: bold" class="modalDescTitle"></p>
                                        <p class="modalDesc"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-8 data-element">
                                <div class="row temperature-chart">
                                    <canvas id="myChart" style="width: 570px; height: 340px;" />
                                </div>
                                <div class="row mt-5 temperature-chart">
                                    <div class="col-3">
                                        <div class="form-group">
                                            <select class="form-control chart-modifier" id="selectScale">
                                                <option>Celsius</option>
                                                <option>Fahrenheit</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-1">

                                    </div>
                                    
                                    <div class="col-3">
                                        <input type="text" class="form-control text-center chart-modifier" id="start_datepicker" readonly>
                                    </div>
                                    <div class="col-1 text-center mx-0 px-0">
                                        <p>to</p>
                                    </div>
                                    <div class="col-3">
                                        <input type="text" class="form-control text-center chart-modifier" id="end_datepicker" readonly>
                                    </div>
                                    <div class="col-1"></div>
                                </div>
                            </div>
                            <div class="col-8 nodata-element">
                                <div class="row justify-content-center mt-5">
                                    <i class="fas fa-exclamation-triangle fa-10x"></i>
                                </div>
                                <div class="row justify-content-center mt-5">
                                    <h5>No Temperature Data Exists For This Location</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="downloadCsv" class="btn btn-dark temperature-download data-element">
                        <i class="fa fa-file-csv">&nbsp; Download Temperature CSV File</i>
                    </button>
                    <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp7tBTG5O-LXpXR7BL01PlEB63wBC0PSA"></script>
    <script src="js/map.js"></script> 
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    
    <%--datepicker--%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</asp:Content>
