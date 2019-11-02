
function buildAlbumElement(albumObj) {
	var imageUrl = 'images/albumprofile.ashx?albumId=' + albumObj.AlbumID;
	var imageHeight = '200px';
	var imageWidth = '200px';
	var albumTitle = albumObj.Title;

	var baseElement = $(document.createElement('div'));

	var titleRow = $(document.createElement('div'))
		.addClass('row')
		.addClass('justify-content-center');

	var profileImageRow = $(document.createElement('div'))
		.addClass('row');

	var descriptionRow = $(document.createElement('div'))
		.addClass('row');

	var title = $(document.createElement('p'))
		.addClass('font-weight-bold')
		.text(albumTitle);

	var profileImage = $(document.createElement('img'))
		.css('height', imageHeight)
		.css('width', imageWidth)
		.attr('src', imageUrl);

	titleRow.append(title);
	profileImageRow.append(profileImage);

	baseElement.append(titleRow);
	baseElement.append(profileImageRow);
	baseElement.append(descriptionRow);

	return baseElement;
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

				var row = $(document.createElement('div')).addClass('row').addClass('mb-2');

				for (var j = 0; j < numOfColumnsPerRow && albumIteration < numOfAlbums; j++) {

					var column = $(document.createElement('div')).addClass('col-3 border');

					//View button row
					var nestedRow4 = $(document.createElement('div')).addClass('row').addClass('justify-content-left');
					var view = $(document.createElement('a'));
					view.addClass('btn btn-outline-dark');
					view.text('View');
					view.attr('href', '#');
					view.attr('data-toggle', 'modal');
					view.attr('data-target', '#exampleModalCenter');
					nestedRow4.append(view);
					//Append 
					var albumElement = buildAlbumElement(responseData[albumIteration]);

					column.append(albumElement);

					row.append(column);
					albumIteration++;
				}

				$('#album-placeholder').append(row);
			}
		}
	});

});
