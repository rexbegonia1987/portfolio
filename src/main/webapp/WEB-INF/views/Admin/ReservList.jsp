<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="../resources/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/aReservList.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/Loader.css" />
<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		var MemberName = '${request.MemberName}';
		var MemberId = '${request.MemberId}';
		$('#MenuList li').on('click',function(){
			var MovePage=$(this).text();
			if($(this).text() == 'Home'){
				MovePage = 'Implication';
			}
			var URL = window.location.href.replace('ReservList',MovePage);
			$('form').attr('action',URL).submit();
		});
		var sDate = new Date();
		var YEAR = sDate.getFullYear();
		var MONTH = sDate.getMonth()+1;
		var DATE = sDate.getDate();
		var StartDate = YEAR+'-'+TransInt(MONTH)+'-'+TransInt(DATE);
		$('#Today').val(StartDate);
		$('#TheDate').val(StartDate);
		$("#Member").append(MemberName);
		$("#MemberName").val(MemberName);
		$('#MemberId').val(MemberId);
		$('tbody').html('<tr class="LoadArea"><td colspan="14"><span id="Loader"></span></td></tr>');
		ListAJAX(MemberId,$('#TheDate').val());
		$('#NextWeekData').on('click',function(){
			ListAJAX(MemberId,$('#TheDate').val());	
		})
		//$('#TheDate').val()
		
	});
