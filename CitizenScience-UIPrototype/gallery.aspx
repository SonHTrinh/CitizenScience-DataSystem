<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="CitizenScience_UIPrototype.gallery" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Gallery   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <!--Na's links-->
    <link href="./css/album.css" rel="stylesheet">
    <link rel="stylesheet" href="/style/custom/galleryAPI-style.css" />
    <!--//-->
    <main role="main">
        <!--Location modal-->
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Locations</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="slideshow-container">
                            <div class="mySlides1">
                                <img src="/img/Watershed/Watershed02.jpg" style="width: 100%; display: block;" />
                                <p></p>
                            </div>
                            <a class="prev" onclick="plusSlides(-1, 0)">&#10094;</a>
                            <a class="next" onclick="plusSlides(1, 0)">&#10095;</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Volunteer modal-->
        <div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle2">Volunteers</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="slideshow-container">
                            <div class="mySlides2">
                                <img src="img" style="width: 100%; display: block; margin-left: auto; margin-right: auto;">
                                <p></p>
                            </div>
                            <a class="prev" onclick="plusSlides(-1, 1)">&#10094;</a>
                            <a class="next" onclick="plusSlides(1, 1)">&#10095;</a>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <section class="jumbotron text-center w-100">
                <div class="container">
                    <h1 class="jumbotron-heading">Photo Gallery</h1>
                    <p>
                        <a href="#" class="btn btn-dark my-2" onclick="myFunction3()">Show All</a>
                        <a href="#" class="btn btn-dark my-2" onclick="myFunction()">Locations</a>
                        <a href="#" class="btn btn-dark my-2" onclick="myFunction2()">Volunteer</a>
                    </p>
                </div>
            </section>
        </div>

        <%--<div id="myDIV" style="width: 90%; margin: auto;">
            <div class="album py-5 bg-light">
                <div class="container">
                    <h2>Watershed locations</h2>
                    <hr />
                    <br />
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img src="img/Watershed/Watershed4.jpg" alt="Watershed">
                                <div class="card-body">
                                    Pennypack Creek Watershed
                      <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                              <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModalCenter">View</button>
                          </div>
                          <small class="text-muted">3</small>
                      </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img src="img/Watershed/Watershed5.jpg" alt="Watershed">
                                <div class="card-body">
                                    Poquessing Creek Watershed
                      <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                              <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModalCenter">View</button>
                          </div>
                          <small class="text-muted">3</small>
                      </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img src="img/Watershed/Watershed6.jpg" alt="Watershed">
                                <div class="card-body">
                                    Wissahickon Creek Watershed
                      <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                              <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModalCenter">View</button>
                          </div>
                          <small class="text-muted">3</small>
                      </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="myDIV2" style="width: 90%; margin: auto;">
            <div class="album py-5 bg-light">
                <div class="container">
                    <h2>Volunteers</h2>
                    <hr />
                    <br />
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img src="img/Volunteer/Volunteer4.jpg" alt="Volunteer">
                                <div class="card-body">
                                    Volunteers in Pennypack Creek Watershed
                      <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                              <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModalCenter2">View</button>
                          </div>
                          <small class="text-muted">3</small>
                      </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img src="img/Volunteer/Volunteer4.jpg" alt="Volunteer">
                                <div class="card-body">
                                    Volunteers in Poquessing Creek Watershed
                      <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                              <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModalCenter2">View</button>
                          </div>
                          <small class="text-muted">3</small>
                      </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img src="img/Volunteer/Volunteer4.jpg" alt="Volunteer">
                                <div class="card-body">
                                    Volunteers in Wissahickon Creek Watershed
                      <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                              <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModalCenter2">View</button>
                          </div>
                          <small class="text-muted">3</small>
                      </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>

        <div class="contrainer">
            <div id="album-placeholder" class="container"></div>
            <asp:DataList ID="rptAlbum" runat="server" RepeatLayout="Table" RepeatColumns="3">
                <ItemTemplate>
                    <table border="0">
                        <tr>
                            <td>
                                <!--Watershed location name-->
                                <p class="album-name"></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <!--Location profile picture-->
                                <img src="img" alt="" class="album-image" style="width: 400px; height: 333px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p class="album-desc"></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#" target="#exampleModalCenter" class="btn btn-outline-dark">View</a>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </div>

    </main>

    <script>
        function myFunction() {
            var x = document.getElementById("myDIV");
            var y = document.getElementById("myDIV2");
            x.style.display = "block";
            y.style.display = "none"
        }
        function myFunction2() {
            var x = document.getElementById("myDIV");
            var y = document.getElementById("myDIV2");
            x.style.display = "none";
            y.style.display = "block";
        }
        function myFunction3() {
            var x = document.getElementById("myDIV");
            var y = document.getElementById("myDIV2");
            x.style.display = "block";
            y.style.display = "block";
        }

        var slideIndex = [1, 1];
        var slideId = ["mySlides1", "mySlides2"]
        showSlides(1, 0);
        showSlides(1, 1);

        function plusSlides(n, no) {
            showSlides(slideIndex[no] += n, no);
        }

        function showSlides(n, no) {
            var i;
            var x = document.getElementsByClassName(slideId[no]);
            if (n > x.length) { slideIndex[no] = 1 }
            if (n < 1) { slideIndex[no] = x.length }
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            x[slideIndex[no] - 1].style.display = "block";
        }

        $(function buildAlbum(album) {
            $.ajax({
                url: "<%= Global.Url_Prefix() %>/api.asmx/AllAlbum",
                /*success: function (data) {
                    console.log(data);
                    var placehold = $('#iii');
                    var albumTitle = $(".album-name");
                    var albumDesc = $(".album-desc");

                    for (var i = 0; i < data.length; i++) {
                        console.log(data[i]);
                        var newElement = $(document.createElement('p'));
                        newElement.text(data.albumName);
                        placehold.append(newElement);
                    }

                }*/
                success: function(responseData) {
                    var numOfAlbums = responseData.length;
                    var numOfColumnsPerRow = 3;
                    var numOfRows = Math.ceil(numOfAlbums / numOfColumnsPerRow);
                    var albumIteration = 0;

                    for (var i = 0; i <= numOfRows; i++) {

                        var row = $(document.createElement('div')).addClass('row').addClass('mb-2');

                        for (var j = 0; j < numOfColumnsPerRow && albumIteration < numOfAlbums; j++) {

                            var column = $(document.createElement('div')).addClass('col-4');

                            var nestedRow1 = $(document.createElement('div')).addClass('row').addClass('justify-content-center');
                            var imgURL = "/img/Watershed/watershed01.jpg";
                            var image = $(document.createElement('img')).attr('src', imgURL);
                            nestedRow1.append(image);

                            var nestedRow2 = $(document.createElement('div')).addClass('row').addClass('justify-content-center');
                            var titleText = responseData[albumIteration].Name;
                            var titleElement = $(document.createElement('p')).addClass('font-weight-bold');
                            titleElement.text(titleText);
                            nestedRow2.append(titleElement);

                            var nestedRow3 = $(document.createElement('div')).addClass('row').addClass('justify-content-center');
                            var descriptionText = responseData[albumIteration].Description;
                            var descriptionElement = $(document.createElement('p'));
                            descriptionElement.text(descriptionText);
                            nestedRow3.append(descriptionElement);

                            var nestedRow4 = $(document.createElement('div')).addClass('row').addClass('justify-content-left');
                            var view = $(document.createElement('a'));
                            view.addClass('btn btn-outline-dark');
                            view.text('View');
                            view.attr('href', '#');
                            view.attr('data-toggle', 'modal');
                            view.attr('data-target', '#exampleModalCenter');
                            nestedRow4.append(view);

                            column.append(nestedRow1);
                            column.append(nestedRow2);
                            column.append(nestedRow3);
                            column.append(nestedRow4);

                            row.append(column);
                            albumIteration++;
                        }
                        
                        $('#album-placeholder').append(row);
                    }
                }
            });

            function initAlbum() {
                //title
                var title = album.Name;
                //$(".album-name").text(title);

                //desc
                var desc = album.Description;
                //$(".album-desc").text(desc);

                //image
                var imageSrc;

            }

            function initModal() {

            }
        });

    </script>

</asp:Content>
