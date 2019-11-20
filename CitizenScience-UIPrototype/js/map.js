var theMap;
var openInfoWindow;
var theChart;

initMap();

function hideTemperatureChart() {
	$('.temperature-chart').hide();
}

function hideTemperatureDownload() {
	$('.temperature-download').hide();
}

function initGraph(locationObj, temperatureScale, formattedStartDate, formattedEndDate) {
	var data = {
		locationId: locationObj.LocationID,
		start: formattedStartDate,
		end: formattedEndDate
	};

	if (theChart != undefined) {
		console.log('Destroying Chart');
		theChart.destroy();
	}

	$.ajax({
		type: 'POST',
		contentType: 'application/json; charset=utf-8',
		//		url: '<%= Global.Url_Prefix() %>/api.asmx/GetLocationTemperaturesByDateRange',
		url: 'api.asmx/GetLocationTemperaturesByDateRange',
		data: JSON.stringify(data),
		success: function (responseData) {
			var dateLabelArray = [];
			var temperatureArray = [];
			responseData.forEach(function (temperatureObj) {
				var date = new Date(temperatureObj.Timestamp);
				var dd = String(date.getDate()).padStart(2, '0');
				var mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
				var yyyy = date.getFullYear();

				date = mm + "-" + dd + "-" + yyyy;

				dateLabelArray.push(date);
				

				if (temperatureScale == "Fahrenheit") {
					temperatureArray.push(temperatureObj.Fahrenheit);
				} else {
					temperatureArray.push(temperatureObj.Celsius);
				}
			});

			var legendText = 'Degrees ' + temperatureScale;

			var ctx = document.getElementById("myChart").getContext('2d');
			theChart = new Chart(ctx, {
				type: 'line',
				data: {
					max: 2,
					min: 0,
					stepSize: 0,
					labels: dateLabelArray,
					datasets: [
						{
							data: temperatureArray,
							fill: false,
							borderColor: '#186A3B',
							backgroundColor: '#D1E9C9',
							pointRadius: 0,
							borderWidth: 1
						}
					]
				},
				options: {
					legend: {
						display: false
					},
					events: [],
					scales: {
						showXLabels: 100,
						yAxes: [{
							scaleLabel: {
								display: true,
								labelString: 'Temperture (' + legendText + ')'
							}
						}],
						xAxes: [{
							ticks: {
								autoSkip: true,
								maxTicksLimit: 15
							},
							scaleLabel: {
								display: true,
								labelString: 'Date'
							}
						}]
					}
				}
			});
		},
		error: function (errorData) {
			console.log('!!ERROR Getting Chart Data');
			console.log(errorData);
		}
	});
}

function hideDataElements() {
	$('.data-element').hide();
}

function showDataElements() {
	$('.data-element').show();
}

function hideNoDataFoundElements() {
	$('.nodata-element').hide();
}

function showNoDataFoundElements() {
	$('.nodata-element').show();
}

function initModal(locationObj, watershedObj) {
	hideDataElements();
	hideNoDataFoundElements();

	//title
	var title = locationObj.SensorName;
	$(".modal-title").text(title);

    //desc
    var descTitle = "About " + locationObj.SensorName;
    var description = "<b> Watershed: </b>" + watershedObj.WatershedName + "<br/>" +
        "<b> Coordinates: </b>" + " (" + locationObj.Latitude + ", " + locationObj.Longitude + ")"
        + "<br> ...";
    $(".modalDescTitle").text(descTitle);
    $(".modalDesc").html(description);
    //var description = "Description about the watershed: " + locationObj.SensorName + " - " + watershedObj.WatershedName + " (" + locationObj.Latitude + ", " + locationObj.Longitude + ")";
	//$(".modalDesc").text(description);

	//image
    //	var imageSrc = "<%= Global.Url_Prefix() %>/images/location/get.ashx?locationid=" + location.LocationID;
	var imageSrc = "images/location/get.ashx?locationid=" + locationObj.LocationID;
	var imageAlt = "The Picture of the " + locationObj.SensorName;
	$(".modalImage").attr("src", imageSrc).attr("alt", imageAlt);

	//more pictures link
//	$('.modalLink').html('<a href="<%= Global.Url_Prefix() %>/gallery.aspx" class="btn btn-info btn-block">View Location Album</a>');
	$('.modalLink').html('<a href="gallery.aspx" class="btn btn-info btn-block">View Location Album</a>');


	//Build Chart functionality
	$.get("api.asmx/GetLocationLatestTemperature?locationid=" + locationObj.LocationID)
		.done(function (response) {
            if (response.length !== 0) {
                //if (window.Chart != undefined) {
                //    w.Chart.destroy();
                //}
				var endDate = new Date(response.Timestamp);
				var formattedEndDate = getFormattedDate(endDate);

				var startDate = new Date(endDate);
				startDate.setDate(endDate.getDate() - 7);
				var formattedStartDate = getFormattedDate(startDate);

				$('#end_datepicker').val(formattedEndDate);
				$('#start_datepicker').val(formattedStartDate);

				var temperatureScale = $('#selectScale').val();

				initGraph(locationObj, temperatureScale, formattedStartDate, formattedEndDate);

				showDataElements();
			} else {
				showNoDataFoundElements();
			}
		}).fail(function(response) {
			showNoDataFoundElements();
		}).always(function() {
			$('#locationModal').modal('show');
		});

	$('.chart-modifier').off('change').on('change', function() {
		var formattedEndDate = $('#end_datepicker').val();
		var formattedStartDate = $('#start_datepicker').val();

		var temperatureScale = $('#selectScale').val();

		initGraph(locationObj, temperatureScale, formattedStartDate, formattedEndDate);
	});

	//Download button
	$('#downloadCsv').off('click').on('click', function () {
//		window.location.href = '<%= Global.Url_Prefix() %>/api.asmx/AllLocationTemperaturesCsv';
		var formattedEndDate = $('#end_datepicker').val();
		var formattedStartDate = $('#start_datepicker').val();

		var locationId = locationObj.LocationID;

		window.location.href = 'api.asmx/LocationTemperaturesCsvStartEnd?locationId=' + locationId + '&startDate=' + formattedStartDate + '&endDate=' + formattedEndDate;
	});

	//Close Modal
	$('#locationModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
		$('#end_datepicker').val(null);
		$('#start_datepicker').val(null);
	});
}

