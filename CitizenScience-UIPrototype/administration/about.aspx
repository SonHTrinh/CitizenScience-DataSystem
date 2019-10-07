<%@ Page Title="" Language="C#" MasterPageFile="~/administration/administration.master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="CitizenScience_UIPrototype.administration.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Manage About   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="row mb-4">
        <div class="col-12">
            <button type="button" id="editAbout" class="btn btn-success float-left">
                <i class="fa fa-edit"> Edit About</i>
            </button>
        </div>
    </div>
    <div class="row mt-2 card card-body">
        <div class="col-12">
            <label for="divDescription" class="font-weight-bold">Citizen Science Description</label>
            <div id="divDescription"></div>
            <%--<input type="text" class="form-control inputaccessnet" id="inputCreateAccessnet" aria-describedby="nameCreateHelp">--%>
        </div>
    </div>
    <div class="row mt-2 card card-body">
        <div class="row">
            <div class="col-3">
                <label for="divQuestion1" class="font-weight-bold">Question 1</label>
                <div id="divQuestion1"></div>
            </div>
            <div class="col-6">
                <label for="divAnswer1">Answer 1</label>
                <div id="divAnswer1"></div>
            </div>
        </div>
    </div>
    <div class="row mt-2 card card-body">
        <div class="row">
            <div class="col-3">
                <label for="divQuestion2" class="font-weight-bold">Question 2</label>
                <div id="divQuestion2"></div>
            </div>
            <div class="col-6">
                <label for="divAnswer2">Answer 2</label>
                <div id="divAnswer2"></div>
            </div>
        </div>
    </div>
    <div class="row mt-2 card card-body">
        <div class="row">
            <div class="col-3">
                <label for="divQuestion3" class="font-weight-bold">Question 3</label>
                <div id="divQuestion3"></div>
            </div>
            <div class="col-6">
                <label for="divAnswer3">Answer 3</label>
                <div id="divAnswer3"></div>
            </div>
        </div>
    </div>


         <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="editModalLabel">Edit About</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
               <div class="form-group">
                <label for="inputEditDescription">Citizen Science Description</label>
                <input type="text" class="form-control inputdescription" id="inputEditDescription" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Description must be ...
                </div>
              </div>  
              <div class="form-group">
                <label for="inputEditQuestion1">Question 1</label>
                <input type="text" class="form-control inputq1" id="inputEditQuestion1" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Question 1 must be ...
                </div>
              </div>  
              <div class="form-group">
                <label for="inputEditAnswer1">Answer 1</label>
                <input type="text" class="form-control inputa1" id="inputEditAnswer1" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Answer 1 must be ...
                </div>
              </div>  
              <div class="form-group">
                <label for="inputEditQuestion2">Question 2</label>
                <input type="text" class="form-control inputq2" id="inputEditQuestion2" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Question 2 must be ...
                </div>
              </div>  
              <div class="form-group">
                <label for="inputEditAnswer2">Answer 2</label>
                <input type="text" class="form-control inputa2" id="inputEditAnswer2" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Answer 2 must be ...
                </div>
              </div>  
              <div class="form-group">
                <label for="inputEditQuestion3">Question 3</label>
                <input type="text" class="form-control inputq3" id="inputEditQuestion3" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Question 3 must be ...
                </div>
              </div>  
              <div class="form-group">
                <label for="inputEditAnswer3">Answer 3</label>
                <input type="text" class="form-control inputa3" id="inputEditAnswer3" aria-describedby="nameCreateHelp">
                <div class="invalid-feedback">
                    Question 3 must be ...
                </div>
              </div>  
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="editClose">Close</button>
            <button type="button" class="btn btn-info" id="editSubmit">Save changes</button>
          </div>
        </div>
      </div>
    </div>

     <script>        
         $(document).ready(function () {

             RenderManageAboutPage();
             // This function fills out the contents of the Manage About page
            function RenderManageAboutPage()
            {
                $.ajax({
                    type: 'GET',
                    contentType: 'application/json',
                    url: '/api.asmx/About',
                    dataType: 'JSON',
                    success: function (responseData) {
<<<<<<< HEAD
                        console.log(responseData)
                        $("#divDescription").html(responseData.Description);// = responseData.Description;
                        $("#divQuestion1").html(responseData.Question1);// = responseData.Question1;
                        $("#divQuestion2").html(responseData.Question2);// = responseData.Question2;
                        $("#divQuestion3").html(responseData.Question3);// = responseData.Question3;
                        $("#divAnswer1").html(responseData.Answer1);// = responseData.Answer1;
                        $("#divAnswer2").html(responseData.Answer2);// = responseData.Answer2;
                        $("#divAnswer3").html(responseData.Answer3);// = responseData.Answer3;                                   
=======

                        console.log(responseData);
                        $("#divDescription") = responseData.Description;
                        $("#divQuestion1") = responseData.Question1;
                        $("#divQuestion2") = responseData.Question2;
                        $("#divQuestion3") = responseData.Question3;
                        $("#divAnswer1") = responseData.Answer1;
                        $("#divAnswer2") = responseData.Answer2;
                        $("#divAnswer3") = responseData.Answer3;                                   
>>>>>>> fb35ed13b5217a5900225965f4fdf3721d1ffd8f
                    },
                    error: function (errorData) {
                        console.log('getting ERROR');
                        console.log(errorData);
                    }
                });
            }

            // This function fills out the fields in the 'Edit Modal' before displaying it
            function PopulateEditModal(data) {
                $('#inputEditDescription').val(data.Description);
                $('#inputEditQuestion1').val(data.Question1);
                $('#inputEditQuestion2').val(data.Question2);
                $('#inputEditQuestion3').val(data.Question3);
                $('#inputEditAnswer1').val(data.Answer1);
                $('#inputEditAnswer2').val(data.Answer2);
                $('#inputEditAnswer3').val(data.Answer3);
            }

            // The function when the 'Create New Admin' button gets clicked
             $('#editAbout').click(function () {
                $.ajax({
                    url: "/api.asmx/About",
                    success: function (data) {
                        PopulateEditModal(data);
                    }
                });              

                //Display the modal
                $('#editModal').modal('show');
            });

            function BuildEditAbout() {
                var Description = $('#inputEditDescription').val();             
                var Question1 = $('#inputEditQuestion1').val();             
                var Question2 = $('#inputEditQuestion2').val();             
                var Question3 = $('#inputEditQuestion3').val();             
                var Answer1 = $('#inputEditAnswer1').val();             
                var Answer2 = $('#inputEditAnswer2').val();             
                var Answer3 = $('#inputEditAnswer3').val();             

                return {
                    description: Description,
                    question1: Question1,
                    question2: Question2,
                    question3: Question3,
                    answer1: Answer1,
                    answer2: Answer2,
                    answer3: Answer3
                };
            }

            function ValidateAboutRequest(requestData) {
                $('.inputdescription').removeClass('is-invalid');
                $('.inputq1').removeClass('is-invalid');
                $('.inputq2').removeClass('is-invalid');
                $('.inputq3').removeClass('is-invalid');
                $('.inputa1').removeClass('is-invalid');
                $('.inputa2').removeClass('is-invalid');
                $('.inputa3').removeClass('is-invalid');

                var regexDescription = /[A-Za-z0-9 _.,!"'/$]*/;
                var regexQuestion1 = /[A-Za-z0-9 _.,!"'/$]*/;
                var regexQuestion2 = /[A-Za-z0-9 _.,!"'/$]*/;
                var regexQuestion3 = /[A-Za-z0-9 _.,!"'/$]*/;
                var regexAnswer1 = /[A-Za-z0-9 _.,!"'/$]*/;
                var regexAnswer2 = /[A-Za-z0-9 _.,!"'/$]*/;
                var regexAnswer3 = /[A-Za-z0-9 _.,!"'/$]*/;

                hasValidDescription = regexDescription.test(requestData.description);
                hasValidQuestion1 = regexQuestion1.test(requestData.question1);
                hasValidQuestion2 = regexQuestion2.test(requestData.question2);
                hasValidQuestion3 = regexQuestion3.test(requestData.question3);
                hasValidAnswer1 = regexAnswer1.test(requestData.answer1);
                hasValidAnswer2 = regexAnswer2.test(requestData.answer2);
                hasValidAnswer3 = regexAnswer3.test(requestData.answer3);

                console.log("Valid Description: " + hasValidDescription);
                console.log("Valid Question 1: " + hasValidQuestion1);
                console.log("Valid Question 2: " + hasValidQuestion2);
                console.log("Valid Question 3: " + hasValidQuestion3);
                console.log("Valid Answer 1: " + hasValidAnswer1);
                console.log("Valid Answer 2: " + hasValidAnswer2);
                console.log("Valid Answer 3: " + hasValidAnswer3);

                if (hasValidDescription) {
                    $('.inputdescription').addClass('is-valid');
                } else {
                    $('.inputdescription').addClass('is-invalid');
                }

                if (hasValidQuestion1) {
                    $('.inputq1').addClass('is-valid');
                } else {
                    $('.inputq1').addClass('is-invalid');
                }

                if (hasValidQuestion2) {
                    $('.inputq2').addClass('is-valid');
                } else {
                    $('.inputq2').addClass('is-invalid');
                }

                if (hasValidQuestion3) {
                    $('.inputq3').addClass('is-valid');
                } else {
                    $('.inputq3').addClass('is-invalid');
                }

                if (hasValidAnswer1) {
                    $('.inputa1').addClass('is-valid');
                } else {
                    $('.inputa1').addClass('is-invalid');
                }

                if (hasValidAnswer2) {
                    $('.inputa2').addClass('is-valid');
                } else {
                    $('.inputa2').addClass('is-invalid');
                }

                if (hasValidAnswer3) {
                    $('.inputa3').addClass('is-valid');
                } else {
                    $('.inputa3').addClass('is-invalid');
                }

                return (hasValidDescription && hasValidQuestion1 && hasValidQuestion2 && hasValidQuestion3 && hasValidAnswer1 && hasValidAnswer2 && hasValidAnswer3);
            }

            $('#editSubmit').click(function () {
                var requestData = BuildEditAbout()
                var isValidRequest = ValidateAboutRequest(requestData);
                console.log('Is Edit Form Submission Valid?: ' + isValidRequest);
                console.log(requestData)

                if (isValidRequest) {
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: '/api.asmx/UpdateAbout',
                        data: JSON.stringify(requestData),
                        dataType: 'JSON',
                        success: function (responseData) {
                            console.log('SUCCESS');
                            console.log(responseData);

                            $('#editModal').modal('hide');
                            RenderManageAboutPage();
                        },
                        error: function (errorData) {
                            console.log('ERROR');
                            console.log(errorData);
                        }
                    });
                }

            });

            $('#editModal').on('hidden.bs.modal', function (e) {
                $('.inputdescription').removeClass('is-invalid');
                $('.inputdescription').removeClass('is-valid');

                $('.inputq1').removeClass('is-invalid');
                $('.inputq1').removeClass('is-valid');

                $('.inputq2').removeClass('is-invalid');
                $('.inputq2').removeClass('is-valid');

                $('.inputq3').removeClass('is-invalid');
                $('.inputq3').removeClass('is-valid');

                $('.inputa1').removeClass('is-invalid');
                $('.inputa1').removeClass('is-valid');

                $('.inputa2').removeClass('is-invalid');
                $('.inputa2').removeClass('is-valid');

                $('.inputa3').removeClass('is-invalid');
                $('.inputa3').removeClass('is-valid');
            });
        });
    </script>
</asp:Content>
