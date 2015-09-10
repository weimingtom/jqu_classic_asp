<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">
	<title>jQuery File Upload Example</title>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/upload/jquery.fileupload.css">
	<link rel="stylesheet" href="../css/upload/jquery.fileupload-ui.css">
	<script src="../js/jquery.min.js"></script>
	<script src="../js/upload/jquery.ui.widget.js"></script>
	<script src="../js/upload/jquery.iframe-transport.js"></script>
	<script src="../js/upload/jquery.fileupload.js"></script>
	<script>
$(function () {
    $('#fileupload').fileupload({
		dataType: 'json',
        add: function (e, data) {
			console.log("add");
            $('.start').click(function () {
				$('.progress-bar').css('width','0%');
				data.submit();
			});
			$('.cancel').click(function () {
				data.abort();
				$('.error').text("取消上传");
			});
        },
		progressall: function (e, data) {
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$('.progress-bar').css('width',progress + '%');
		},
		done: function (e, data) {
            //$.each(data.result.files, function (index, file) {
            //    $('.name').text(file.name);
            //});
			file = data.result.files[0];
			$('.name').text(file.name);
			$('.error').text("上传成功");
			$('.progress').removeClass('progress-striped');
			$('.preview').empty();
			$('<img/>')
				.attr("width", 80)
				.attr("height", 64)
				.attr("src", "imagefile/"+file.name)
				.appendTo(".preview");
        }
    });
});
	</script>
</head>
<body>
	<div>
		<span class="btn btn-success fileinput-button">
			<i class="glyphicon glyphicon-plus"></i>
			<span>添加图片</span>
			<input type="file" name="files[]" id="fileupload" data-url="upload.asp" multiple>
		</span>
		<button class="btn btn-primary start">
			<i class="glyphicon glyphicon-upload"></i>
			<span>开始</span>
		</button>
		<button class="btn btn-warning cancel">
			<i class="glyphicon glyphicon-ban-circle"></i>
			<span>取消</span>
		</button>
	</div>
	<div>
		<div class="size"></div>
		<div>上传进度：</div>
		<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
			<div class="progress-bar progress-bar-success" style="width:0%;">
			</div>
		</div>
	</div>
	<div>
		<span class="preview"></span>
		<span class="name"></span>
		<span class="error text-danger"></span>
	</div>
</body>
</html>
