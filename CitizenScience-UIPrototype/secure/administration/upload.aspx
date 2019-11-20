<%@ Page Title="" Language="C#" MasterPageFile="~/secure/administration/administration.master" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Upload Data   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!-- Add Content. everything in here is already in a .container-fluid div by default from the masterpage 'administration.master' -->
    <div class="row justify-content-center my-4">
        <div class="alert alert-success" role="alert" runat="server" ID="feedbackSuccess" visible="false">
            You have added <strong ID="txtRowcount" runat="server"></strong> rows of Temperature data to <strong ID="txtLocation" runat="server">.</strong>
        </div>
        <div class="alert alert-danger" role="alert" runat="server" ID="feedbackDanger" visible="false">
            <span ID="txtFail" runat="server"></span>
        </div>
    </div>
    <div class="row justify-content-center  my-4">
        <div class="col-4">
            <label><b>Select a Sensor Location</b></label>
            <label style="color: red;">*</label>   
            <asp:DropDownList ID="ddlLocations" runat="server" CssClass="custom-select" required="true"></asp:DropDownList>
        </div>
        <div class="col-4">
            <label><b>Select a File</b></label>
            <label style="color: red;">*</label>   
            <div class="custom-file">
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="custom-file-input" accept=".csv" required="true"/>
                <label class="custom-file-label" for="FileUpload1" id="uploadLabel">Choose .CSV File</label>
            </div>
        </div>
    </div>
    <div class="row justify-content-center my-4">
        <div class="col-3">
            <button ID="btnsave" runat="server" onserverclick="btnsave_Click"  class="btn btn-info btn-block"  title="Upload .CSV File" UseSubmitBehavior="false">
                <i class="fa fa-file-upload"></i>&nbsp;Upload .CSV File
            </button>
        </div>
    </div>
    
    <script>
        $(function() {
            $('#main_content_main_content_FileUpload1').change(function() {
                var filename = $('#main_content_main_content_FileUpload1')[0].files[0].name;
                $('#uploadLabel').html(filename); 
            });
        });
    </script>

</asp:Content>
