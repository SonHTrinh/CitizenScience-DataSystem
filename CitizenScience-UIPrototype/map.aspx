<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="CitizenScience_UIPrototype.map" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Map   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <h1 style="text-align: center">Welcome to Citizen Science</h1>
            </div>
        </div>
        <div class="row my-4">
            <div class="col-3 offset-3">
                <div class="dropdown float-left">
                  <button class="btn btn-primary dropdown-toggle px-5 py-2" type="button" id="ddBtnWatershed" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Watersheds
                  </button>
                  <div class="dropdown-menu" id="ddMenuWatershed" aria-labelledby="dropdownMenuButton"></div>
                </div>
            </div>
            <div class="col-3">
                <div class="dropdown float-left invisible" id="locationdiv">
                  <button class="btn btn-primary dropdown-toggle px-5 py-2" type="button" id="ddBtnLocation" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                  <div class="dropdown-menu" id="ddMenuLocation" aria-labelledby="dropdownMenuButton"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <!--
            <div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="max-width: 200%;">
                    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="location">Tacony Creek Park</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <img src="img/Watershed/Watershed1.jpg" alt="bell-tower" style="width: 400px; height: 333px;" /><br />
                                            <a href="gallery.aspx">more pictures >></a>
                                            <p>On 302 acres, this narrow preserve offers creek views plus native trees & wildflowers.</p>
                                        </div>
                                        <div class="col-md-1"></div>
                                        <div class="col-md-7 ml-auto">
                                            <img src="img/graph.png" alt="graph" style="width: 570px; height: 340px;"/><br />
                                            <br />
                                            <label>From:</label>
                                            <input type="date"/>
                                            <label>To:</label>
                                            <input type="date"/>
                                            <button>Reset</button>
                                            <br /><input type="radio" name="temperature" checked="checked"/> Celsius
                                            <br /><input type="radio" name="temperature" /> Fahrenheit
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary">Download Temperature File</button>
                            </div>
                        </div>
                    </div>
            </div> -->
            <div class="col-12">
                
            </div>
                
        </div>

    </div>
    <div id="map" class="shadow-lg p-3 mb-5 bg-white rounded"></div>

    <script>
        var map;
        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: new google.maps.LatLng(40.0319, -75.1134),
                zoom: 11
            });

            $.ajax({
                url: "api.asmx/AllLocations",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {

                        var locationInfowindow = new google.maps.InfoWindow({
                            content: "<h6><b>" + data[i].SensorName + "</b></h6>"
                                    + "<img src='/img/Watershed/Watershed01.jpg' width='300' height='200' />" + "<br /><br />"
                                    + "<p>......Description......</p>"
                                    //Dummy profile picture 
                        });

                        var marker = new google.maps.Marker({
                            position: { lat: data[i].Latitude, lng: data[i].Longitude },
                            animation: google.maps.Animation.DROP,
                            map: map,
                            title: data[i].SensorName,
                            infowindow: locationInfowindow
                        });
                        google.maps.event.addListener(marker, 'click', function () {
                            this.infowindow.open(map, this);
                        });
                    }
                }
            });
        }

        $(function () {
            //todo: handle failure

            $.ajax({
                url: "api.asmx/Watersheds",
                success: populateWatersheds
            });

            function selectLocation(event) {
                $('#ddBtnLocation').text(event.data.SensorName);

                map.panTo({ lat: event.data.Latitude, lng: event.data.Longitude });
                map.setZoom(18);
            }

            function populateLocations(watershedId) {
                $('#ddMenuLocation').empty();
                $('#ddBtnLocation').text('Locations');

                $.ajax({
                    url: "api.asmx/Location?watershedId=" + watershedId,
                    success: function (data) {
                        console.log(data);
                        $('#locationdiv').removeClass('invisible');
                        var locationMenu = $('#ddMenuLocation');

                        for (var i = 0; i < data.length; i++) {
                            console.log(data[i]);
                            var newElement = $(document.createElement('a'));
                            newElement.addClass('dropdown-item');
                            newElement.text(data[i].SensorName);
                            newElement.attr('href', '#');
                            newElement.click(data[i], selectLocation);

                            locationMenu.append(newElement);
                        }     
                    }
                });

            }

            function selectWatershed(event) {
                $('#ddBtnWatershed').text(event.data.WatershedName);

                populateLocations(event.data.WatershedID);
            }

            function populateWatersheds(data) {
                var watershedObjList = data;
                var watershedMenu = $('#ddMenuWatershed');

                for (var i = 0; i < watershedObjList.length; i++) {
                    var newElement = $(document.createElement('a'));
                    newElement.addClass('dropdown-item');
                    newElement.text(watershedObjList[i].WatershedName);
                    newElement.attr('href', '#');
                    newElement.click(watershedObjList[i], selectWatershed);

                    watershedMenu.append(newElement);
                }      
            }

        });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp7tBTG5O-LXpXR7BL01PlEB63wBC0PSA&callback=initMap"
        async defer></script>

</asp:Content>