function ListAJAX(ID,DATE){
	$.ajax({
        type: "Post",
        url: 'ReservListData',
        dataType: 'json',
        data: {
        	'ID' :  ID,
        	'Date' : DATE
        },
        success: function(json)
        {
        	
        	var InputJSONData = '';
        	for(var i = 0 ; i < json.request.length; i++){
        		InputJSONData += "<tr>";
        		InputJSONData += "<td class='Reservater'>"+json.request[i].Reservater+"</td>";
        		InputJSONData += "<td class='ReservNumber'>"+json.request[i].ReservNumber+"</td>";
        		InputJSONData += "<td class='ReservRoom'>"+json.request[i].ReservRoom+"</td>";
        		InputJSONData += "<td class='AmountPeople'>"+json.request[i].AmountPeople+"</td>";
        		InputJSONData += "<td class='SelectDate'>"+json.request[i].SelectDate+"</td>";
        		InputJSONData += "<td class='ReservPhone'>"+json.request[i].ReservPhone+"</td>";
        		InputJSONData += "<td class='Pay'>"+toCurrencyString(json.request[i].Pay)+"</td>";
        		if(json.request[i].Grill){
        			InputJSONData += "<td class='Grill'>사용</td>";	
        		}else{
        			InputJSONData += "<td class='Grill'>미사용</td>";
        		}
        		if(json.request[i].Barbecue){
        			InputJSONData += "<td class='Barbecue'>신청</td>";	
        		}else{
        			InputJSONData += "<td class='Barbecue'>미신청</td>";
        		}
        		InputJSONData += "<td class='DepositWay'>"+json.request[i].DepositWay+"</td>";
        		if(!json.request[i].DepositCheck){
        			InputJSONData += "<td class ='DepositCheck'>입금대기</td>";
        		}else{
        			InputJSONData += "<td class ='DepositCheck'>입금완료</td>";
        		}
        		if(!json.request[i].DepositSet){
        			InputJSONData += "<td class='DepositSet'>확정대기</td>";	
        		}else{
        			InputJSONData += "<td class='DepositSet'>예약확정</td>";
        		}
        		if(json.request[i].CancelCheck){
        			InputJSONData += "<td class='CancelCheck'>예약취소</td>";	
        		}else{
        			InputJSONData += "<td class='CancelCheck'>예약중</td>";
        		}
        		InputJSONData += "<td class='ReservDate'>"+json.request[i].ReservDate+"</td>";
        		InputJSONData += "<td class='Text' style='display:none'>"+json.request[i].Text+"</td>";
        		InputJSONData+="</tr>";
        	}
        	$('.LoadArea').html('<td colspan="14"><span id="Loader"></span></td>')
        	$('tbody').append(InputJSONData);
        	$('.LoadArea').html('');
        	$('#TheDate').val(json.NextDate);	
        	$('tbody tr').bind('click',function(){
        		var PopUpSendData= new Array();
        		var i = 0;
    			$(this).children('td').each(function(){
    				PopUpSendData[i] = $(this).attr('class') + "&" + $(this).text();
    				i++;
    			})
    			PopUpFuc(PopUpSendData);
    		})
        	
        },
        error:function(json , ErrorCode , Error){
        	
    	    alert(Error);//'잘못된 접근입니다.\n');
    	    var URL = window.location.href;
        	URL = URL.replace('implication','Index');
        }
    });
}
function TransInt(num){
	var NUM = parseInt(num);
	var Result;
	if(NUM<10){
		Result = '0'+NUM;
	}else{
		Result=NUM;
	}
	return Result;
}
function PopUpFuc( A ){
	var ReceiveName = new Array();
	var ReceiveData = new Array();
	var DataHTML = "<table id='PopUpData' border ='1' style='border-collapse:collapse;'>";
		DataHTML +="<thead><tr><th colspan = '4'>예 약 확 인</th></tr></thead><tbody>";
	var Temp = new Array();
	for(var i = 0 ; i < A.length ; i++){
		Temp = A[i].split("&");
		ReceiveName[i] = Temp[0];
		ReceiveData[i] = Temp[1];
	}
		DataHTML+="<tr><th>예약자명 :</th><td class ='"+ ReceiveName[0] +"'>" + ReceiveData[0]+"</td>";
		DataHTML+="<th>예약자번호 :</th><td class ='"+ ReceiveName[1] +"'>" + ReceiveData[1]+"</td></tr>";
		DataHTML+="<tr><th>예약한 방 :</th><td class ='"+ ReceiveName[2] +"'>" + ReceiveData[2]+"</td>";
		DataHTML+="<th>인원 :</th><td class ='"+ ReceiveName[3] +"'>" + ReceiveData[3]+"</td></tr>";
		DataHTML+="<tr><th>선택일 :</th><td class ='"+ ReceiveName[4] +"'>" + ReceiveData[4]+"</td>";
		DataHTML+="<th>전호번호 :</th><td class ='"+ ReceiveName[5] +"'>" + ReceiveData[5]+"</td></tr>";
		DataHTML+="<tr><th>바베큐 신청 :</th><td class ='"+ ReceiveName[8] +"'>" + ReceiveData[8]+"</td>";
		DataHTML+="<th>그릴 사용 :</th><td class ='"+ ReceiveName[7] +"'>" + ReceiveData[7]+"</td></tr>";
		DataHTML+="<tr><th>금액 :</th><td class ='"+ ReceiveName[6] +"'>" + ReceiveData[6]+"</td>";
		DataHTML+="<th>입금방법 :</th><td class ='"+ ReceiveName[9] +"'>" + ReceiveData[9]+"</td></tr>";
		DataHTML+="<tr><th>입금여부 :</th><td class ='"+ ReceiveName[10] +"'>" + ReceiveData[10]+"</td>";
		if(ReceiveData[11] == "확정대기"){
			DataHTML +="<th>예약확정 여부 : </th><td class ='"+ ReceiveName[11] +"'><input type='button' id='SetDeposit' name='SetDeposit' value='확정하기'/></td></tr>";
		}else{
			DataHTML +="<th>예약확정 여부 :</th><td class ='"+ ReceiveName[11] +"'>" + ReceiveData[11]+"</td></tr>";
		}
		DataHTML+="<tr><th>취소여부 :</th><td class ='"+ ReceiveName[12] +"'>" + ReceiveData[12]+"</td>";
		DataHTML+="<th>예약일 :</th><td class ='"+ ReceiveName[13] +"'>" + ReceiveData[13]+"</td></tr>";
		DataHTML+="<tr><th>남기실말 :</th><td class ='"+ ReceiveName[14] +"' colspan='3'>" + ReceiveData[14]+"</td></tr>";
		
		DataHTML += "</tbody></table><span id='PopUPClose'>닫기</span>";
	
	
	$('#PopUpContent').html(DataHTML);
	$('#PopUpArea').height($(document).height());
	$('#PopUPClose').on('click',function(){
		$('#PopUpArea').css('display','none');
		$('#PopUpContent').html('');
	})
	$('#PopUpArea').css('display','block');
	$(':button[name="SetDeposit"]').bind('click',function(event){
			var Deposit = confirm("예약확정을 하시겠습니까?");
			if(Deposit){
				$.ajax({
			        type: "Post",
			        url: 'DepositSet',
			        dataType: 'json',
			        data: {
			        	'ID' :  $('#MemberId').val(),
			        	'SelectDate' : $('#PopUpData td.SelectDate').text(),
			        	'ReservNumber' : $('#PopUpData td.ReservNumber').text()
			        },
			        success: function(json)
			        {
			        	alert("예약확정을 하셨습니다.");
			        	$('#ReservThisWeek tbody').html("");
			        	$('#PopUPClose').click();
			        	var Reset = $('#Today').val()+":"+$('#TheDate').val();
			        	ListAJAX($('#MemberId').val(),Reset);
			        	
			        },
			        error:function(json , ErrorCode , Error){
			        	
			    	    alert(Error);//'잘못된 접근입니다.\n');
			    	    var URL = window.location.href;
			        	URL = URL.replace('implication','Index');
			        }
			    });
			}else{
				alert("예약확정을 취소하셨습니다.");
			}
	})
}
function toCurrencyString(strCurrency) { 

    strCurrency += ""; 
    var isMinus = false; 
    var sSecond = "";      //정수의 문자열 
    strlen  = strCurrency.length; 
    cntLoop = Math.floor(strlen / 3); 
    rem     = strlen % 3; 
    if(rem == 0) { rem = 3; cntLoop--; } 
    result = strCurrency.substr(0, rem); 
    for(ipos = 0 ; ipos < cntLoop ; ipos++) 
    result += "," + strCurrency.substr(3 * ipos + rem , 3); 
    return result; 

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
		<table id='ReservThisWeek' border ='1' style='border-collapse:collapse;'>
			<thead>
				<tr>
					<th>예약자</th>
					<th>예약번호</th>
					<th>예약방</th>
					<th>예약인원</th>
					<th>선택날짜</th>
					<th>전화번호</th>
					<th>금액</th>
					<th>그릴사용</th>
					<th>바베큐요청</th>
					<th>입금방법</th>
					<th>입금여부</th>
					<th>예약확정</th>
					<th>취소여부</th>
					<th>예약날짜</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<div id='NextWeekData'>다음 한주의 예약 보기</div>
</content>
<div id='PopUpArea'>
	<div id='PopUpContent'>
	</div>
</div>
</body>
</html>