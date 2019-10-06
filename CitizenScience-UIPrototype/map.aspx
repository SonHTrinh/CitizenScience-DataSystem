<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="CitizenScience_UIPrototype.map" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Map   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="container-fluid">
        <div class="row">
             <section class="jumbotron text-center w-100" >
                <div class="container">
                    <h1 class="jumbotron-heading">Welcome to Citizen Science</h1>            
                </div>
            </section>  
            <!--
            <div class="col-12">
                <h1 style="text-align: center">Welcome to Citizen Science</h1>
            </div>
            -->
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
            <div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="max-width: 200%;">
                    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <p><img src="img" alt="Here should be a picture of the watershed" class="modalImage" style="width: 400px; height: 333px" /></p>
                                            <p class="modalLink"></p>
                                            <p class="modalDesc"></p>
                                        </div>
                                        <div class="col-md-1"></div>
                                        <div class="col-md-7 ml-auto">
                                            <canvas id="myChart" style="width: 570px; height: 340px;"></canvas>
                                            <br /><input type="radio" id="radioC" name="temperature" checked="checked"/> Celsius
                                            <br /><input type="radio" id="radioF" name="temperature" /> Fahrenheit
                                            <br /><br />
                                            <label>From:</label>
                                            <input type="date" />
                                            <label>To:</label>
                                            <input type="date"/>
                                            <button>Reset</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary">Download Temperature File</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
            </div> 
            <div class="col-12">
                
            </div>
                
        </div>

    </div>
    <div id="map" class="shadow-lg p-3 mb-5 bg-white rounded"></div>

    <script>
        $(function () {
            var map = initMap();
            var prevInfo = false;

            function buildMarker(location) {

                // TODO: find a better way to do this than call and map all locations to thier watersheds
                $.ajax({
                    url: "api.asmx/Watersheds",
                    success: function (responseData) {
                        var locationWatershedMapping = new Map();

                        responseData.forEach(function (watershed) {
                            locationWatershedMapping.set(watershed.WatershedID, watershed.WatershedName);
                        });

                        var locationInfowindow = new google.maps.InfoWindow({
                            content: "<h6><b>" + location.SensorName + "</b></h6>"
                                + "<img src='/img/Watershed/Watershed01.jpg' width='300' height='200' />" + "<br /><br />"
                                + "<h6><b>Watershed:</b> " + locationWatershedMapping.get(location.WatershedID) + "</h6>"
                                + "<br/>"
                                + "<b>Latitude: </b>" + location.Latitude
                                + "<br/>"
                                + "<b>Longitude: </b>" + location.Longitude
                                + "<br/><br/>"
                                + "<b>**Click on the marker to see more details**</b>"
                                //+ "<br/> <br/>"
                                //+ "<a href='#' data-toggle='modal' data-target='#locationModal'>more details >></a>"
                            //Dummy profile picture 
                        });

                        var marker = new google.maps.Marker({
                            position: { lat: location.Latitude, lng: location.Longitude },
                            animation: google.maps.Animation.DROP,
                            map: theMap,
                            title: location.SensorName,
                            infowindow: locationInfowindow
                        });

                        google.maps.event.addListener(marker, 'mouseover', function () {
                            if (prevInfo) {
                                prevInfo.close();
                            }
                            this.infowindow.open(map, this);
                            prevInfo = this.infowindow;
                        });

                        /*google.maps.event.addListener(marker, 'mouseout', function () {

                            this.infowindow.close();

                        });*/

                        google.maps.event.addListener(marker, 'closeclick', function () {
                            this.infowindow.close();
                        });

                        google.maps.event.addListener(marker, 'click', function () {
                            initModal();
                            $('#locationModal').modal('show');
                        });

                        //Modal
                        function initModal() {
                            //title
                            var title = location.SensorName + " - " + locationWatershedMapping.get(location.WatershedID);
                            $(".modal-title").text(title);

                            //desc
                            var description = "Description about the watershed: " + location.SensorName + " - " + locationWatershedMapping.get(location.WatershedID)+ " (" + location.Latitude + ", " + location.Longitude + ")";
                            $(".modalDesc").text(description);

                            //image
                            var imageSrc = "img/Watershed/Watershed1.jpg";
                            var imageAlt = "The Picture of the " + locationWatershedMapping.get(location.WatershedID);
                            $(".modalImage").attr("src", imageSrc);
                            $(".modalImage").attr("alt", imageAlt);

                            //more pictures link
                            $('.modalLink').html('<a href="gallery.aspx">more picture >></a>');

                            //temperture format radio buttons
                            if ($('#radioC').is(':checked')) {
                                initCGraph();
                            }
                            else if($('#radioF').is(':checked')){
                                initFGraph();
                            }
                            $('#radioC').click(function () {
                                initCGraph();
                            });
                            $('#radioF').click(function () {
                                initFGraph();
                            });
                        }
                    }
                });
            }
          
            function initMap() {
                theMap = new google.maps.Map(document.getElementById('map'), {
                    center: new google.maps.LatLng(40.0319, -75.1134),
                    zoom: 11
                });

                $.ajax({
                    url: "/api.asmx/AllLocations",
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            var locationObj = data[i];

                            buildMarker(locationObj);
                        }
                    }
                });

                return theMap;
            }

            //todo: handle failure

            $.ajax({
                url: "/api.asmx/Watersheds",
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
                    url: "/api.asmx/Location?watershedId=" + watershedId,
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

            function initCGraph() {
                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        max: 50,
                        min: 0,
                        stepSize: 0,
                        labels: ["4/21/2019", "4/22/2019", "4/23/2019", "4/24/2019"],
                        datasets: [{
                            label: 'Sample Data(Celsius)',
                            data: [21, 14, 22, 16],
                            fill: false,
                            borderColor: '#F08080',
                            backgroundColor: '#E9C9D1',
                            borderWidth: 1
                        }]
                    },
                    options: {}
                });
            }

            function initFGraph() {
                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        max: 50,
                        min: 0,
                        stepSize: 0,
                        labels: ["4/21/2019", "4/22/2019", "4/23/2019", "4/24/2019"],
                        datasets: [{
                            label: 'Sample Data(Fahrenheit)',
                            data: [70, 57, 72, 61],
                            fill: false,
                            borderColor: '#008080',
                            backgroundColor: '#D1E9C9',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        //scales: {
                        //    xAxes: [{
                        //        ticks: {
                        //            min: '4/21/2019',
                        //            max: '4/22/2019',
                        //        },
                        //        stacked: true,
                        //        gridLines: {
                        //            display: false,
                        //        }
                        //    }],
                        //}
                     }
                });
            }

        });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp7tBTG5O-LXpXR7BL01PlEB63wBC0PSA&callback=initMap"
        async defer></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

</asp:Content>
