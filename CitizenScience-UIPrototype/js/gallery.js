
function buildAlbumElement(albumObj, columnClass) {
	var imageUrl = 'images/album/get.ashx?id=' + albumObj.AlbumID;
	var imageHeight = '200px';
	var imageWidth = '300px';
    var albumTitle = albumObj.Name;
    var albumDesc = albumObj.Description;

	// The element to hold everything
	var columnElement = $(document.createElement('div'))
		.addClass('album-element')
		.addClass(columnClass);

	// Row elements
	var titleRow = $(document.createElement('div'))
		.addClass('row')
		.addClass('justify-content-center');

	var profileImageRow = $(document.createElement('div'))
		.addClass('row')
		.addClass('justify-content-center');

	var descriptionRow = $(document.createElement('div'))
		.addClass('row')
		.addClass('justify-content-center');

	var buttonRow = $(document.createElement('div'))
		.addClass('row')
		.addClass('justify-content-center');

	// Content
	var title = $(document.createElement('p'))
		.addClass('font-weight-bold')
		.text(albumTitle);

	var profileImage = $(document.createElement('img'))
		.css('height', imageHeight)
		.css('width', imageWidth)
        .attr('src', imageUrl);

    var desc = $(document.createElement('p'))
        .addClass('font-weight')
        .text(albumDesc);

	var viewButton = $(document.createElement('button'))
		.attr('id', 'album-view-' + albumObj.AlbumID)
		.attr('type', 'button')
		.addClass('btn')
        .addClass('btn-outline-dark')
		.addClass('px-3')
		.addClass('my-2')
		.text('View')
		.click(function() {
			initModal(albumObj);
		});
		

	titleRow.append(title);
    profileImageRow.append(profileImage);
    descriptionRow.append(desc);
	buttonRow.append(viewButton);

	columnElement.append(titleRow);
	columnElement.append(profileImageRow);
	columnElement.append(descriptionRow);
	columnElement.append(buttonRow);

	return columnElement;
}

function clearNodeChildren(node) {
	while (node.firstChild) {
		node.removeChild(node.firstChild);
	}
}

function initModal(albumObj) {
	var imagePlaceholder = $('#album-image-placeholder');

	clearNodeChildren(document.getElementById("album-image-placeholder"));

	$('#modalTitle').text(albumObj.Name);

	$.get({
		url: '../api.asmx/GetAlbumImageIds?albumId=' + albumObj.AlbumID
	}).done(function(imageIdArray) {

		imageIdArray.forEach(function(imageId) {
			var imageUrl = "images/get.ashx?id=" + imageId;

			var carouselItemElement = $(document.createElement('div'))
				.addClass('carousel-item');

			var imageElement = $(document.createElement('img'))
				.addClass('d-block')
				.addClass('w-100')
				.attr('src', imageUrl);

			carouselItemElement.append(imageElement);
			imagePlaceholder.append(carouselItemElement);
		});

		imagePlaceholder.children(':first').addClass('active');

		$('#gallery-modal').modal('show');
	}).fail(function() {
		console.log("Error Getting Image IDs for Album " + albumObj.AlbumID);
	});
}

$(function() {

	$.ajax({
		url: "../api.asmx/AllAlbum",
		success: function (responseData) {
			var numOfAlbums = responseData.length;
			var numOfColumnsPerRow = 3;
			var numOfRows = Math.ceil(numOfAlbums / numOfColumnsPerRow);
			var albumIteration = 0;

			for (var i = 0; i <= numOfRows; i++) {

				var row = $(document.createElement('div'))
					.addClass('row')
					.addClass('my-5');

				for (var j = 0; j < numOfColumnsPerRow && albumIteration < numOfAlbums; j++) {

					var albumColumnElement = buildAlbumElement(responseData[albumIteration], 'col-4');

					row.append(albumColumnElement);
					albumIteration++;
				}

				$('#album-placeholder').append(row);
			}
		}
	});

});
