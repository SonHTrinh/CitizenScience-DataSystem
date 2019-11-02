<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="CitizenScience_UIPrototype.gallery" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Gallery   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!--Style links-->
    <link rel="stylesheet" href="/style/custom/galleryAPI-style.css" />
    <!-- Javascript -->
    <script src="js/gallery.js"></script>
    
    <!-- Html content -->
    <div class="container-fluid" id="album-placeholder">
        <div class="row mt-1">
            <div class="col-12 text-center">
                <h1>Image Gallery</h1>
            </div>
        </div>
        <div class="row mt-1 mb-3">
            <div class="col-12">
                <button class="btn btn-success">button1</button>
                <button class="btn btn-success">button2</button>
                <button class="btn btn-success">button3</button>
            </div>
        </div>
    </div>
    
    <!-- Album Modal -->

</asp:Content>
