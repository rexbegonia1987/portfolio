<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Penshion</title>
<link rel="stylesheet" href="../resources/portfolio/css/Index.css">
<link rel="stylesheet" href="../resources/portfolio/css/Loader.css">
<link rel="stylesheet" href="../resources/portfolio/css/Board.css">
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../resources/portfolio/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){

	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/BoardInsert");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
			document.location.href = MoveURL;	
		}
	})
	$('#Member').val($('title').text().toLowerCase());
	$('#TextLock').on('change',function(){
		if($('#TextLock').prop('checked')){
			$('#LockCheck').text('숨기기');
		}else{
			$('#LockCheck').text('보이기');
		}
	})
	$('#Cancel').on('click',function(){
		$('#Board').click();
	})
	oEditors = [];
	var TextArea="<textarea name='TheBoard' id='TheBoard' rows='10' cols='100' style= 'width:100%; height:412px; min-width:610px; display:none;'></textarea>";
	$('#textArea').html(TextArea);
	var ModifyNo = '${ModifyNo}';
	var Pw = '${ModifyPw}';
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "TheBoard",
		sSkinURI: "../resources/portfolio/SE2/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			if(ModifyNo !='' && Pw !=''){
				$.ajax({
			        type: "Post",
			        url: 'BoardModify',
			        dataType: 'json',
			        data: {
			        	'Member': $('title').text(),
			        	'No':ModifyNo,
			        	'Pw':Pw
			 			
			        },
			        success: function(json)
			        {
			        	if(json.Result){
			        		$('#TextTitle').val(json.request[0].Title);
			        		$('#TextPw').val(Pw);
			        		oEditors.getById["TheBoard"].exec("PASTE_HTML", [json.request[0].Content]);
			        		if(json.Lock){
			        			$('#TextLock').attr('checked','true');
			        			$('#LockCheck').text('숨기기');
			        		}
			        		$('#BoardTable tbody').prepend("<tr style='display:none;'><th>No : </th><td colspan='3'><input type='text' id='ModifyNo' name='ModifyNo' value='"+ModifyNo+"' style='display:none;'/></td></tr>")
			        		$('#SubmitButton').val('수정하기');
			        	}else{
			        		alert('잘못된 접근입니다.');
			        	}
			        },
			        error:function(json){
			    	    alert('에러.\n');
			        }
			    });
			}
		},
		fCreator: "Shin"
	});
	
})
function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["TheBoard"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["TheBoard"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["TheBoard"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	var Data = $('#TheBoard').val();
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	 if($('#TextTitle').val() == ""  || $('#TextTitle').val() == null || $('#TextTitle').val() == '&nbsp;'){
	    	alert("제목을 입력하세요.");
	    	$('#TextTitle').focus();
	    	return;
    }else if($('#TextPw').val() == ""  || $('#TextPw').val() == null || $('#TextPw').val() == '&nbsp;'){
    	alert("비밀번호를 입력하세요.");
    	$('#TextPw').focus();
    	return;
    }else if( Data == ""  || Data == null || Data == '&nbsp;' || Data == '<p>&nbsp;</p>')  {
        alert("내용을 입력하세요.");
        oEditors.getById["TheBoard"].exec("FOCUS"); //포커싱
        return;
    }
	
	try {
		var Con =confirm("글을 입력하시겠습니까?"); 
		if(Con){
			elClickedObj.form.submit();
		}
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["TheBoard"].setDefaultFont(sDefaultFont, nFontSize);
}      

</script>
</head>
<body>
<header class='clearfix'>
	<div id='al-cn'>
	<a href="Introduce"><img src="../resources/portfolio/images/logo.jpg" style="width:200px;display:inline-block;float:left;margin-top:20px;"></a>
		<div class='clearfix'>
			<ul id='gbn' class='clearfix'>
				<li id='gbnHome' class='GBN'>
					<a href ="#">Home</a>
				</li>
				<li id='direction' class='GBN'>
					오시는 길
				</li>
				<li id='gbnreservation' class='GBN'>
					예약
				</li>
			</ul>
		</div>
		<div class='clearfix'>
			<ul id='menu'>
				<li id='home' class='MenuList'>Introduce</li>
				<li id='room' class='MenuList'>Room</li>
				<li id='Reservation' class='MenuList'>Reservation</li>
				<li id='Board' class='MenuList'>Board</li>
				<li id='direction' class='MenuList'>Direction</li>
			</ul>
		</div>
	</div>
</header>
<content>
   <div id="BoardArea">
      <h3 id="TitleArea">게시판</h3>
      <form action="InsertData" method="post">
      <input type = "text" id = "Member" name = "Member" style="display:none;"/>
		<table id='BoardTable' cellspacing='0' cellpadding='0'>
			<colgroup>
				<col>
				<col span='2'>
				<col>
				<col span='2'>
			</colgroup>
			<tr>
				<th>
					제목 : 
				</th>
				<td colspan='3' style='text-align:left;'>
					<input type='text' id='TextTitle' name = 'TextTitle' placeholder='제목을 적어주세요'/>
				</td>
			</tr>
			<tr>
				<th span='1'>
					비밀번호 : 
				</th>
				<td span='2'>
					<input type='password' id='TextPw' name = 'TextPw' placeholder='비밀번호'/>
				</td>
				<th span='1'>
					숨기기 : 
				</th>
				<td span='3'>
					<label>
						<span id='LockCheck'>보이기</span>
					<input type='checkbox' id='TextLock' name = 'TextLock' />
					</label>
				</td>
			</tr>
			<tr>
				<td id='textArea' colspan='4'></td>
			</tr>
		</table>
		
		<p>
			
			<input type="button" onclick="submitContents(this);" id='SubmitButton' value="저장하기" />
			<input type="button" id='Cancel' value="취소하기"/>
			
		</p>
</form>
  </div>
</content>
	
	
</body>
</html>