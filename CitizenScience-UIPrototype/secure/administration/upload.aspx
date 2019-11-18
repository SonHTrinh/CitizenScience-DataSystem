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
            <asp:DropDownList ID="ddlLocations" runat="server" CssClass="custom-select">
            </asp:DropDownList>
        </div>
        <div class="col-4">
            <label><b>Choose a CSV file</b></label>
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
        </div>
    </div>
    <div class="row justify-content-center my-4">
        <div class="col-3">
            <button ID="btnsave" runat="server" onserverclick="btnsave_Click"  class="btn btn-info btn-block"  title="Upload .CSV File" UseSubmitBehavior="false">
                <i class="fa fa-file-upload"></i>&nbsp;Upload .CSV File
            </button>
        </div>
    </div>
</asp:Content>
