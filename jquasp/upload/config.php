<?php
	if ($_SERVER['SERVER_NAME'] == 'localhost')
	{
		define('UPLOAD_SAVE_PATH', './imagefile' . '/');
		//define('UPLOAD_SAVE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/jquasp/upload/imagefile' . '/');
	}
	else
	{
		//for http://mopaas.com
		define('UPLOAD_SAVE_PATH', getenv('MOPAAS_FILESYSTEM19124_LOCAL_PATH') . '/' . getenv('MOPAAS_FILESYSTEM19124_NAME') . '/');
		//define('UPLOAD_SAVE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/jquasp/upload/imagefile' . '/');
	}
?>
