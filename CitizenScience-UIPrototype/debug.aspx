<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="debug.aspx.cs" Inherits="CitizenScience_UIPrototype.debug" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <br />

    <asp:FileUpload ID="FileUpload1" runat="server" />
    <br />

    <asp:Button ID="btnsave" runat="server" onclick="btnsave_Click"  Text="Save" style="width:85px"  UseSubmitBehavior="false"/>
    <br />

    <asp:Label ID="lblmessage" runat="server" />
    <br />

    <asp:Button ID="btnDownload" runat="server" OnClick="btnDownload_Click" Text="Download Dummy CSV File" UseSubmitBehavior="false" />
    <br />

    <asp:Button ID="btnClearTable" runat="server" OnClick="btnClear_Click" Text="Clear Table" UseSubmitBehavior="false"/>
    <br />

    <input type="file" name="name" value="brose" id="browse" progress="" onchange="previewFile()"/> <button id="upload" value="UPLOAD" type="button" >Upload</button>

    <asp:Repeater ID="rptCSV" runat="server">

        <HeaderTemplate>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Timestamp</th>
                        <th scope="col">C</th>
                        <th scope="col">F</th>
                    </tr>
                </thead>
        </HeaderTemplate>

        <ItemTemplate>
            <tbody>
                <tr>
                    <th scope="row">
                        <%# DataBinder.Eval(Container.DataItem, "Timestamp") %>
                    </th>
                    <th>
                        <%# DataBinder.Eval(Container.DataItem, "Celsius") %>
                    </th>
                    <th>
                        <%# DataBinder.Eval(Container.DataItem, "Fahrenheit") %>
                    </th>
                </tr>
            </tbody>
        </ItemTemplate>

        <FooterTemplate>
            </table>
        </FooterTemplate>

    </asp:Repeater>

    <script>
        function previewFile() {
            var preview = document.querySelector('img');
            var file = document.querySelector('input[type=file]').files[0];
            var reader = new FileReader();

            reader.addEventListener("load", function () {
                console.log(reader.result);
                //preview.src = reader.result;
            }, false);

            if (file) {
                reader.readAsDataURL(file);
            }
        }
        $(function () {

            function getBase64(file) {
                var reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = function () {
                    console.log(reader.result);
                };
                reader.onerror = function (error) {
                    console.log('Error: ', error);
                };
            }

            


            $('#upload').on('click', function () {
                var fileUpload = $('#browse').get(0);
                var files = fileUpload.files;

                var imag = new FormData();
                for (var i = 0; i < files.length; i++) {
                    imag.append(files[i].name, files[i]);
                }

                imag.append('file', $('#browse')[0].files[0]);


                $.ajax({
                    type: "POST",
                    url: "/getimage.ashx?locationid=3",
                    contentType: false,
                    processData: false,
                    data: imag,
                    success: function (dataResponse) {
                        console.log( dataResponse);
                    }

                });
            });
        });
        
    </script>
</asp:Content>
