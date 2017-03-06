<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" href="../resources/css/Index.css">
<link rel="stylesheet" type="text/css" href="../resources/css/aReservList.css" />
<link rel="stylesheet" href="../resources/css/Board.css">
<link rel="stylesheet" href="../resources/css/Loader.css">
<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../resources/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	var MemberName = '<%= request.getParameter("MemberName") %>';
	var MemberId = '<%= request.getParameter("MemberId") %>';
	var Modify = '<%= request.getParameter("No") %>';
	var Page = 0+<%= request.getParameter("Page") %>;
	var Type = '<%= request.getParameter("Type") %>';
	$("#Member").append(MemberName);
	$("#MemberName").val(MemberName);
	$('#MemberId').val(MemberId);
	if(Page== 0){
		alert("잘못된 접근입니다.");
		var URL = window.location.href;
 		URL = URL.replace("BoardRead","Board");
 		window.location.href(URL);
	}else{
		$('#Page').val(Page);
		$('#Type').val(Type);
		$('#No').val(Modify);
	}
	$('#MenuList li').on('click',function(){
		var MovePage=$(this).text();
		if($(this).text() == 'Home'){
			MovePage = 'Implication';
		}
		var URL = window.location.href.replace('BoardRead',MovePage);
		$('#SendMember').attr('action',URL).submit();
	});
	BoardDraw(MemberId,Modify);
	
	$('#BackButton').on('click',function(){
 		var URL = window.location.href;
 		URL = URL.replace("BoardRead","Board");
 		$('#SendMember').attr('action',URL).submit();
 		
	})
})
function BoardDraw(M,Num){
	var Loader = '<tr><td colspan="3"><span id="Loader"></span></td></tr>';
	$('#BoardTable tbody').html(Loader);
	$.ajax({
        type: "Post",
        url: 'BoardReadData',
        dataType: 'json',
        data: {
        	'Member' : M,
        	'No':Num
 			
        },
        success: function(json)
        {
        	var No = json.request[0].No;
        	var Title = json.request[0].Title;
        	var CreateDate = json.request[0].CreateDate;
        	var ViewLock = json.request[0].ViewLock;
     		var Content = json.request[0].Content
        	var InsertTR ='';
        	//var PageHTML = '';
        	
      		InsertTR += '<tr>';
      		InsertTR += '<td class="No">'+No;
      		if(ViewLock){
      			InsertTR +='<img class="Lock" src="../resources/images/Lock.jpg" style="width:12px;height:12px;"></td>';	
      		}else{
      			InsertTR +='</td>';	
      		}
      		InsertTR += '<td class="Title">'+Title + '</td>';
      		InsertTR += '<td class="CreateDate">'+CreateDate + '</td>';
      		InsertTR += '</tr>';
      		InsertTR += '<tr><td>내용 : </td><td colspan="2" id="Content" style="text-align:left;"></td></tr>';
      		if(json.ReContent != undefined){
      			
      			for(var j = 0 ; j < json.ReContent.length; j++){
      				InsertTR +='<tr><td>답글 : </td><td style="text-align:left;">'+ json.ReContent[j].Content+'</td><td>'+json.ReContent[j].CreateDate+'</td></tr>';	
      			}
      			
			}
      		InsertTR += '<tr class="input"><td>답글달기 : </td><td colspan=2 style="text-align:left;"><textarea id="TheBoard" style="width:100%; overflow:auto;" rows="7"></textarea></td></tr>';
       		$('#BoardTable tbody').html(InsertTR);
       		$('#Content').html(Content);
       		oEditors = [];
       		nhn.husky.EZCreator.createInIFrame({
       			oAppRef: oEditors,
       			elPlaceHolder: "TheBoard",
       			sSkinURI: "../resources/SE2/SmartEditor2Skin.html",	
       			htParams : {
       				bUseToolbar : false,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
       				bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
       				bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
       				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
       				fOnBeforeUnload : function(){
       					//alert("완료!");
       				}
       			}, //boolean
       			fOnAppLoad : function(){
       				//예제 코드
       				
       			},
       			fCreator: "Shin"
       		});
        },
        error:function(json){
    	    alert('에러.\n');
        }
    });	
}
function submitContents(elClickedObj) {
	oEditors.getById["TheBoard"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	var Data = $('#TheBoard').val();
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	if( Data == ""  || Data == null || Data == '&nbsp;' || Data == '<p>&nbsp;</p>')  {
             alert("내용을 입력하세요.");
             oEditors.getById["TheBoard"].exec("FOCUS"); //포커싱
             return;
        }
	
	try {
		var Con =confirm("답글을 입력하시겠습니까?"); 
		if(Con){
			$("#PopUpArea").height($(document).height());
			$('#PopUpArea').css('display','block');
			$('#PopUpContent').addClass('Loader');
			$.ajax({
		        type: "Post",
		        url: 'BoardInsert',
		        dataType: 'json',
		        data: {
		        	'Member': $('#MemberId').val(),
		        	'No':$('#No').val(),
		        	'Data':Data
		 			
		        },
		        success: function(json)
		        {	
		        	var URL = window.location.href;
		    		$('#SendMember').attr('action',URL).submit();
		        },
		        error:function(json){
		    	    alert('에러.\n');
		        }
		    });
			
		}
	} catch(e) {}
}    

</script>
</head>
<body>
<header>
	<div id='MemberArea'>'<span id='Member'></span>'님 환영합니다.</div>
	<input type='text' id='Today' style='display:none;'/>
		<input type='text' id='TheDate' style='display:none;'/>
	<form id='SendMember' method="post">
		<input type='text' id='MemberId' name='MemberId' style='display:none'/>
		<input type='text' id='MemberName' name='MemberName' style='display:none'/>
		<input id='Page' type='text' name = 'Page' style='display:none;'/>
		<input id='Type' type='text' name = 'Type' style='display:none;'/>
		<input id='No' type='text' name = 'No' style='display:none;'/>
	</form>
	
	<ul id='MenuList'>
		<li id='Home'>Home</li>
		<li id='ReservList'>ReservList</li>
		<li id='DataGraph'>DataGraph</li>
		<li id='Board'>Board</li>
		<li id='RoomManege'>RoomManege</li>
	</ul>
</header>
<content>
   <div id="BoardArea">
      <div id="TitleArea">게시판</div>
      
		<table id='BoardTable' cellspacing='0' cellpadding='0'>
			<colgroup>
				<col width='10%'>
				<col width='60%'>
				<col width='20%'>
			</colgroup>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>등록날짜</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id='ButtonArea' class='clearfix'>
			<ul id='ButtonList'>
				<li><input id='Input' type='button' name = 'Input' value='등록하기' onclick="submitContents(this);"/></li>
				<li><input id='BackButton' type='button' name = 'BackButton' value='돌아가기'/></li>
				
			</ul>
		</div>
  </div>
</content>
<div id='PopUpArea'>
	<div id='PopUpContent' style='display:inline-block; width:75px;height:75px;margin-top:80px;'>
	</div>
</div>
</body>
</html>