function populateWatersheds(watershedObjArray) {
	var watershedMenu = $('#ddMenuWatershed');

	for (var i = 0; i < watershedObjArray.length; i++) {
		var newElement = $(document.createElement('a'));
		newElement.addClass('dropdown-item');
		newElement.text(watershedObjArray[i].WatershedName);
		newElement.attr('href', '#');
		newElement.click(watershedObjArray[i], selectWatershed);

		watershedMenu.append(newElement);
	}
}

function buildMarker(googleMapObj, locationObj) {

	// TODO: find a better way to do this than call and map all locations to their watersheds
	$.ajax({
//		url: "<%= Global.Url_Prefix() %>/api.asmx/Watersheds",
		url: "api.asmx/Watersheds",
		success: function (watershedObjArray) {
			var watershedObjMap = new Map();

			watershedObjArray.forEach(function (watershedObj) {
				watershedObjMap.set(watershedObj.WatershedID, watershedObj);
			});

			var watershedObj = watershedObjMap.get(locationObj.WatershedID);

			var infoWindow = new google.maps.InfoWindow({
				disableAutoPan: true,
				content: "<h6><b>" +
					locationObj.SensorName +
					"</b></h6>"
//					+ "<img src='<%= Global.Url_Prefix() %>/images/location/get.ashx?locationid=" + locationObj.LocationID + "' width='300' height='200' />" + "<br /><br />"
					+
					"<img src='images/location/get.ashx?locationid=" + locationObj.LocationID + "' width='300' height='200' />" +
					"<br /><br />" +
					"<h6><b>Watershed:</b> " +
					watershedObj.WatershedName +
					"</h6>" +
					"<br/>" +
					"<b>Latitude: </b>" +
					locationObj.Latitude +
					"<br/>" +
					"<b>Longitude: </b>" +
					locationObj.Longitude +
					"<br/><br/>" +
					"<b>**Click on the marker to see more details**</b>"
			});

			var marker = new google.maps.Marker({
				position: { lat: locationObj.Latitude, lng: locationObj.Longitude },
				animation: google.maps.Animation.DROP,
				map: googleMapObj,
				title: locationObj.SensorName,
				infowindow: infoWindow
			});

			marker.addListener('mouseover', function () {
				if (openInfoWindow) {
					openInfoWindow.close();
				}

				openInfoWindow = infoWindow;
				infoWindow.open(googleMapObj, marker);
			});

			marker.addListener('closeclick', function () {
				infoWindow.close();
			});

			marker.addListener('click', function () {
				initModal(locationObj, watershedObj);
			});
		}
	});
}

function selectWatershed(event) {
	$('#ddBtnWatershed').text(event.data.WatershedName);

	populateLocations(event.data.WatershedID);
}

function populateLocations(watershedId) {
	$('#ddMenuLocation').empty();
	$('#ddBtnLocation').text('Locations');

	$.ajax({
//		url: "<%= Global.Url_Prefix() %>/api.asmx/Location?watershedId=" + watershedId,
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

function selectLocation(event) {
	$('#ddBtnLocation').text(event.data.SensorName);

	theMap.panTo({ lat: event.data.Latitude, lng: event.data.Longitude });
	theMap.setZoom(18);
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

function getFormattedDate(date) {
	var year = date.getFullYear();

	var month = (1 + date.getMonth()).toString();
	month = month.length > 1 ? month : '0' + month;

	var day = date.getDate().toString();
	day = day.length > 1 ? day : '0' + day;
	return month + '-' + day + '-' + year;
}

function initMap() {
	var mapElement = document.getElementById('map');
	var mapCenter = { lat: 40.0219, lng: -75.1134 };

	theMap = new google.maps.Map(mapElement, {
		center: mapCenter,
		zoom: 8
	});

	$.ajax({
//		url: "<%= Global.Url_Prefix() %>/api.asmx/AllLocations",
		url: "api.asmx/AllLocations",
		success: function (locationObjArray) {

			locationObjArray.forEach(function(locationObj) {
				buildMarker(theMap, locationObj);
			});
		}
	});

	var pennypack = new google.maps.KmlLayer("https://gist.githubusercontent.com/tuf37823/97274aa5bbad9c8f65589eb41db1a265/raw/5b622d0876948447bc2a0e2d3c2835025d25670f/streams_pennypack.kml", {
		suppressInfoWindows: true,
		preserveViewport: false,
		map: theMap
	});

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



$(function () {

	$.ajax({
		//url: "<%= Global.Url_Prefix() %>/api.asmx/Watersheds",
		url: "api.asmx/Watersheds",
		success: populateWatersheds
	});


	$("#start_datepicker").datepicker({
		dateFormat: 'mm-dd-yy'
	});
	$("#end_datepicker").datepicker({
		dateFormat: 'mm-dd-yy'
	});

});