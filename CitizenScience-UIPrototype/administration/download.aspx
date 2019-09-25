<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.download" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="row mb-2">
        <div class="col-2">
            <asp:Button CssClass="btn btn-success float-left" ID="btnDownloadAllSensorData" runat="server" text="Download All Data" OnClick="btnDownloadAllSensorData_Click" UseSubmitBehavior="false"/>                                    
        </div>
        <div class="col-2">
            <asp:Button CssClass="btn btn-success float-left" ID="btnDownloadSelectedSensorData" runat="server" text="Download Selected Data" OnClick="btnDownloadSelectedSensorData_Click" UseSubmitBehavior="false"/>
        </div>
    </div>
    <div class="row my-1">
        <div class="col-md-12">
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="tblDownloadSelect" class="table table-striped table-hover table-bordered">                                    
                <thead>
                    <tr>
                        <th scope="col">
                            <asp:DropDownList CssClass="form-control" ID="ddlSensorDownloadWatersheds" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSensorDownloadWatersheds_Change"></asp:DropDownList>                                                                                                                                         
                        </th>
                        <th scope="col">Location</th>
                    </tr>                                       
                </thead>
                <tbody>               
                    <asp:Repeater ID="rptDownloadSensorLocations" runat="server">     
                        <ItemTemplate>                                                
                            <tr>
                                <th scope="row"><asp:Checkbox ID="cbxDownloadSensorLocation" runat="server"/></th>
                                <td>
                                    <asp:Label ID="lblDownloadSensorLocationName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SensorName") %>'></asp:Label>
                                    <asp:HiddenField id="hdnDownloadSensorLocationID" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "LocationID") %>'></asp:HiddenField>
                                </td>
                            </tr>                                                
                        </ItemTemplate>  
                    </asp:Repeater>   
                </tbody>
            </table>    
        </div>
    </div>   
</asp:Content>
