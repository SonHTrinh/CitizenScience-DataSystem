var theMap;
var openInfoWindow;

function initModal(locationObj, watershedObj) {

	//title
	var title = locationObj.SensorName + " - " + watershedObj.WatershedName;
	$(".modal-title").text(title);

	//desc
	var description = "Description about the watershed: " + locationObj.SensorName + " - " + watershedObj.WatershedName + " (" + locationObj.Latitude + ", " + locationObj.Longitude + ")";
	$(".modalDesc").text(description);

	//image
//	var imageSrc = "<%= Global.Url_Prefix() %>/images/location/get.ashx?locationid=" + location.LocationID;
	var imageSrc = "../images/location/get.ashx?locationid=" + locationObj.LocationID;
	var imageAlt = "The Picture of the " + locationObj.SensorName;
	$(".modalImage").attr("src", imageSrc);
	$(".modalImage").attr("alt", imageAlt);

	//more pictures link
//	$('.modalLink').html('<a href="<%= Global.Url_Prefix() %>/gallery.aspx" class="btn btn-info btn-block">View Location Album</a>');
	$('.modalLink').html('<a href="../gallery.aspx" class="btn btn-info btn-block">View Location Album</a>');

	//Show graph by default after open it
	if ($('#radioC').is(':checked')) {
		//showLatestDate(location.LocationID);
		showLatestDate(1, "C");
	}
	else if ($('#radioF').is(':checked')) {
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
			showLatestDate(1, "F");
		}
		else {
			initFGraph(1, startDate, endDate);
		}
	});

	//Submit button
	$('#submit').click(function () {
		var startDate = $('#start_datepicker').val();
		var endDate = $('#end_datepicker').val();
		if ((startDate == "") || (endDate == "")) {
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

	//Download button
	$('#downloadCsv').click(function () {
//		window.location.href = '<%= Global.Url_Prefix() %>/api.asmx/AllLocationTemperaturesCsv';
		window.location.href = '../api.asmx/AllLocationTemperaturesCsv';
	});

	//Close Modal
	$('#locationModal').on('hidden.bs.modal', function () {
		//radio button setting
		$('#radioC').prop('checked', true);
		$('#radioF').prop('checked', false);
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
//		url: '<%= Global.Url_Prefix() %>/api.asmx/GetLocationTemperaturesByDateRange',
		url: '../api.asmx/GetLocationTemperaturesByDateRange',
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
//		url: '<%= Global.Url_Prefix() %>/api.asmx/GetLocationTemperaturesByDateRange',
		url: '../api.asmx/GetLocationTemperaturesByDateRange',
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

function buildMarker(googleMapObj, locationObj) {

	// TODO: find a better way to do this than call and map all locations to their watersheds
	$.ajax({
//		url: "<%= Global.Url_Prefix() %>/api.asmx/Watersheds",
		url: "../api.asmx/Watersheds",
		success: function (watershedObjArray) {
			var watershedObjMap = new Map();

			watershedObjArray.forEach(function (watershedObj) {
				watershedObjMap.set(watershedObj.WatershedID, watershedObj);
			});

			var watershedObj = watershedObjMap.get(locationObj.WatershedID);

			var infoWindow = new google.maps.InfoWindow({
				content: "<h6><b>" +
					locationObj.SensorName +
					"</b></h6>"
//					+ "<img src='<%= Global.Url_Prefix() %>/images/location/get.ashx?locationid=" + locationObj.LocationID + "' width='300' height='200' />" + "<br /><br />"
					+
					"<img src='../images/location/get.ashx?locationid=" +
					locationObj.LocationID +
					"' width='300' height='200' />" +
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
				if (openInfoWindow !== infoWindow) {
					openInfoWindow.close();
				}

				openInfoWindow = infoWindow;
				infoWindow.open(googleMapObj);
			});

			marker.addListener('closeclick', function () {
				infoWindow.close();
			});

			marker.addListener('click', function () {
				initModal(locationObj, watershedObj);
				$('#locationModal').modal('show');
			});
		}
	});
}

function showLatestDate(id, Format) {
	if (Format == "C") {
//		$.get("<%= Global.Url_Prefix() %>/api.asmx/GetLocationLatestTemperature?locationid=" + id, function (response) {
		$.get("../api.asmx/GetLocationLatestTemperature?locationid=" + id, function (response) {
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
//		$.get("<%= Global.Url_Prefix() %>/api.asmx/GetLocationLatestTemperature?locationid=" + id, function (response) {
		$.get("../api.asmx/GetLocationLatestTemperature?locationid=" + id, function (response) {
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

function selectWatershed(event) {
	$('#ddBtnWatershed').text(event.data.WatershedName);

	populateLocations(event.data.WatershedID);
}

function populateLocations(watershedId) {
	$('#ddMenuLocation').empty();
	$('#ddBtnLocation').text('Locations');

	$.ajax({
//		url: "<%= Global.Url_Prefix() %>/api.asmx/Location?watershedId=" + watershedId,
		url: "../api.asmx/Location?watershedId=" + watershedId,
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

	map.panTo({ lat: event.data.Latitude, lng: event.data.Longitude });
	map.setZoom(18);
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
		url: "../api.asmx/AllLocations",
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

initMap();

$(function () {

	$.ajax({
		//url: "<%= Global.Url_Prefix() %>/api.asmx/Watersheds",
		url: "../api.asmx/Watersheds",
		success: populateWatersheds
	});

	$("#start_datepicker").datepicker({
		dateFormat: 'mm-dd-yy'
	});
	$("#end_datepicker").datepicker({
		dateFormat: 'mm-dd-yy'
	});

});