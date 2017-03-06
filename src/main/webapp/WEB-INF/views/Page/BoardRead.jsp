<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Penshion</title>
<link rel="stylesheet" href="../resources/portfolio/css/Index.css">
<link rel="stylesheet" href="../resources/portfolio/css/Board.css">
<link rel="stylesheet" href="../resources/portfolio/css/Loader.css">
<script type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	var Member = $('title').text();
	var Modify = ${No};
	var Page = ${Page} ;
	if(Page== 0){
		alert("잘못된 접근입니다.");
		var URL = window.location.href;
 		URL = URL.replace("BoardRead","Board");
 		window.location.href(URL);
	}else{
		$('#BackBoardPage').val(Page);
	}
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/BoardRead");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
				document.location.href = MoveURL;	
		}
	});
	BoardDraw(Member,Modify);
	
	$('#BackButton').on('click',function(){
 		var URL = window.location.href;
 		URL = URL.replace("BoardRead","Board");
 		$('#ReturnList').attr('action',URL).submit();
 		
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
      			InsertTR +='<img class="Lock" src="../resources/portfolio/images/Lock.jpg" style="width:12px;height:12px;"></td>';	
      		}else{
      			InsertTR +='</td>';	
      		}
      		InsertTR += '<td class="Title">'+Title + '</td>';
      		InsertTR += '<td class="CreateDate">'+CreateDate + '</td>';
      		InsertTR += '</tr>';
      		InsertTR += '<tr><td>내용 : </td><td colspan="2" id="Content" style="text-align:left;"></td></tr>';
      		InsertTR += '<tr><td>수정하기 : </td><td style="text-align:left;"><input type="password" id="Pw" name="Pw"</td><td><input id="ModifyButton" type="button" name = "ModifyButton" value="수정하기"/></td></tr>';
       		$('#BoardTable tbody').html(InsertTR);
       		$('#Content').html(Content);
       		$('#ModifyButton').on('click',function(){
				var PW = $('#Pw').val();
				var No = $('.No').text();
				var M = $('title').text().toLowerCase();
       			//No=No.replace('&Lock&','');
       			var Con = confirm("수정하시겠습니까?");
       			if(Con){
       				$.ajax({
    			        type: "Post",
    			        url: 'LockCheck',
    			        dataType: 'json',
    			        data: {
    			        	'Member':M,
    			        	'No':No,
    			        	'Pw':PW
    			 			
    			        },
    			        success: function(json)
    			        {
    			        	if(json.request){
    			        		var URL = window.location.href;
    			         		URL = URL.replace("BoardRead","BoardInsert");
    			        		var SubmitForm = "<form method='post' id='ModifyForm' style='display:none;'>";
    			        			SubmitForm += "<input type='text' id='ModifyNo' name = 'ModifyNo' value='"+No+"'/>";
    			        			SubmitForm += "<input type='password' id='ModifyPw' name = 'ModifyPw' value='"+PW+"'/>";
    			        			SubmitForm +="</form>";
    			        		$('body').append(SubmitForm);
    			        		$('#ModifyForm').attr('action',URL).submit();
    			        	}else{
    			        		alert('비밀번호가 틀렸습니다.');
    			        	}
    			        },
    			        error:function(json){
    			    	    alert('에러.\n');
    			        }
    			    });	
       			}
			})
			$('#password').on('keypress',function(key){
       		 if (key.keyCode == 13) {
       			$('#ModifyButton').click();
 	          }
       		})
			if(json.request[0].Reply){
				for(var j = 0 ; j < json.ReContent.length ; j++){
					$('#Content').parent('tr').last().after('<tr><td>답글 : </td><td style="text-align:left;">'+ json.ReContent[j].Content+'</td><td>'+json.ReContent[j].CreateDate+'</td></tr>');	
				}
			}
			
        },
        error:function(json){
    	    alert('에러.\n');
        }
    });	
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
				<li><input id='BackButton' type='button' name = 'BackButton' value='돌아가기'/></li>
				
			</ul>
		</div>
  </div>
</content>
	<form method='post' id='ReturnList'>
		<input id='BackBoardPage' type='text' name = 'BackBoardPage' style='display:none;'/>
	</form>
</body>
</html>