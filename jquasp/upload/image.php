<?php
include_once 'config.php';

//$filename = '201509103454847.jpg';
$filename = '';

if (is_array($_GET) && count($_GET) > 0)
{ 
	if(isset($_GET['filename']))
	{ 
		$filename = $_GET['filename']; 
	} 
}

//https://github.com/ctwd/ConvexHull/blob/master/src/read_file.php
//https://github.com/arzynik/PHPPowerBrowse/blob/master/browse.php

//https://github.com/dfridrich/PhpMimeType/blob/master/src/MimeType.php
function getMimeTypeExt($filename)
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
		return $mimeTypes[$extension];
	} elseif (function_exists('finfo_open') && is_file($filename)) {
		$finfo = finfo_open(FILEINFO_MIME);
		$mimetype = finfo_file($finfo, $filename);
		finfo_close($finfo);
		return $mimetype;
	} else {
		//return 'application/octet-stream';
		return 'image/jpeg';
	}
}
//header('Content-Type: image/jpeg');
header('Content-Type: ' . getMimeTypeExt($filename));
$path = UPLOAD_SAVE_PATH . $filename;
$content = file_get_contents($path);
echo $content;
?>
