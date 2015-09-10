<html>
<head>
<title>image list</title>
<meta charset="utf-8">
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
<h1>下载图片列表</h1>
<div>
<a href="index.php">返回上传文件</a>
<br />
<br />
</div>
<table border="2" cellpadding="3" cellspacing="1" width="100%" align="center" style="background-color: #b9d8f3;">
<?php 
include_once 'config.php';

$removefilename = '';

if (is_array($_GET) && count($_GET) > 0)
{ 
	if(isset($_GET['r']))
	{ 
		$removefilename = $_GET['r']; 
	} 
}

$ignore = array("", ".", "..", ".gitignore", ".htaccess");

if (!in_array($removefilename, $ignore) &&
    file_exists(UPLOAD_SAVE_PATH . $removefilename)) 
{
	unlink(UPLOAD_SAVE_PATH . $removefilename);
}

$files = scandir(UPLOAD_SAVE_PATH);

foreach($files as $index=>$value){ 
?>
<tr style="text-align: left; COLOR: #0076C8; BACKGROUND-COLOR: #F4FAFF; font-weight: bold">
<td width="50%"><a href="image.php?filename=<?php echo $value;?>"><?php echo $value;?></a></td><td width="50%"><a href="image_list.php?r=<?php echo $value;?>">删除文件</a></td>
</tr>
<tr><td width="50%">&nbsp;</td><td width="50%">&nbsp;</td></tr>
<?php } ?>
</table>
</body>
</html>
