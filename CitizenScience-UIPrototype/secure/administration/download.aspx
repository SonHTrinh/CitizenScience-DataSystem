<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.download" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Download Data   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">

    <div class="row mb-3">
        <div class="col-3">
            <button type="button" id="downloadCSV" class="btn btn-success float-left">
                <i class="fa fa-file-csv">&nbsp; Download CSV File</i>
            </button>
        </div>
        <div class="col-6">
            <div id="feedbackDownloadSelect"  class="alert alert-warning text-center invisible mb-0" role="alert">
              You must either select <strong>1 or more Locations</strong> from the Table or choose <strong>All</strong>!
            </div>
        </div>
    </div>
    <div class="row mb-4 mt-1">
        <div class="col-12">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="radioSelect" checked="" name="radioSelect" class="custom-control-input">
              <label class="custom-control-label active" for="radioSelect">Selected</label>
            </div>
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" id="radioAll" name="radioSelect" class="custom-control-input">
              <label class="custom-control-label" for="radioAll">All</label>
            </div>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-12">
            <table class="table table-striped table-hover table-bordered" style="width: 100%;" id="DataTable">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Watershed</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            var table;
            
            // This fuction builds the DataTable. Because locations only store watershedIDs we must make a mapping of the watershed IDs to Names
            function initDataTable() {

                var watershedMap = new Map();

                // Get all the watershed names and map them with thier IDs THEN build the datatable
                $.ajax({
                    type: 'GET',
                    contentType: 'application/json; charset=utf-8',
                    url: '<%= Global.Url_Prefix() %>/api.asmx/ReadAllWatersheds',
                    dataType: 'JSON'
                }).done(function (responseData) {

                    responseData.forEach(function (watershed) {
                        watershedMap.set(watershed.WatershedID, watershed.WatershedName);
                    });

                    // Build the DataTable
                    table = $('#DataTable').DataTable({
                        select: {
                            style: 'multi'
                        },
                        ajax: {
                            // The location to HTTP GET the data for the table
                            url: '<%= Global.Url_Prefix() %>/api.asmx/ReadAllLocation',
                            dataSrc: ''
                        },
				        order: [[1, "asc"]],
                        columns: [
                            // The 'Name' column of the table's data
                            { data: 'SensorName' },
                            // This function is used to get and display the 'WatershedName' in the table. Because locations only store watershed ID, it must be looked up
                            {
                                data: null,
                                render: function(data, type, row, meta) {
                                    return watershedMap.get(data.WatershedID);
                                }
                            }
                        ]
                    });

                });
            }

            // initialize the DataTable
            initDataTable();

            $('#downloadCSV').click(function () {
                var selectedLocations = [];
                var isDownloadAll = $('#radioAll').is(':checked');

                table.rows({ selected: true }).every(function () {
                    selectedLocations.push(this.data().LocationID);
                });

                if (selectedLocations.length == 0 && !isDownloadAll) {
                    $('#feedbackDownloadSelect').removeClass('invisible');
                    return;
                }

                $('#feedbackDownloadSelect').addClass('invisible');

                if (isDownloadAll) {
                    window.location.href = '<%= Global.Url_Prefix() %>/api.asmx/AllLocationTemperaturesCsv';
                } else {
                    var idParameters = '?';

                    selectedLocations.forEach(function (location) {
                        idParameters = idParameters + 'locationId=' + location + '&';
                    });

                    idParameters = idParameters.substring(0, idParameters.length - 1);

                    window.location.href = '<%= Global.Url_Prefix() %>/api.asmx/LocationTemperaturesCsv' + idParameters;
                }

                table.rows('.selected').deselect();             
            });

          
        });
    </script>

</asp:Content>
