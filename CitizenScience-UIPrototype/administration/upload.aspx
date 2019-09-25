<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="col-md-10" id="divUploadSensorData" runat="server">
        <div class="row my-3">                                  
            <div class="col-md-5">
                <span style="color:red">*</span><asp:Label AssociatedControlID="fulUpload" CssClass="w-75" runat="server">Sensor Information File:</asp:Label>                        
                <div class="input-group" id="fulUpload" runat="server">            
                    <div class="custom-file">
                        <asp:Label AssociatedControlID="fulUploadSensorData" CssClass="custom-file-label" runat="server">Choose a temperature file...</asp:Label>
                        <asp:FileUpload ID="fulUploadSensorData" CssClass="custom-file-input" runat="server"/>                              
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col-md-12">
                        <asp:Button CssClass="btn btn-primary mr-2" ID="btnUploadSensorData" runat="server" text="Upload Data" OnClick="btnUploadSensorData_Click" UseSubmitBehavior="false" />
                        <asp:Button CssClass="btn btn-primary" ID="btnFileFormat" runat="server" text="Download File Format"  UseSubmitBehavior="false" />
                    </div>
                </div>                                
            </div>
            <div class="col-md-3">
                <span style="color:red">*</span><asp:Label AssociatedControlID="ddlAddLocationWatershed" runat="server">Data Location:</asp:Label>
                <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server"></asp:DropDownList>
            </div>

            <div class="col-md-3 offset-1">
                <div class="row">
                    <div class="col-md-12">
                        <asp:Label AssociatedControlID="calError" runat="server">Search Error by Date:</asp:Label>
                        <input class="form-control" type="date" id="calError" runat="server"/>
                    </div>
                </div>
                <div class="row py-2">
                    <div class="col-md-12">
                        <asp:Button CssClass="btn btn-primary mr-2" ID="btnSearchError" runat="server" text="Search" OnClick="btnUploadSensorData_Click" UseSubmitBehavior="false" />
                    </div>
                </div>                                                             
            </div>
        </div>                                                                              
        <div class="row my-2"> 
            <div class="col-md-12">                            
                <div id="divUploadError" class="alert-primary p-2 card" role="alert" runat="server">                        
                    <h2 class="p-3">Upload Error:</h2>                              
                    <h5>The following errors were found in your upload. This upload will be discarded to maintain data validity.</h5>
                    <table class="table table-info table-bordered rounded my-2">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Row Number</th>
                                <th scope="col">Error</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>6</td>
                                <td>Incorrect date format</td>
                            </tr>
                            <tr>
                                <td>10</td>
                                <td>Temperature out of range</td>
                            </tr>
                        </tbody>                                     
                    </table>
                </div>
            </div>
        </div>
    </div>  
</asp:Content>
