<?php
include_once 'config.php';

function getFileExt($filename)
{
	$mimeTypes = array(
		/*
		'txt'  => 'text/plain',
		'htm'  => 'text/html',
		'html' => 'text/html',
		'php'  => 'text/html',
		'css'  => 'text/css',
		'js'   => 'application/javascript',
		'json' => 'application/json',
		'xml'  => 'application/xml',
		'swf'  => 'application/x-shockwave-flash',
		'flv'  => 'video/x-flv',
		*/
		// Images
		'png'  => 'image/png',
		'jpe'  => 'image/jpeg',
		'jpeg' => 'image/jpeg',
		'jpg'  => 'image/jpeg',
		'gif'  => 'image/gif',
		'bmp'  => 'image/bmp',
		'ico'  => 'image/vnd.microsoft.icon',
		'tiff' => 'image/tiff',
		'tif'  => 'image/tiff',
		'svg'  => 'image/svg+xml',
		'svgz' => 'image/svg+xml',
		/*
		// Archives
		'zip'  => 'application/zip',
		'rar'  => 'application/x-rar-compressed',
		'exe'  => 'application/x-msdownload',
		'msi'  => 'application/x-msdownload',
		'cab'  => 'application/vnd.ms-cab-compressed',
		// Audio/video
		'mp3'  => 'audio/mpeg',
		'qt'   => 'video/quicktime',
		'mov'  => 'video/quicktime',
		// Adobe
		'pdf'  => 'application/pdf',
		'psd'  => 'image/vnd.adobe.photoshop',
		'ai'   => 'application/postscript',
		'eps'  => 'application/postscript',
		'ps'   => 'application/postscript',
		// MS Office
		'doc'  => 'application/msword',
		'rtf'  => 'application/rtf',
		'xls'  => 'application/vnd.ms-excel',
		'ppt'  => 'application/vnd.ms-powerpoint',
		// Open Office
		'odt'  => 'application/vnd.oasis.opendocument.text',
		'ods'  => 'application/vnd.oasis.opendocument.spreadsheet',
		*/
	);

	$pathInfo = pathinfo($filename);
	$extension = strtolower($pathInfo['extension']);
	if (array_key_exists($extension, $mimeTypes)) {
		return $extension;
	} else {
		return 'jpg';
	}
}

//http://php.net/manual/zh/features.file-upload.post-method.php

//$saveFilename = 'out.jpg';
//file_put_contents(UPLOAD_SAVE_PATH . $saveFilename, file_get_contents('php://input'));

//https://github.com/Namanyahillary/fx/blob/master/Controller/Component/FuncComponent.php

function getMicrotime()	
{
	if (version_compare(PHP_VERSION, '5.0.0', '<'))
	{
		return array_sum(explode(' ', microtime()));
	}
	return microtime(true);
}

function getMicrotimeStr()
{
	$t = round(getMicrotime() * 1000);
	$t2 = '00' . fmod($t, 1000);
	$t3 = substr($t2, strlen($t2) - 3);
	return $t3;
}	

function getSaveFileName($tmpName)
{
	$saveFilename = date("YmdHis", time()) . getMicrotimeStr() . '.' . getFileExt($tmpName);
	return $saveFilename;
}

$saveFilename = '';
$upload = isset($_FILES['files']) ? $_FILES['files'] : null;
if ($upload && is_array($upload['tmp_name'])) 
{
	foreach ($upload['tmp_name'] as $index => $value) 
	{
		$name = is_array($upload['name']) ? $upload['name'][$index] : '';
		$saveFilename = getSaveFileName($name);
		move_uploaded_file($value, UPLOAD_SAVE_PATH . $saveFilename);
	}
}
else if ($upload)
{
	$name = isset($upload['name']) ? $upload['name'] : '';
	$saveFilename = getSaveFileName($name);
	move_uploaded_file($upload["tmp_name"], UPLOAD_SAVE_PATH . $saveFilename);
}
echo '{"files":[{"name":"'. $saveFilename . '"}]}';
?>
