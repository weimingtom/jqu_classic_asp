<?php

//for coding.net
//see http://docs.coding.io/services/filesystem/
//see http://docs.coding.io/references/env/#vcap_services

$json=getenv('VCAP_SERVICES');
//$json = '{"a":1,"b":2,"c":3,"d":4,"e":5}';
//var_dump(json_decode($json,true));
if ($json != "") {
	var_dump($json);
	$result = json_decode($json);
	if ($result != false) {
		var_dump($result);
		var_dump($result->{"filesystem-1.0"});
		var_dump($result->{"filesystem-1.0"}[0]->{"credentials"});
		var_dump($result->{"filesystem-1.0"}[0]->{"credentials"}->{"host_path"});
	}
}
?>
