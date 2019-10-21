<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="CitizenScience_UIPrototype.map" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
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
        </div>
        <div class="row my-4">
            <div class="col-3 offset-3">
                <div class="dropdown float-right">
                  <button class="btn btn-dark dropdown-toggle px-5 py-2" type="button" id="ddBtnWatershed" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Watersheds
                  </button>
                  <div class="dropdown-menu" id="ddMenuWatershed" aria-labelledby="dropdownMenuButton"></div>
                </div>
            </div>
            <div class="col-3">
                <div class="dropdown float-left invisible" id="locationdiv">
                  <button class="btn btn-dark dropdown-toggle px-5 py-2" type="button" id="ddBtnLocation" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
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
                                            From: <input type="text" id="start_datepicker" required>
                                            To: <input type="text" id="end_datepicker" required>
                                            <button type="button" id="submit" class="btn btn-danger btn-sm">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" id="downloadCsv" class="btn btn-dark">
                                    <i class="fa fa-file-csv">&nbsp; Download Temperature CSV File</i>
                                </button>
                                <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
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
            $("#start_datepicker").datepicker({
                dateFormat: 'mm-dd-yy'
            });
            $("#end_datepicker").datepicker({
                dateFormat: 'mm-dd-yy'
            });
        });

        $(function () {
            var map = initMap();

            //close last window
            var prevInfo = false;

            //set date
            //var e = new Date();
            //var ed = getFormattedDate(e);
            //var s = new Date();
            //s.setDate(e.getDate() - 7 );
            //var sd = getFormattedDate(s);

            function buildMarker(location) {

                // TODO: find a better way to do this than call and map all locations to thier watersheds
                $.ajax({
                    url: "<% Global.URLPREFIX.ToString(); %>/api.asmx/Watersheds",
                    success: function (responseData) {
                        var locationWatershedMapping = new Map();

                        responseData.forEach(function (watershed) {
                            locationWatershedMapping.set(watershed.WatershedID, watershed.WatershedName);
                        });



                        var locationInfowindow = new google.maps.InfoWindow({
                            content: "<h6><b>" + location.SensorName + "</b></h6>"
                                + "<img src='/images/location/get.ashx?locationid=" + location.LocationID +"' width='300' height='200' />" + "<br /><br />"
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
                            var imageSrc = "/images/location/get.ashx?locationid=" + location.LocationID;
                            var imageAlt = "The Picture of the " + locationWatershedMapping.get(location.WatershedID);
                            $(".modalImage").attr("src", imageSrc);
                            $(".modalImage").attr("alt", imageAlt);

                            //more pictures link
                            $('.modalLink').html('<a href="gallery.aspx">more picture >></a>');

                            //temperture radio buttons default settings
                            if ($('#radioC').is(':checked')) {
                                var startDate = $('#start_datepicker').val();
                                var endDate = $('#end_datepicker').val();
                                if ((startDate == "") || (endDate == "")) {
                                    //initCGraph(location.LocationID, sd, ed);
                                    initCGraph(1, "04-24-2019", "04-25-2019");
                                }
                                else {
                                    //initCGraph(location.LocationID, startDate, endDate);
                                    initCGraph(1, startDate, endDate);
                                }
                            }
                            else if($('#radioF').is(':checked')){
                                var startDate = $('#start_datepicker').val();
                                var endDate = $('#end_datepicker').val();
                                if ((startDate == "") || (endDate == "")) {
                                    //initFGraph(location.LocationID, sd, ed);
                                    initFGraph(1, "04-24-2019", "04-25-2019");
                                }
                                else {
                                    //initFGraph(location.LocationID, startDate, endDate);
                                    initFGraph(1, startDate, endDate);
                                }
                            }

                            //temperature radio buttons click event
                            $('#radioC').click(function () {
                                var startDate = $('#start_datepicker').val();
                                var endDate = $('#end_datepicker').val();
                                if ((startDate == "") || (endDate == "")) {
                                    //initCGraph(location.LocationID, sd, ed);
                                    initCGraph(1, "04-24-2019", "04-25-2019");
                                }
                                else {
                                    //initCGraph(location.LocationID, startDate, endDate);
                                    initCGraph(1, startDate, endDate);
                                }
                            });
                            $('#radioF').click(function () {
                                var startDate = $('#start_datepicker').val();
                                var endDate = $('#end_datepicker').val();
                                if ((startDate == "") || (endDate == "")) {
                                    //initFGraph(location.LocationID, sd, ed);
                                    initFGraph(1, "04-24-2019", "04-25-2019");
                                }
                                else {
                                    //initFGraph(location.LocationID, startDate, endDate);
                                    initFGraph(1, startDate, endDate);
                                }
                            });

                            //Submit button
                            $('#submit').click(function () {
                                var startDate = $('#start_datepicker').val();
                                var endDate = $('#end_datepicker').val();
                                if( (startDate == "") || (endDate == "")){
                                    alert("Please select a date range!");
                                }
                                if ((startDate != "") && (endDate != "")) {
                                    if ($('#radioC').is(':checked')) {
                                        //initCGraph(location.LocationID, startDate, endDate);
                                        initCGraph(1, startDate, endDate);
                                    }
                                    else if ($('#radioF').is(':checked')) {
                                        //initFGraph(location.LocationID, startDate, endDate);
                                        initFGraph(1, startDate, endDate);
                                    }
                                }
                            });

                            ////Reset button
                            //$('#reset').click(function () {
                            //}

                            //Download button
                            $('#downloadCsv').click(function () {
                                window.location.href = '<% Global.URLPREFIX.ToString(); %>/api.asmx/AllLocationTemperaturesCsv';                                
                                var endDate = $('#end_datepicker').val();
                                var startDate = $('#start_datepicker').val();
                                //  If Start and End dates not specified...
                                if (startDate == "" && endDate == "")
                                    downloadTempDataNoStartNoEnd(location.LocationID);
                                //  If Start not specified and End specified...
                                else if (startDate == "" && endDate != "")
                                    downloadTempDataNoStartEnd(location.LocationID, endDate);
                                //  If Start specified and End not specified...
                                else if (startDate != "" && endDate == "")
                                    downloadTempDataStartNoEnd(location.LocationID, startDate);
                                //  If both Start and End specified...
                                else if (startDate != "" && endDate != "")
                                    downloadTempDataStartEnd(location.LocationID, startDate, endDate);  
                            });

                            //Close Modal
                            $('#locationModal').on('hidden.bs.modal', function () {
                                //radio button setting
                                $('#radioC').prop('checked', true);
                                $('#radioF').prop('checked', false);

                                //datepicker setting
                                $('#end_datepicker').val("");
                                $('#start_datepicker').val("");
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
                    url: "<% Global.URLPREFIX.ToString(); %>/api.asmx/AllLocations",
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
                    url: "<% Global.URLPREFIX.ToString(); %>/api.asmx/Location?watershedId=" + watershedId,
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

            function initCGraph(id, start, end) {
                var data = {
                    locationId: id,
                    start: start,
                    end: end
                };
                // Send temperature data request
                $.ajax({
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    url: '<% Global.URLPREFIX.ToString(); %>/api.asmx/GetLocationTemperaturesByDateRange',
                    data: JSON.stringify(data),
                    success: function (responseData) {
                        //Store the timestamp and the temperatures of server response
                        var dateLabelArray = [];
                        var temperatureArray = [];
                        //Add the timestamp and temperature pairs into the variables
                        responseData.forEach(function (temperature) {
                            dateLabelArray.push(temperature.Timestamp);
                            temperatureArray.push(temperature.Celsius);
                        });
                        //Get the element to hold the chart
                        var ctx = document.getElementById("myChart").getContext('2d');
                        //Create the chart and pass in the timestamp array as labels and the temperature array for data
                        var myChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                max: 50,
                                min: 0,
                                stepSize: 0,
                                labels: dateLabelArray,
                                datasets: [{
                                    label: 'Sample Data(Celsius)',
                                    data: temperatureArray,
                                    fill: false,
                                    borderColor: '#F08080',
                                    backgroundColor: '#E9C9D1',
                                    pointRadius: 0,
                                    borderWidth: 1
                                }]
                            },
                            options: {}
                        });
                    },
                    error: function (errorData) {
                        console.log('ERROR');
                        console.log(errorData);
                    }
                });
            }
            
            function initFGraph(id, start, end) {
                var data = {
                    locationId: id,
                    start: start,
                    end: end
                };
                $.ajax({
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    url: '<% Global.URLPREFIX.ToString(); %>/api.asmx/GetLocationTemperaturesByDateRange',
                    data: JSON.stringify(data),
                    success: function (responseData) {
                        var dateLabelArray = [];
                        var temperatureArray = [];
                        responseData.forEach(function (temperature) {
                            dateLabelArray.push(temperature.Timestamp);
                            temperatureArray.push(temperature.Fahrenheit);
                        });
                        var ctx = document.getElementById("myChart").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                max: 50,
                                min: 0,
                                stepSize: 0,
                                labels: dateLabelArray,
                                datasets: [{
                                    label: 'Sample Data(Fahrenheit)',
                                    data: temperatureArray,
                                    fill: false,
                                    borderColor: '#186A3B',
                                    backgroundColor: '#D1E9C9',
                                    pointRadius: 0,
                                    borderWidth: 1
                                }]
                            },
                            options: {}
                        });
                    },
                    error: function (errorData) {
                        console.log('ERROR');
                        console.log(errorData);
                    }
                });
            }

            function getFormattedDate(date) {
                var year = date.getFullYear();

                var month = (1 + date.getMonth()).toString();
                month = month.length > 1 ? month : '0' + month;

                var day = date.getDate().toString();
                day = day.length > 1 ? day : '0' + day;
                return month + '-' + day + '-' + year;
            }

            function downloadTempDataNoStartNoEnd(locationID) {
                //  Download all Temperature data for selected Location
                window.location.href = '/api.asmx/LocationTemperaturesCsv?locationId' + locationID;
            }
            function downloadTempDataStartNoEnd(locationID, startDate) {
                //  Download all Temperature data for selected Location from startDate onward
                alert("NO END");
            }
            function downloadTempDataNoStartEnd(locationID, endDate) {
                //  Download all Temperature data for selected Location beginning of data recording to endDate
                alert("NO START");
            }
            function downloadTempDataStartEnd(locationID, startDate, endDate) {
                //  Download all Temperature data for selected Location from startDate to endDate
                alert("START, END");
            }
        });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp7tBTG5O-LXpXR7BL01PlEB63wBC0PSA&callback=initMap"
        async defer></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    
    <%--datepicker--%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</asp:Content>
