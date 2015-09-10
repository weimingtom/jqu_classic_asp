<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">
<title>jQuery File Upload Example</title>
<style>
.bar {
    height: 18px;
    background: green;
}
</style>
</head>
<body>
<!--https://github.com/blueimp/jQuery-File-Upload/wiki/Basic-plugin-->
<input id="fileupload" type="file" name="files[]" data-url="upload.asp" multiple accept="image/*;capture=camera"  capture="camera">
<script src="../js/jquery.min.js"></script>
<script src="../js/upload/jquery.ui.widget.js"></script>
<script src="../js/upload/jquery.iframe-transport.js"></script>
<script src="../js/upload/jquery.fileupload.js"></script>
<script>
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        add: function (e, data) {
            data.context = $('<button/>').text('Upload')
                .appendTo(document.body)
                .click(function () {
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
			$('<button/>').text('Cancel')
				.appendTo(document.body)
				.click(function () {
					data.context = $('<p/>').text('Cencel...').replaceAll($(this));
					data.abort();
				});
        },
		progressall: function (e, data) {
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$('#progress .bar').css(
				'width',
				progress + '%'
			);
			console.log("progress:" + progress);
		},
		done: function (e, data) {
			console.log("done");
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });
        }
    });
});
</script>
<div id="progress">
    <div class="bar" style="width: 0%;"></div>
</div>
</body> 
</html>
