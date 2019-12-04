<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="CitizenScience_UIPrototype.about" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    About   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!--About Citizen Science-->
    <div class="container-fluid">
        <div class="row my-3">
            <div class="container pl-1">
                <ol class="breadcrumb bg-light">
                    <li class="breadcrumb-item">
                        <h3 class="d-inline">Citizen Science</h3>
                    </li>
                    <li class="breadcrumb-item active">
                        <h3 class="d-inline">About Citizen Science</h3>
                    </li>
                </ol>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">                
                <div id="divDescription"></div>
                <p>
                    <%--Citizen Science Data System (CS) is a project headed by Dr. Laura Toran and Dr. Sarah Beganskas
                    who both work in the Earth and Environmental Science department in the College of Science and
                    Technology. They are planning to develop an initiative which tasks volunteers with measuring 
                    temperature of water in watersheds located in the Greater Philadelphia and surrounding areas.
                    With the CS Data System, they intend to engage the volunteers that travel to watersheds and 
                    provide accurate data reporting of the measured water temperature. The project will help 
                    visualize the data collected and allow for users that visit the application to view the 
                    various metrics. --%>
                </p>                
                <a href="#volunteer_form" class=" btn btn-outline-dark" role="button" aria-pressed="true">Interested in Volunteering?</a>           
            </div>
        </div>
    </div>
    <!--Common Question-->
    <div class="row">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <h1 style="text-align: center;">Frequently Asked Questions</h1>
        </div>
        <div class="col-lg-4"></div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">
                <button class="btn btn-dark" style="width: 100%;" type="button" data-toggle="collapse" data-target="#who1"
                    aria-expanded="false" aria-controls="collapseExample" id="btnQuestion1">
                   <%-- Who are we? --%>
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">
                <div class="collapse" id="who1">
                    <div class="card card-body" id="divAnswer1">
                        <%--Citizen Science Data System (CS) is a project headed by Dr. Laura Toran 
                        and Dr. Sarah Beganskas who both work in the Earth and Environmental 
                        Science department in the College of Science and Technology.
                        They are planning to develop an initiative which tasks volunteers
                        with measuring temperature of water in watersheds located in the Greater 
                        Philadelphia and surrounding areas. With the CS Data System, they intend 
                        to engage the volunteers that travel to watersheds and provide accurate 
                        data reporting of the measured water temperature. The project will help 
                        visualize the data collected and allow for users that visit the application
                        to view the various metrics. --%>
                    </div>
                </div>
            </div>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">
                <button class="btn btn-dark" style="width: 100%;" type="button" data-toggle="collapse" data-target="#goals1"
                    aria-expanded="false" aria-controls="collapseExample" id="btnQuestion2">
                    <%-- What are our goals? --%> 
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">
                <div class="collapse" id="goals1">
                    <div class="card card-body" id="divAnswer2">
                  <%--      The Citizen Science Data System will record water temperature information 
                        and organize it by location. This data will be displayed in the form of 
                        interactive graphs that can be accessed from a map-view user interface.
                        This project will serve to monitor local water source statistics while 
                        also engaging the community by allowing them to be actively involved in 
                        the collection and analysis of the data.--%>
                    </div>
                </div>
            </div>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">
                <button class="btn btn-dark" style="width: 100%;" type="button" data-toggle="collapse" data-target="#temp1"
                    aria-expanded="false" aria-controls="collapseExample" id="btnQuestion3">
                    <%-- Expected Benefits --%>
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="container">
                <div class="collapse" id="temp1">
                    <div class="card card-body" id="divAnswer3">
                   <%--     The main benefits to be gained through this new system will be a secure and organized data 
                        storage method for vital water temperature data as well as a way of involving Greater 
                        Philadelphia area residents in the conservation of local water ecosystems. 
                        The system will be designed to allow administrative users to easily record relevant data.
                        That collected data will then be displayed in an intuitive and user-friendly manner. --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Volunteer Form-->
    <div id="volunteer_form">
        <div class="container mt-5">
            <hr />
            <!--Success-->
            <div class="alert alert-success" id="divSuccess" runat="server" visible="false">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <h6 class="alert-heading">Successfully submitted!</h6>
                <p class="mb-0" style="color: black">
                    Thank you for your interest in our program! One of our Citizen Science Program 
                    representatives will contact you at <b><asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></b>!
                </p>
            </div>
            <!--Fail-->
            <div class="alert alert-danger" id="divFail" runat="server" visible="false">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <h6 class="alert-heading">Please do not leave any field empty!</h6>
            </div>
        </div>
        <h1 style="text-align: center;">Citizen Science Volunteer Form </h1>
        <p style="text-align: center; color: black;"><b>Please fill out the form below if you are interested in volunteering</b></p>
        <div class="row">
            <div id="frmVolunteer" class="col-lg-12">
                <div class="container">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="fname">First Name:</label>
                            <label for="fname" style="color: red;">*</label>                     
                            <asp:TextBox ID="txtFirstName" runat="server" class="form-control" placeholder="First Name" required="true"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="lname">Last Name:</label>
                            <label for="lname" style="color: red;">*</label>
                            <asp:TextBox ID="txtLastName" runat="server" class="form-control" placeholder="Last Name" required="true" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group ">
                        <label for="email">Email:</label>
                        <label for="email" style="color: red;">*</label>
                        <asp:TextBox ID="txtEmail" runat="server" type="email" class="form-control" placeholder="Your Email Address" required="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="comments">Message:</label>
                        <label for="message" style="color: red;">*</label>
                        <asp:TextBox ID="txtMessage" runat="server" class="form-control" placeholder="Leave a message" TextMode="MultiLine" Rows="5" required="true"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" class="btn btn-info" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return HideMessage();" />
                    &nbsp;<asp:Label ID="lblDisplay" runat="server" Text="" ForeColor="#CC3300"></asp:Label>
                    
                </div>
            </div>
        </div>

    </div>
    <div class="container mb-5">
        <hr />
    </div>
    <script type="text/javascript">
        function HideMessage() {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%=divSuccess.ClientID %>").style.display = "none";
            }, second * 1000);
        }; 
  
        $(document).ready(function () {

            RenderManageAboutPage();
            // This function fills out the contents of the Manage About page
            function RenderManageAboutPage() {
                $.ajax({
                    type: 'GET',
                    contentType: 'application/json',
                    url: '<%= Global.Url_Prefix() %>/api.asmx/About',
                    dataType: 'JSON',
                    success: function (responseData) {
                        console.log(responseData)
                        $("#divDescription").html(responseData.Description);
                        $("#btnQuestion1").html(responseData.Question1);
                        $("#btnQuestion2").html(responseData.Question2);
                        $("#btnQuestion3").html(responseData.Question3);
                        $("#divAnswer1").html(responseData.Answer1);
                        $("#divAnswer2").html(responseData.Answer2);
                        $("#divAnswer3").html(responseData.Answer3);
                    },
                    error: function (errorData) {
                        console.log('getting ERROR');
                        console.log(errorData);
                    }
                });
            }
        });
        $("#btnSubmit").click(function () {

        });
    </script>

</asp:Content>
