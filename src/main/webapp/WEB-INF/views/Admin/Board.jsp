<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="../resources/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/Board.css">
<link rel="stylesheet" type="text/css" href="../resources/css/aReservList.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/Loader.css" />
<link rel="stylesheet" href="../resources/css/Board.css">
<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		var MemberName = '${MemberName}';
		var MemberId = '${MemberId}';
		var ReType = '${Type}';
		$("#Member").append(MemberName);
		$("#MemberName").val(MemberName);
		$('#MemberId').val(MemberId);
		$('#MenuList li').on('click',function(){
			var MovePage=$(this).text();
			if($(this).text() == 'Home'){
				MovePage = 'Implication';
			}
			var URL = window.location.href.replace('Board',MovePage);
			$('form').attr('action',URL).submit();
		});
		ListAJAX(MemberId,$('.Select').attr('id'),0)
        $('.SelectType').on('click',function(){
           $('.SelectType').each(function(){
              $(this).removeClass('Select');
           })
            $('.RoomName').each(function(){
              $(this).removeClass('Select');
           })
           $(this).addClass('Select');
           ListAJAX(MemberId,$(this).attr('id'),0);
           
        });
		
	});
function ListAJAX(ID,Type,RC){
	var MemberId = ID;
	var type = Type;
	$('#PopUpArea').css('display','block');
	$('#PopUpContent').addClass('Loader');
	$.ajax({
        type: "Post",
        url: 'BoardData',
        dataType: 'json',
        data: {
        	'MemberId' :  MemberId,
        	"Type" : type,
        	'RowCount' : RC
        },
        success: function(json)
        {
        	
        	
        	var InsertTR ='';
        	var PageHTML = '';
        	var GetFullRow = json.FullRow;
        	for(var i = 0 ; i < json.request.length ; i++){
        		InsertTR += '<tr>';
        		InsertTR += '<td class="No">'+json.request[i].No;
        		if(json.request[i].ViewLock){
        			InsertTR +='<img class="Lock" src="../resources/images/Lock.jpg" style="width:12px;height:12px;"></td>';	
        		}else{
        			InsertTR +='</td>';	
        		}
        		InsertTR += '<td class="Title">'+json.request[i].Title + '</td>';
        		InsertTR += '<td class="CreateDate">'+json.request[i].CreateDate + '</td>';
        		InsertTR += '</tr>';
        	}
        	$('#PopUpArea').css('display','none');
        	$('#PopUpContent').removeClass('Loader');
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
         		
       			var LoadBoardText = '<input type="text" id="Page" name="Page" style="display:none" />';
       			LoadBoardText +='<input type="text" id="No" name="No" value="'+SelectBoard+'" style="display:none" />';
       			LoadBoardText +='<input type="text" id="Type" name="Type" value="'+$('.Select').attr('id')+'" style="display:none" />';
           		$('#SendMember').append(LoadBoardText);
           		$('#Page').val($('.NowPage').text());
           		var URL = window.location.href;
           		URL = URL.replace("Board","BoardRead");
           		$('#SendMember').attr('action',URL).submit();
         		

         		//alert($(this).siblings('.No').text());
         	})
         	RowCount = json.NowPage;
         	$('#PageList').html(PageHTML);
         	$('#PageList li').bind('click',function(){
         		var CallPage = parseInt($(this).text())-1;
         		ListAJAX(MemberId,type,CallPage);
         	})
        	
        },
        error:function(json , ErrorCode , Error){
        	
    	    alert(Error);//'잘못된 접근입니다.\n');
    	    var URL = window.location.href;
        	URL = URL.replace('Board','Index');
        }
    });

}


</script>
</head>
<body>
<header>
	<div id='MemberArea'>'<span id='Member'></span>'님 환영합니다.</div>
	<form id='SendMember' method="post">
		<input type='text' id='MemberId' name='MemberId' style='display:none'/>
		<input type='text' id='MemberName' name='MemberName' style='display:none'/>
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
	<div id='SelectArea'>
		<span id='AllView' class='SelectType Select'>전부 보기</span>
		<span id='NoneView' class='SelectType'>안읽은것만 보기</span>
	</div>
	<div id="BoardArea">
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
  </div>
</content>
<div id='PopUpArea'>
	<div id='PopUpContent' style='display:inline-block; width:75px;height:75px;margin-top:80px;'>
	</div>
</div>
</body>
</html>