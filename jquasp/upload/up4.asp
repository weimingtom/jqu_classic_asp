<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">
	<title>jQuery File Upload Example</title>
	
	<!--  -->
	<script src="../js/upload/load-image.min.js"></script>
	<script src="../js/upload/canvas-to-blob.min.js"></script>
	<!--  -->
	
	
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/upload/jquery.fileupload.css">
	<link rel="stylesheet" href="../css/upload/jquery.fileupload-ui.css">
	<script src="../js/jquery.min.js"></script>
	<script src="../js/upload/jquery.ui.widget.js"></script>
	<script src="../js/upload/jquery.iframe-transport.js"></script>
	<script src="../js/upload/jquery.fileupload.js"></script>
	
	
	<!--  -->
	<script src="../js/upload/jquery.fileupload-process.js"></script>
	<script src="../js/upload/jquery.fileupload-image.js"></script>
	<!--  -->
	
	<script>
$(function () {
	function formatFileSize(bytes) {
		if (typeof bytes !== 'number') {
			return '';
		}
		if (bytes >= 1000000000) {
			return (bytes / 1000000000).toFixed(2) + ' GB';
		}
		if (bytes >= 1000000) {
			return (bytes / 1000000).toFixed(2) + ' MB';
		}
		return (bytes / 1000).toFixed(2) + ' KB';
	}
	
    $('#fileupload').fileupload({
		dataType: 'json',
		
		autoUpload: false,
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 5000000, // 5 MB
		disableImageResize:false,
		previewMaxWidth: 100,
        previewMaxHeight: 100,
        previewCrop: false,
		
		disableImageResize: false,
		imageMaxWidth: 1024,
		imageMaxHeight: 1024,
		imageCrop: false, // Force cropped images
    }).on('fileuploadadd', function (e, data) {
        //console.log("fileuploadadd");
		var file = data.files[0];
		$('.start').click(function () {
			$('.progress-bar').css('width','0%');
			if (!data.iscanceled) {
				data.submit();
			}
		});
		$('.cancel').click(function () {
			data.iscanceled = true;
			data.abort();
			//$('.error').text("取消上传");
			$('.preview_div').empty();
			$('.results_div').empty();
			console.log(data.files);
		});
    }).on('fileuploadprocessalways', function (e, data) {
		var index = data.index;
        var file = data.files[index];
		//console.log("fileuploadprocessalways " + index + "," + file);
		if (index==0 && file.preview) {
			//console.log(file);
			var item = $('<div><span class="preview"></span><div class="size"></div></div>');
			item.find('.preview').append(file.preview)
			item.find('.size').text(formatFileSize(file.size));
			item.appendTo('.preview_div');
		}
	}).on('fileuploadprogressall', function (e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('.progress-bar').css('width',progress + '%');
    }).on('fileuploaddone', function (e, data) {
		//console.log("fileuploaddone " + data.result.files.length);
		file = data.result.files[0];
		
		$('.progress').removeClass('progress-striped');
		
		var item = $('<div><span class="imageLink"></span><span class="error text-danger"></span></div>');
		item.find('.error').text("上传成功");
		$('<a target="_blank" />').attr("href", "imagefile/"+file.name)
			.text("imagefile/"+file.name)
			.appendTo(item.find('.imageLink'));
		item.appendTo('.results_div');
    }).on('fileuploadfail', function (e, data) {
		var index = 0;
        var file = data.files[index];
		if (!data.iscanceled) {
			var item = $('<div><span class="imageLink"></span><span class="error text-danger"></span></div>');
			item.find('.error').text("上传失败");
			$('<div />')
				.text(file.name)
				.appendTo(item.find('.imageLink'));
			item.appendTo('.results_div');
		} else {
			$('.preview_div').empty();
			$('.results_div').empty();
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
			<span>开始上传</span>
		</button>
		<button class="btn btn-warning cancel">
			<i class="glyphicon glyphicon-ban-circle"></i>
			<span>全部取消</span>
		</button>
	</div>
	<div>
		<div>上传进度：</div>
		<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
			<div class="progress-bar progress-bar-success" style="width:0%;">
			</div>
		</div>
	</div>
	<div class="preview_div">
	</div>
	<div class="results_div">
	</div>
</body>
</html>
