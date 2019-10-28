<%@ Page Title="" Language="C#" MasterPageFile="~/CitizenScience.Master" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="CitizenScience_UIPrototype.map" %>
<%@ Import Namespace="CitizenScience_UIPrototype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="titleName" runat="server">
    Map   |   Citizen Science
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main_content" runat="server">
    <div class="container-fluid">
        <div class="row my-3">
            <div class="col-12 text-center">
                <h1>Welcome to Citizen Science</h1>
            </div>
        </div>
        <div class="row my-4">
            <div class="col-6">
                <div class="dropdown float-right">
                  <button class="btn btn-dark dropdown-toggle px-5 py-2" type="button" id="ddBtnWatershed" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Watersheds
                  </button>
                  <div class="dropdown-menu" id="ddMenuWatershed" aria-labelledby="dropdownMenuButton"></div>
                </div>
            </div>
            <div class="col-6">
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
                                        <div class="col-4">
                                            <div class="row">
                                                <div class="col-12">
                                                    <img src="img" alt="Here should be a picture of the watershed" class="modalImage" style="max-width: 100%; max-height: 100%;"  />
                                                </div>
                                                
                                            </div>
                                            <div class="row mt-4">
                                                <div class="col-12">
                                                    <p class="modalLink"></p>
                                                </div>
                                            </div>
                                            <div class="row mt-4">
                                                <div class="col-12">
                                                    <p class="modalDesc"></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-8">
                                            <div class="row">
                                                <canvas id="myChart" style="width: 570px; height: 340px;" />
                                            </div>
                                            
                                            <div class="row mt-2">
                                                <div class="col-12">
                                                    <div class="custom-control custom-radio">
                                                        <input type="radio" value="" id="radioC" class="custom-control-input" name="temperature" checked="checked"/>
                                                        <label class="custom-control-label" for="radioC">Celsius</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input type="radio" value="" id="radioF" class="custom-control-input" name="temperature"/>
                                                        <label class="custom-control-label" for="radioF">Fahrenheit</label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row mt-2">
                                                <div class="col-4">
                                                    <input type="text" class="form-control" id="start_datepicker" required>
                                                </div>
                                                <div class="col-1 text-center mx-0 px-0">
                                                    <p>-</p>
                                                </div>
                                                <div class="col-4">
                                                    <input type="text" class="form-control" id="end_datepicker" required>
                                                </div>
                                                <div class="col-3 text-center">
                                                    <button type="button" id="submit" class="btn btn-primary">Search</button>
                                                </div>
                                            </div>
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
    <div id="map" class="shadow-lg p-3 mb-5 bg-white rounded" ></div>
    

    <script>
        $(function () {
            var map = initMap();

            //close last window
            var prevInfo = false;

            $("#start_datepicker").datepicker({
                dateFormat: 'mm-dd-yy'
            });
            $("#end_datepicker").datepicker({
                dateFormat: 'mm-dd-yy'
            });

            //set date
            //var e = new Date();
            //var ed = getFormattedDate(e);
            //var s = new Date();
            //s.setDate(e.getDate() - 7 );
            //var sd = getFormattedDate(s);

            function buildMarker(location) {

                // TODO: find a better way to do this than call and map all locations to thier watersheds
                $.ajax({
                    url: "<%= Global.Url_Prefix() %>/api.asmx/Watersheds",
                    success: function (responseData) {
                        var locationWatershedMapping = new Map();

                        responseData.forEach(function (watershed) {
                            locationWatershedMapping.set(watershed.WatershedID, watershed.WatershedName);
                        });



                        var locationInfowindow = new google.maps.InfoWindow({
                            content: "<h6><b>" + location.SensorName + "</b></h6>"
                                + "<img src='<%= Global.Url_Prefix() %>/images/location/get.ashx?locationid=" + location.LocationID +"' width='300' height='200' />" + "<br /><br />"
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
                            var imageSrc = "<%= Global.Url_Prefix() %>/images/location/get.ashx?locationid=" + location.LocationID;
                            var imageAlt = "The Picture of the " + locationWatershedMapping.get(location.WatershedID);
                            $(".modalImage").attr("src", imageSrc);
                            $(".modalImage").attr("alt", imageAlt);

                            //more pictures link
                            $('.modalLink').html('<a href="<%= Global.Url_Prefix() %>/gallery.aspx" class="btn btn-info btn-block">View Location Album</a>');

                            //Show graph by default after open it
                            if ($('#radioC').is(':checked')) {
                                //showLatestDate(location.LocationID);
                                showLatestDate(1, "C");
                            }
                            else if($('#radioF').is(':checked')){
                                showLatestDate(1, "F");
                            }

                            //temperature radio buttons click event
                            $('#radioC').click(function () {
                                var startDate = $('#start_datepicker').val();
                                var endDate = $('#end_datepicker').val();
                                if ((startDate == "") || (endDate == "")) {
                                    //showLatestDate(location.LocationID, "C");
                                    showLatestDate(1, "C");
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
                                    //showLatestDate(location.LocationID, "F");
                                    showLatestDate(1, "F");
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
                                window.location.href = '<%= Global.Url_Prefix() %>/api.asmx/AllLocationTemperaturesCsv';
                            });

                            //Close Modal
                            $('#locationModal').on('hidden.bs.modal', function () {
                                //radio button setting
                                $('#radioC').prop('checked', true);
                                $('#radioF').prop('checked', false);
                            });
                        }
                    }
                });
            }

            function initMap() {
                theMap = new google.maps.Map(document.getElementById('map'), {
                    center: new google.maps.LatLng(40.0319, -75.1134),
                    zoom: 10
                });

                $.ajax({
                    url: "<%= Global.Url_Prefix() %>/api.asmx/AllLocations",
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            var locationObj = data[i];

                            buildMarker(locationObj);
                        }
                    }
                });

                var pennypack = new google.maps.KmlLayer("https://gist.githubusercontent.com/tuf37823/97274aa5bbad9c8f65589eb41db1a265/raw/5b622d0876948447bc2a0e2d3c2835025d25670f/streams_pennypack.kml", {
                    suppressInfoWindows: true,
                    preserveViewport: false,
                    map: theMap
                });
/*
                var pennypackwatershed = new google.maps.KmlLayer("https://gist.githubusercontent.com/tuf37823/97274aa5bbad9c8f65589eb41db1a265/raw/5b622d0876948447bc2a0e2d3c2835025d25670f/watershed_pennypack.kml", {
                    suppressInfoWindows: true,
                    preserveViewport: false,
                    map: theMap
                });
*/

                var cobb = new google.maps.KmlLayer("https://gist.githubusercontent.com/tuf37823/97274aa5bbad9c8f65589eb41db1a265/raw/bb8cfaa2aa89713ebfb1d419a9eeeeb93dbf4aec/stream_cobb.kml", {
                    suppressInfoWindows: true,
                    preserveViewport: false,
                    map: theMap
                });

                var ttf = new google.maps.KmlLayer("https://gist.githubusercontent.com/tuf37823/97274aa5bbad9c8f65589eb41db1a265/raw/bb8cfaa2aa89713ebfb1d419a9eeeeb93dbf4aec/streams_ttf.kml", {
                    suppressInfoWindows: true,
                    preserveViewport: false,
                    map: theMap
                });

                var wissahickon = new google.maps.KmlLayer("https://gist.githubusercontent.com/tuf37823/97274aa5bbad9c8f65589eb41db1a265/raw/bb8cfaa2aa89713ebfb1d419a9eeeeb93dbf4aec/streams_wissahickon.kml", {
                    suppressInfoWindows: true,
                    preserveViewport: false,
                    map: theMap
                });



                return theMap;
            }

            //todo: handle failure

            $.ajax({
                url: "<%= Global.Url_Prefix() %>/api.asmx/Watersheds",
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
                    url: "<%= Global.Url_Prefix() %>/api.asmx/Location?watershedId=" + watershedId,
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
                    url: '<%= Global.Url_Prefix() %>/api.asmx/GetLocationTemperaturesByDateRange',
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
                        //checkRepeatedDate(dateLabelArray);
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
                                    label: 'Temperture Data(Celsius)',
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
                    url: '<%= Global.Url_Prefix() %>/api.asmx/GetLocationTemperaturesByDateRange',
                    data: JSON.stringify(data),
                    success: function (responseData) {
                        var dateLabelArray = [];
                        var temperatureArray = [];
                        responseData.forEach(function (temperature) {
                            dateLabelArray.push(temperature.Timestamp);
                            temperatureArray.push(temperature.Fahrenheit);
                        });
                        //checkRepeatedDate(dateLabelArray);
                        var ctx = document.getElementById("myChart").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                max: 50,
                                min: 0,
                                stepSize: 0,
                                labels: dateLabelArray,
                                datasets: [{
                                    label: 'Temperture Data(Fahrenheit)',
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

            function showLatestDate(id, Format) {
                if (Format == "C") {
                    $.get("<%= Global.Url_Prefix() %>/api.asmx/GetLocationLatestTemperature?locationid=" + id, function (response) {
                        console.log('Success getting latest temperature record:');
                        console.log(response);

                        var endDate = new Date(response.Timestamp);
                        var formattedEndDate = getFormattedDate(endDate);

                        var startDate = new Date(endDate);
                        startDate.setDate(endDate.getDate() - 7);
                        var formattedStartDate = getFormattedDate(startDate);

                        $('#end_datepicker').val(formattedEndDate);
                        $('#start_datepicker').val(formattedStartDate);

                        initCGraph(id, formattedStartDate, formattedEndDate);

                    }).fail(function (response) {
                        console.log('Error getting latest temperature record!');
                    });
                }
                else if (Format == "F") {
                    $.get("<%= Global.Url_Prefix() %>/api.asmx/GetLocationLatestTemperature?locationid=" + id, function (response) {
                        console.log('Success getting latest temperature record:');
                        console.log(response);

                        var endDate = new Date(response.Timestamp);
                        var formattedEndDate = getFormattedDate(endDate);

                        var startDate = new Date(endDate);
                        startDate.setDate(endDate.getDate() - 7);
                        var formattedStartDate = getFormattedDate(startDate);

                        $('#end_datepicker').val(formattedEndDate);
                        $('#start_datepicker').val(formattedStartDate);

                        initFGraph(id, formattedStartDate, formattedEndDate);

                    }).fail(function (response) {
                        console.log('Error getting latest temperature record!');
                    });
                }
            }

            function checkRepeatedDate(dateArray) {
                var date = "0";
                for (var i = 0; i < dateArray.length; i++) {
                    var nextDate = dateArray[i].substring(0, 10);
                    if (date != nextDate) {
                        date = nextDate;
                    }
                    else {
                        dateArray[i] = dateArray[i].substring(11, dateArray[i].length);
                    }
                }
            }
        });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCp7tBTG5O-LXpXR7BL01PlEB63wBC0PSA&callback=initMap"
        async defer></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    
    <%--datepicker--%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</asp:Content>
