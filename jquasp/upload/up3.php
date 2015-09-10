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
		
		/*
        add: function (e, data) {
			console.log("add");
			var file = data.files[0];
			console.log(file);
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
		*/
		/*
		done: function (e, data) {
			file = data.result.files[0];
			$('.name').text(file.name);
			$('.error').text("上传成功");
			$('.progress').removeClass('progress-striped');
			$('.preview').empty();
			//$('<img/>')
			//	.attr("width", 80)
			//	.attr("height", 64)
			//  .attr("src", "imagefile/"+file.name)
			//	.appendTo(".preview");
			$('<a />').attr("href", "imagefile/"+file.name)
				.appendTo(".preview");
        },
		*/
    }).on('fileuploadadd', function (e, data) {
        //console.log("fileuploadadd");
		var file = data.files[0];
		$('.start').click(function () {
			$('.progress-bar').css('width','0%');
			data.submit();
		});
		$('.cancel').click(function () {
			data.abort();
			$('.error').text("取消上传");
		});
    }).on('fileuploadprocessalways', function (e, data) {
		//console.log("fileuploadprocessalways");
		var index = data.index;
        var file = data.files[index];
		if (index==0 && file.preview) {
			console.log(file);
			$('.preview').empty().append(file.preview);
			$('.size').text(formatFileSize(file.size));
		}
	}).on('fileuploadprogressall', function (e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('.progress-bar').css('width',progress + '%');
    }).on('fileuploaddone', function (e, data) {
		file = data.result.files[0];
		$('.error').text("上传成功");
		$('.progress').removeClass('progress-striped');
		$('.imageLink').empty();
		//$('<img/>')
		//	.attr("width", 80)
		//	.attr("height", 64)
		//  .attr("src", "imagefile/"+file.name)
		//	.appendTo(".preview");
		$('<a />').attr("href", "image.php?filename="+file.name)
			.text("image.php?filename="+file.name)
			.appendTo(".imageLink");
    }).on('fileuploadfail', function (e, data) {
		$('.error').text("上传失败");
		$('.progress').removeClass('progress-striped');
		$('.imageLink').empty();
    });
});
	</script>
</head>
<body>
	<div>
		<span class="btn btn-success fileinput-button">
			<i class="glyphicon glyphicon-plus"></i>
			<span>添加图片</span>
			<input type="file" name="files[]" id="fileupload" data-url="upload.php">
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
		<div>上传进度：</div>
		<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
			<div class="progress-bar progress-bar-success" style="width:0%;">
			</div>
		</div>
	</div>
	<div>
		<span class="preview"></span>
		<div class="size"></div>
	</div>
	<div>
		<span class="imageLink"></span>
		<span class="error text-danger"></span>
	</div>
	<div>
		<br />
		<br />
		<a href="image_list.php">上传文件列表</a>
	</div>
</body>
</html>
