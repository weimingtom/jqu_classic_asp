<%
IF Request.TotalBytes>0 Then
 '�ϴ��ļ�������վ���µ�imagefile�ļ����ڣ���û���뽨
 'Response.Charset="utf-8"
 Response.Buffer=true
 formsize=Request.TotalBytes'����ϴ��ļ��Ĵ�С  
 formdata=Request.BinaryRead(formsize) '����ϴ��ļ��Ķ���������
 crlf=chrB(13)&chrB(10)'�����ƵĻس���
 strflag=leftb(formdata,clng(instrb(formdata,crlf))-1) '�ָ���־��
 
 '��ȡ�ļ����ݵ��ֽ���
 start = instrb(1,formdata,strflag) + lenb(strflag) + 2   ' ��ʼλ��
 endsize = instrb((start+lenb(strflag)),formdata,strflag) - start - 2 '����λ�� 
 bin_content = midb(formdata,start,endsize)
 filenamebcode=chrb(102)&chrb(105)&chrb(108)&chrb(101)&chrb(110)&chrb(97)&chrb(109)&chrb(101)&chrb(61)&chrb(34) '�ַ���"filename"�Ķ����Ʊ�ʾ
 bin_start = instrb(bin_content,crlf&crlf) + 4  ' ��ʼλ�� 
 filedata=midb(bin_content,bin_start) 
 '��ͼƬ�����ϴ����ļ���
 set objstream=getStream(1,3)
 objstream.write formdata   ' ��ֵԴ������
 objstream.position = instrb(instrb(formdata,filenamebcode),formdata,crlf&crlf) + 3  '�Ǽ�3����4  ��ǰָ'positionָ���ļ��Ŀ�ʼλ�� 
 
 '���ܣ�Ϊ��ȡ�ļ������ƣ����ж��������ַ���ת��
 'ʵ�÷�Χ�������ڰ������ֵ�ת��
 '������bstrΪ�����ƴ�
 bstr=getHead(formdata) 
 ' Response.Write(bstr) '������
 atstart=instr(bstr,"filename=")
 atfirst=instr(atstart,bstr,chr(34))'��һ������
 atsecond=instr(atfirst+1,bstr,chr(34))'�ڶ�������
 
 'response.write "<br/>"&atstart&"<br/>"&atsecond&"<br/>"&atfirst  '������
 filename=mid(bstr,atfirst+1,atsecond-atfirst-1) '����ļ����� 
 
 
 extendname=right(filename,len(filename)-instr(filename,chr(46))) '����ļ���չ��
 contentype=right(bstr,len(bstr)-instrrev(bstr,chr(58)))  '����ļ�content type
 'response.Write "<br/>"&filename&"<br/>"& extendname&"<br/>"&contentype&"<hr/>"  '������ 
 
 set objdata=getStream(1,3)
 objstream.copyto objdata,lenb(filedata)
 
 '�ϴ�·�����ļ���
'saveFilename=""&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&"."&extendname
function get_time()
	msec = fix(timer()*100) mod 100
	get_time=year(now)&right("0"&month(now),2)&right("0"&day(now),2)&right("0"&hour(now),2)&right("0"&minute(now),2)&right("0"&second(now),2)&right("0"&msec, 2)&"0"
end function
saveFilename=get_time()&"."&extendname
 
 objdata.SaveToFile server.MapPath("./imagefile")&"\"&saveFilename,2  
    
 '�ر�STEAM���� 
 call getClose(objdata)
 call getClose(objstream)
 
 '��ʾ�ϴ����ݣ����������ҳ��ʵ�֣�����Ϊ����֮��
 'Response.Redirect(show.asp)
 'Response.Write "<img src="&chr(34)&"imagefile"&"\"&filename&chr(34)&"/>"
 'Response.Write "{'files':[{'name':'"&filename&"'}]}"
 Response.Write "{"&chr(34)&"files"&chr(34)&":[{"&chr(34)&"name"&chr(34)&":"&chr(34)&saveFilename&chr(34)&"}]}"
 Response.End

 '��������getHead(filedata)
 '���ܣ���ȡ�ļ�ͷ��Ϣ
 '���ߣ�swj
 '������filedata���ļ���������������
 '˵��������������������ʵ���˽���֮���ת��
 
 Function getHead(filedata)
  istart=instrb(1,filedata,crlf) 
  formend=instrb(istart+1,filedata,crlf&crlf)
  namedata=midb(filedata,istart,formend-istart)
  'Response.BinaryWrite(namedata) ������         
  Set mystream=getStream(2,3)     
  mystream.writetext namedata     
  mystream.position=0 '��ǰָ��
  mystream.charset="utf-8"
  mystream.position=2
  bstr=mystream.readtext()
  mystream.close
  getHead=bstr  
 End function 
 
 '��������getStream(mytype,mymode)
 '���ܣ���ȡAdodb.Stream����
 '���ߣ�swj
 '������mytype,mymode�ֱ�Ϊ�������ͺ�ģʽ����1��3��2��3
 Function getStream(mytype,mymode)
  set objectname=Server.CreateObject("Adodb.Stream")
  objectname.Type= mytype  '�����������ͣ�1Ϊ����������
  objectname.Mode=mymode '���ô�ģʽ��3Ϊ�ɶ���д   
  objectname.open
  set getStream=objectname 
 End Function
 
 '��������geClose(obj)
 '���ܣ��ر�obj����
 '���ߣ�swj
 '������obj��Ҫ�رյĶ���
 Function getClose(obj)
  obj.Close
  set obj=Nothing
 End Function
 
End if
%>
