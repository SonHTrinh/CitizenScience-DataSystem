<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="volunteer.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.volunteer" %>
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
                        <th scope="col">Date Submitted</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
    <script>
        $(document).ready(function () {

            // This variable holds the Datatable
            var table = $('#DataTable').DataTable({
                ajax: {
                    // The location to HTTP GET the data for the table
                    url: '/api.asmx/Volunteers',
                    dataSrc: ''
                },
                columns: [
                    // The 'Name' column of the table's data
                    { data: 'FirstName' },
                    { data: 'LastName' },
                    { data: 'Email' },
                    { data: 'Message' },
                    { data: 'DateSubmitted' }
                ]
            });
        });
    </script>
</asp:Content>
