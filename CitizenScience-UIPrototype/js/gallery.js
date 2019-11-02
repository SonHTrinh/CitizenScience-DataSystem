
function buildAlbumElement(albumObj, columnClass) {
	var imageUrl = 'images/albumprofile.ashx?albumId=' + albumObj.AlbumID;
	var imageHeight = '200px';
	var imageWidth = '200px';
	var albumTitle = albumObj.Name;

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

	var viewButton = $(document.createElement('button'))
		.attr('type', 'button')
		.attr('data-toggle', 'modal')
		.attr('data-target', '.bd-example-modal-lg')
		.addClass('btn')
		.addClass('btn-primary')
		.addClass('mx-5')
		.addClass('my-2')
		.text('View');
		

	titleRow.append(title);
	profileImageRow.append(profileImage);
	buttonRow.append(viewButton);


	columnElement.append(titleRow);
	columnElement.append(profileImageRow);
	columnElement.append(descriptionRow);
	columnElement.append(buttonRow);

	return columnElement;
}

$(function() {

	$.ajax({
		url: "../api.asmx/AllAlbum",
		success: function (responseData) {
			var numOfAlbums = responseData.length;
			var numOfColumnsPerRow = 4;
			var numOfRows = Math.ceil(numOfAlbums / numOfColumnsPerRow);
			var albumIteration = 0;

			for (var i = 0; i <= numOfRows; i++) {

				var row = $(document.createElement('div')).addClass('row').addClass('my-5');

				for (var j = 0; j < numOfColumnsPerRow && albumIteration < numOfAlbums; j++) {

					//Append 
					var albumColumnElement = buildAlbumElement(responseData[albumIteration], 'col-3');

					row.append(albumColumnElement);
					albumIteration++;
				}

				$('#album-placeholder').append(row);
			}
		}
	});

});
