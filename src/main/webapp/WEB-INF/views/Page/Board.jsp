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
<!--  <script src = '../js/jquery-ui.min.js'></script>-->
<script type="text/javascript">
$(document).ready(function(){
	var Member = $('title').text();
	var ReturnPageNum = 0;
	var RowCount=0;
	if(ReturnPageNum != 0){
		RowCount = ReturnPageNum-1;
	}
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/Board");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
				document.location.href = MoveURL;	
		}
	});
	BoardDraw(Member,RowCount);
})
function BoardDraw(M,RC){
	var Loader = '<tr><td colspan="3"><span id="Loader"></span></td></tr>';
	$('#BoardTable tbody').html(Loader);
	var RowCount=0;
	$.ajax({
        type: "Post",
        url: 'BoardList',
        dataType: 'json',
        data: {
        	'Member' : M,
        	'RowCount':RC
 			
        },
        success: function(json)
        {
        	var InsertTR ='';
        	for(var i = 0 ; i < json.request.length; i++){
        		
        		InsertTR += '<tr>';
        		InsertTR += '<td class="No">'+json.request[i].No;
        		if(json.request[i].ViewLock){
        			InsertTR +='<img class="Lock" src="../resources/portfolio/images/Lock.jpg" style="width:12px;height:12px;"></td>';	
        		}else{
        			InsertTR +='</td>';	
        		}
        		InsertTR += '<td class="Title">'+json.request[i].Title + '</td>';
        		InsertTR += '<td class="CreateDate">'+json.request[i].CreateDate + '</td>';
        		InsertTR += '</tr>';
        	}
        	
        	var Number  = parseInt(json.Row)-1;
        	
        	var PageHTML = '';
        	var GetFullRow = json.FullRow;
         	$('#BoardTable tbody').html(InsertTR);
         	for(var i = 0 ; i < GetFullRow/10 ; i++){
         		if(parseInt(json.NowPage) == i){
         			PageHTML+="<li class='NowPage' style='background-color:#ccc'>"+ (i+1) +"</li>";
         		}else{
         			PageHTML+="<li>"+ (i+1) +"</li>";	
         		}
         		
         	}
         	$('#BoardTable td').bind('click',function(){
         		var Check = $(this).attr('class');
         		var Lock = false;
         		var SelectBoard;
         		if(Check == 'No'){
         			SelectBoard = $(this).text();
         			
         		}else{
         			SelectBoard = $(this).siblings('.No').text();
         		}
         		if($(this).children('img').is('.Lock') ||  $(this).siblings('.No').children('img').is('.Lock')){
         			var Lock ='';
         			Lock+="<p>암호임력</p>";
         			Lock+="<p><input type='password' id='LockPassword' name='LockPassword'/></p>";
         			Lock+="<p><input type='button' id='LockSub' name='LockSub' value='확인'/><input type='button' id='LockCancel' name = 'LockCancel' value='취소'/></p>";
         			$('body').append('<div id="LockArea" style="position:absolute;top:0;left:0;width:100%;height:'+$(document).height()+'px;background-color:rgba(150,150,150,0.8);"><div id="ReadLock" style="background-color:#fff;text-align:center;border:1px solid #ccc;width:200px;height:200px;position:absolute;left:'+($(window).width()/2-100)+'px;top:'+($(window).height()/2-100)+'px;"></div></div>');
         			$('#ReadLock').html(Lock);
         			$('#LockCancel').on('click',function(){
         				$('#LockArea').remove();
         			})
         			$('#LockSub').on('click',function(){
         				var Pw = null;
         				Pw = $('#LockPassword').val();
         				if(Pw != null && Pw.length >=4){
         					$.ajax({
             			        type: "Post",
             			        url: '/LockCheck',
             			        dataType: 'json',
             			        data: {
             			        	'Member' : M,
             			        	'No': SelectBoard,
             			        	'Pw':Pw
             			 			
             			        },
             			        success: function(json)
             			        {
             			        	if(json.result){
             			        		var LoadBoardText = '<form method="POST" id="SendData" style="display:none;"><input type="text" id="Page" name="Page" /><input type="text" id="No" name="No" value="'+SelectBoard+'"/></form>';
             		             		$('body').append(LoadBoardText);
             		             		$('#Page').val($('.NowPage').text());
             		             		var URL = window.location.href;
             		             		URL = URL.replace("Board","BoardRead");
             		             		$('#SendData').attr('action',URL).submit();
             			        	}else{
             			        		alert('비밀번호가 틀렸습니다!');
             			        	}
             			        	
             			       },
             			        error:function(json){
             			    	    alert('에러!!!.\n');
             			        }
             			    });	
         				}else{
         					alert("입력하신 내용이 너무 짧습니다.");
         				}
         			})
         			$('#LockPassword').on('keydown',function(key){
         				if (key.keyCode == 13) {
         	       			$('#LockSub').click();
         	 	          }
         			})
         		
         		}else{
         			var LoadBoardText = '<form method="POST" id="SendData" style="display:none;"><input type="text" id="Page" name="Page" /><input type="text" id="No" name="No" value="'+SelectBoard+'"/></form>';
             		$('body').append(LoadBoardText);
             		$('#Page').val($('.NowPage').text());
             		var URL = window.location.href;
             		URL = URL.replace("Board","BoardRead");
             		$('#SendData').attr('action',URL).submit();
         		}

         		//alert($(this).siblings('.No').text());
         	})
         	RowCount = json.NowPage;
         	$('#PageList').html(PageHTML);
         	$('#PageList li').bind('click',function(){
         		var CallPage = parseInt($(this).text())-1;
         		BoardDraw(M,CallPage);
         	})
        },
        error:function(json , status, error){
        	
    	    alert(error);
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
		<p id='PageArea' class='clearfix'>
			<ul id='PageList'>
			</ul>
		</p>
		<a href='BoardInsert'>글쓰기</a>
  </div>
</content>
	
	
</body>
</html>