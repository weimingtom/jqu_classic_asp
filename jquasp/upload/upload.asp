<%
IF Request.TotalBytes>0 Then
 '上传文件存入网站根下的imagefile文件夹内，如没有请建
 'Response.Charset="utf-8"
 Response.Buffer=true
 formsize=Request.TotalBytes'获得上传文件的大小  
 formdata=Request.BinaryRead(formsize) '获得上传文件的二进制数据
 crlf=chrB(13)&chrB(10)'二进制的回车符
 strflag=leftb(formdata,clng(instrb(formdata,crlf))-1) '分隔标志符
 
 '获取文件内容的字节数
 start = instrb(1,formdata,strflag) + lenb(strflag) + 2   ' 开始位置
 endsize = instrb((start+lenb(strflag)),formdata,strflag) - start - 2 '结束位置 
 bin_content = midb(formdata,start,endsize)
 filenamebcode=chrb(102)&chrb(105)&chrb(108)&chrb(101)&chrb(110)&chrb(97)&chrb(109)&chrb(101)&chrb(61)&chrb(34) '字符串"filename"的二进制表示
 bin_start = instrb(bin_content,crlf&crlf) + 4  ' 开始位置 
 filedata=midb(bin_content,bin_start) 
 '把图片数据上传到文件夹
 set objstream=getStream(1,3)
 objstream.write formdata   ' 赋值源数据流
 objstream.position = instrb(instrb(formdata,filenamebcode),formdata,crlf&crlf) + 3  '是加3不是4  当前指'position指出文件的开始位置 
 
 '功能：为提取文件的名称，进行二进制向字符串转换
 '实用范围：适用于包括汉字的转换
 '参数：bstr为二进制串
 bstr=getHead(formdata) 
 ' Response.Write(bstr) '调试用
 atstart=instr(bstr,"filename=")
 atfirst=instr(atstart,bstr,chr(34))'第一个引号
 atsecond=instr(atfirst+1,bstr,chr(34))'第二个引号
 
 'response.write "<br/>"&atstart&"<br/>"&atsecond&"<br/>"&atfirst  '调试用
 filename=mid(bstr,atfirst+1,atsecond-atfirst-1) '获得文件名称 
 
 
 extendname=right(filename,len(filename)-instr(filename,chr(46))) '获得文件扩展名
 contentype=right(bstr,len(bstr)-instrrev(bstr,chr(58)))  '获得文件content type
 'response.Write "<br/>"&filename&"<br/>"& extendname&"<br/>"&contentype&"<hr/>"  '调试用 
 
 set objdata=getStream(1,3)
 objstream.copyto objdata,lenb(filedata)
 
 '上传路径及文件名
'saveFilename=""&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&"."&extendname
function get_time()
	msec = fix(timer()*100) mod 100
	get_time=year(now)&right("0"&month(now),2)&right("0"&day(now),2)&right("0"&hour(now),2)&right("0"&minute(now),2)&right("0"&second(now),2)&right("0"&msec, 2)&"0"
end function
saveFilename=get_time()&"."&extendname
 
 objdata.SaveToFile server.MapPath("./imagefile")&"\"&saveFilename,2  
    
 '关闭STEAM对象 
 call getClose(objdata)
 call getClose(objstream)
 
 '显示上传内容，最好在新网页中实现，本例为测试之用
 'Response.Redirect(show.asp)
 'Response.Write "<img src="&chr(34)&"imagefile"&"\"&filename&chr(34)&"/>"
 'Response.Write "{'files':[{'name':'"&filename&"'}]}"
 Response.Write "{"&chr(34)&"files"&chr(34)&":[{"&chr(34)&"name"&chr(34)&":"&chr(34)&saveFilename&chr(34)&"}]}"
 Response.End

 '函数名：getHead(filedata)
 '功能：获取文件头信息
 '作者：swj
 '参数：filedata是文件域传来二进制数据
 '说明：巧妙运用了数据流实现了进制之间的转换
 
 Function getHead(filedata)
  istart=instrb(1,filedata,crlf) 
  formend=instrb(istart+1,filedata,crlf&crlf)
  namedata=midb(filedata,istart,formend-istart)
  'Response.BinaryWrite(namedata) 调试用         
  Set mystream=getStream(2,3)     
  mystream.writetext namedata     
  mystream.position=0 '当前指针
  mystream.charset="utf-8"
  mystream.position=2
  bstr=mystream.readtext()
  mystream.close
  getHead=bstr  
 End function 
 
 '函数名：getStream(mytype,mymode)
 '功能：获取Adodb.Stream对象
 '作者：swj
 '参数：mytype,mymode分别为对象类型和模式，如1，3或2，3
 Function getStream(mytype,mymode)
  set objectname=Server.CreateObject("Adodb.Stream")
  objectname.Type= mytype  '设置数据类型，1为二进制数据
  objectname.Mode=mymode '设置打开模式，3为可读可写   
  objectname.open
  set getStream=objectname 
 End Function
 
 '函数名：geClose(obj)
 '功能：关闭obj对象
 '作者：swj
 '参数：obj是要关闭的对象
 Function getClose(obj)
  obj.Close
  set obj=Nothing
 End Function
 
End if
%>
