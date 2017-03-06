<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="../resources/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/aimpication.css" />
<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		var MemberName = '${request.MemberName}';
		var MemberId = '${request.MemberId}';
		$("#Member").append(MemberName);
		$('#MemberName').val(MemberName);
		$('#MemberId').val(MemberId);
		$('#MenuList li').on('click',function(){
			var MovePage=$(this).text();
			if($(this).text() == 'Home'){
				MovePage = 'Implication';
			}
			var URL = window.location.href.replace('Implication',MovePage);
			$('form').attr('action',URL).submit();
		})
		$.ajax({
	        type: "Post",
	        url: 'ImplicationData',
	        dataType: 'json',
	        data: {
	        	'ID' :  $('#MemberId').val()
	        },
	        success: function(json)
	        {
	        	var Resulttbody = "<tr><td class='ReservRoom'>";
	        	var ReservRoom = json.request.TodayRoom;
	        	var ResponseDeposit = 0;
	        	var TodayReservData='';
	        	if(ReservRoom.length !=0){
	        		for(var i = 0 ; i < ReservRoom.length ; i++){
		        		Resulttbody += "<span class='rRoom'>"+ReservRoom[i] + "</span>"
		        		TodayReservData += "<tr><td>"+ReservRoom[i] +"</td><td>"+json.request.Reservater[i] +"</td><td>"+json.request.AmountPeople[i]+"</td><td>"+json.request.ReservNumber[i]+"</td><td>"+ json.request.ReservPhone[i]+"</td>";
		        		if(json.request.TodayDepositCheck[i]){
		        			TodayReservData +="<td>예약확정</td>";
		        		}else{
		        			TodayReservData +="<td>입금대기</td>";
		        		}
		        		if(json.request.Grill[i]){
		        			TodayReservData+="<td>"+json.request.AmountPeople[i]+"명</td>"
		        		}else{
		        			TodayReservData+="<td>0명</td>"
		        		}
		        		if(json.request.Barbecue[i]){
		        			TodayReservData+="<td>"+json.request.AmountPeople[i]+"명</td>"
		        		}else{
		        			TodayReservData+="<td>0명</td>"
		        		}
		        		TodayReservData+="</tr>";
		        	}	
	        	}else{
	        		Resulttbody+="예약이 없습니다.";
	        	}
	        	
        		Resulttbody+="</td><td>";	        	
	        	$('#TodayReserver tbody').html(TodayReservData);
	        	
	        	
	        	
	        	for(var j = 0 ; j < json.request.DepositSet.length ; j++){
	        		if(json.request.DepositCheck[j]){
	        			if(!json.request.DepositSet[j]){
	        				ResponseDeposit++;
	        			}
	        		}
	        	}
	        	Resulttbody += ResponseDeposit +"건 있습니다</td><td>";
	        	Resulttbody += json.request.DepositCount + "건 있습니다</td><td>";
	        	Resulttbody += 0 + "건 있습니다</td><td>";
	        	Resulttbody += json.request.CancelCheckCount + "건 </td>"
	        	
	        	$('#ReservThisWeek tbody').html(Resulttbody);
	        	$('.rRoom').parents('td').on('click',function(){
	        		$('#PopUpArea').css('display','block');
	        	})
	        	
	        },
	        error:function(json , ErrorCode , Error){
	        	
	    	    alert(Error);//'잘못된 접근입니다.\n');
	    	    var URL = window.location.href;
	        	URL = URL.replace('implication','Index');
	        }
	    });
		$('#PopArea').height($(document).height());
		$('#PopUPClose').on('click',function(){
			$('#PopUpArea').css('display','none');
		})
		
	})
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
	<div id='DataForm'>
		<table id='ReservThisWeek' border='1' style='border-collapse:collapse;'>
			<thead>
				<tr>
					<th>오늘의 예약</th>
					<th>예약확인요청</th>
					<th>새로운 예약</th>
					<th>문의</th>
					<th>예약취소</th>
					<!-- <th>금액</th> -->
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</content>
<div id='PopUpArea'>
	<div id='PopUpContent'>
		<div>금일 예약현황</div>
		<table id='TodayReserver' border ='1' style='border-collapse:collapse;' >
			<thead>
				<tr>
					<th>예약방</th>
					<th>예약자명</th>
					<th>예약자 수</th>
					<th>예약번호</th>
					<th>예약자전화번호</th>
					<th>입금현황</th>
					<th>그릴</th>
					<th>바베큐</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<span id='PopUPClose' name='PopUPClose'>닫기</span>
	</div>
</div>
</body>
</html>