<?php
	if ($_SERVER['SERVER_NAME'] == 'localhost') {
		define('UPLOAD_SAVE_PATH', './imagefile' . '/');
		//define('UPLOAD_SAVE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/jquasp/upload/imagefile' . '/');
	} else {
		$localpath = getenv('MOPAAS_FILESYSTEM19124_LOCAL_PATH');
		if ($localpath) {
			//for http://mopaas.com
			define('UPLOAD_SAVE_PATH', getenv('MOPAAS_FILESYSTEM19124_LOCAL_PATH') . '/' . getenv('MOPAAS_FILESYSTEM19124_NAME') . '/');
			//define('UPLOAD_SAVE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/jquasp/upload/imagefile' . '/');
		} else {
			$json = getenv('VCAP_SERVICES');
			if ($json && $json != "") {
				//for http://coding.net
				$result = json_decode($json);
				if ($result != false) {
					define('UPLOAD_SAVE_PATH', $result->{"filesystem-1.0"}[0]->{"credentials"}->{"host_path"} . '/');
				}
			}
		}
	}
?>
