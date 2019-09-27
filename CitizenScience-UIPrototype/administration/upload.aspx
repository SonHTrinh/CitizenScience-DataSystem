<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Upload Data   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!-- Add Content. everything in here is already in a .container-fluid div by default from the masterpage 'administration.master' -->
    <div class="row justify-content-center my-4">
        <asp:Label Text="text" ID="lblFeedback" runat="server" />
    </div>
    <div class="row justify-content-center  my-4">
        <div class="col-4">
            <asp:DropDownList ID="ddlLocations" runat="server" CssClass="custom-select">
            </asp:DropDownList>
        </div>
        <div class="col-4">
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
        </div>
    </div>
    <div class="row justify-content-center my-4">
        <div class="col-3">
            <asp:Button ID="btnsave" runat="server" onclick="btnsave_Click"  Text="Save" CssClass="btn btn-primary btn-block"  UseSubmitBehavior="false"/>
        </div>
    </div>
</asp:Content>
