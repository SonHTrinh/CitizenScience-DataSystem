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
</asp:Content>
