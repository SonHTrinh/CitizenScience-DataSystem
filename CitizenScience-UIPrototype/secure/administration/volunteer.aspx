<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="volunteer.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.volunteer" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Volunteers   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="row">
        <div class="col-12">
            <table class="table table-striped table-hover table-bordered" style="width: 100%;" id="DataTable">
                <thead>
                    <tr>
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Message</th>
                        <th scope="col" data-type="date">Date Submitted</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            function convertJsonDateToShortDate(data) {
                // This function converts a json date to a short date
                // e.g. /Date(1538377200000)/ to 10/1/2018
                console.log(data);
                const dateValue = new Date(parseInt(data.substr(6)));
                return dateValue.toLocaleDateString();
            }

            // This variable holds the Datatable
            var table = $('#DataTable').DataTable({
                ajax: {
                    // The location to HTTP GET the data for the table
                    url: '<%= Global.Url_Prefix() %>/api.asmx/Volunteers',
                    dataSrc: ''
                },
				order: [[4, "desc"]],
                columns: [
                    // The 'Name' column of the table's data
                    { data: 'FirstName', width: '15%' },
                    { data: 'LastName', width: '15%' },
                    { data: 'Email', width: '20%' },
                    { data: 'Message', width: '35%' },
                    {
                        data: 'DateSubmitted',
                        width: '15%', 
                        //type: 'datetime',
                        //format: 'MM/DD/YYYY',
                        render: function(data) {
                            return convertJsonDateToShortDate(data);
                        } 
                    }
                ]
            });
        });
    </script>
</asp:Content>
