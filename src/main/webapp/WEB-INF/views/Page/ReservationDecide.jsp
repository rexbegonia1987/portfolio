<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약하기</title>
<link rel="stylesheet" type="text/css" href="../resources/portfolio/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/portfolio/css/ReservDecide.css" />
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){		
		var Member = '${Member}';
		var AmountPeople =  ${AmountPeople};
		var Room =   '${SelectRoom}';
		var SelectDate = '${sDate}';
		var NumOfPeople = ${NumOfPeople};
		var Grill = '${Grill}';
		if(Grill == 'on'){
			Grill = '1';
		}else{
			Grill = '0';
		}
		var Barbecue = '${Barbecue}';
		if(Barbecue == 'on'){
			Barbecue = '1';
		}else{
			Barbecue ='0'
		}
		var ShowDate = SelectDate.split('-');
		var SendBill = 0;
		var AddBill = 0;
		var GrillBill = 0;
		var BarbecueBill = 0;
		var AddPeople = AmountPeople - NumOfPeople;
		var ShowBill = SendBill;
		
		$('.MenuList').click(function(){
			if($(this).text() != "Home"){
				var SelectPage = $(this).text()+".jsp";
				var EXP=document.location.href.split("/ReservationDecide");
				var	MoveURL=EXP[0];
					MoveURL=MoveURL+"/";
					MoveURL+=SelectPage;
				document.location.href = MoveURL;	
			}
			
		})
		
		$.ajax({
			 type: "Post",
		        url: 'ReservRoomData',
		        dataType: 'json',
		        data: {
		        	'Member' : Member,
		 			'Room' : Room,
		 			'SelectDate' : SelectDate
		        },
		        success: function(json)
		        {
		        	var SumBill=0;
		        	SendBill = json.request[0].Bill;

		        	var OutPutText = toCurrencyString(SendBill) + " ( 방값 )";
		        	if(AddPeople != 0){
		        		OutPutText += " + " + toCurrencyString(json.request[0].AddBill) + "  X " + AddPeople + " ( 추가인원 ) "; 
		        		AddBill = json.request[0].AddBill * AddPeople;
		        	}
	        		if(Grill != 0){
	        			OutPutText += " + " + toCurrencyString(json.request[0].Grill) + " X " + AmountPeople + " ( 그릴사용비 ) ";
	        			GrillBill = json.request[0].Grill *AmountPeople;
	        		}
		        	if(Barbecue != 0){
		        		OutPutText += " + " + toCurrencyString(json.request[0].Barbecue) + " X " + AmountPeople + " ( 바베큐이용비 ) ";
		        		BarbecueBill = json.request[0].Barbecue * AmountPeople;
		        	}
		        	
		        	SumBill = SendBill + AddBill + GrillBill + BarbecueBill 
		        	OutPutText += " = " + toCurrencyString(SumBill) + "원";
		        	$('#SendBill').val(SumBill);
		        	$('#ShowBill').prepend(OutPutText);
		         	
		        },
		        error:function(json){
		    	    alert('에러.\n');
		        }
		    });		
		
		
		$('#ShowDate').prepend(ShowDate[0] + '년' + ShowDate[1] + '월' + ShowDate[2] + '일');
		$('#SendDate').val(SelectDate);
		$('#ShowRoom').prepend(Room);
		$('#SendRoom').val(Room);
		$('#PeopleNum').prepend(AmountPeople);
		$('#SendPeopleNum').val(AmountPeople);
		$('#SendPay').val($('#Pay').val());
	
		$('#Pay').change(function(){
			$('#SendPay').val($(this).val());
		});
		$('#Pw').on('keypress',function(e){
			if($(this).val().length >3){
				e.preventDefault ? e.preventDefault() : e.returnValue = false;
			}
		})
		
		$('#ReservSubmit').click(function(){
				
			var Check = true;
			$('input[type="text"]').each(function(){
				if($(this).val() ==''){
					Check=false;
				} 
			})
			if(Check){
				$.ajax({
			        type: "Post",
			        url: 'ReservDecide',
			        dataType: 'json',
			        data: {
			 			'Member' : Member,
			        	'Date' : $('#SendDate').val(),
			 			'Room' : $('#SendRoom').val(),
			 			'PeopleNum' : $('#SendPeopleNum').val(),
			 			'Reservater' : $('#Reservater').val(),
			 			'PhoneNumber' : $('#PhoneNumber').val(),
			 			'Pw' : $('#Pw').val(),
			 			'Bill' : $('#SendBill').val(),
			 			'Pay' : $('#SendPay').val(),
			 			'Text' : $('#Text').text(),
			 			'Barbecue' : Barbecue,
			 			'Grill' : Grill
			        },
			        success: function(json)
			        {
			        	if(json.request.Result){
			        		alert("예약이 완료되었습니다.\n예약번호 : " + json.request.ReservNum);
			        		var URL = window.location.href;
			    			URL = URL.replace('ReservationDecide','Reservation');
			    			window.location.href(URL);
			        	}else{
			        		alert("이미 예약자가 있습니다.");
			        		var URL = window.location.href;
			    			URL = URL.replace('ReservationDecide','Reservation');
			    			window.location.href(URL);
			        	}
			        	
			        },
			        error:function(json){
			    	    alert('예약에 실패하였습니다.');
			        }
			    });
			}else{
				alert("예약자명과 전화번호와 비밀번호는 필수 입력사항입니다.");
			}
			
		})
		$('#ReservCancel').click(function(){
			if(confirm("예약을 취소하시겠습니까?")){
				var URL = window.location.href;
    			URL = URL.replace('ReservationDecide','Reservation');
    			window.location.href(URL);
			}
		})
		
	})
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
	<h1>예약 정보</h1>
	<table id='DataTable' style=''>
		<tbody>
			<tr><th> 예약일 : </th><td id='ShowDate'><input type='text' name = 'SendDate' id='SendDate' style='display:none;'/></td></tr>
			<tr><th> 예약하신 방 : </th><td id='ShowRoom'><input type='text' name = 'SendRoom' id='SendRoom' style='display:none;'/></td></tr>
			<tr><th> 예약인원 : </th><td  id='PeopleNum'>명<input type='text' name='SendPeopleNum' id='SendPeopleNum' style='display:none'/>
			<tr><th> 예약자명 : </th><td ><input type='text' id='Reservater' name='Reservater'/></td></tr>
			<tr><th> 전화번호 : </th><td><input type='text' id='PhoneNumber' name='PhoneNumber'/></td></tr>
			<tr><th> 비밀번호 : </th><td><input type='text' id='Pw' name='Pw' placeholder ="4자리만 입력됩니다"/></td></tr>
			<tr><th> 결제금액 : </th><td id='ShowBill'></span><inpupt type='text' id='SendBill' name = 'SendBill'/></td></tr>
			<tr><th> 입금방법 : </th><td><select name='Pay' id='Pay'><option>무통장입금</option><option>카드결제</option><input type='text' id='SendPay' name='SendPay' style='display:none' /></select>
			<tr><th> 남기실 말  : </th><td><textarea id='Text' name='Text' placeholder='남기실말을 적어주세요.'></textarea></td></tr>
		</tbody>
	</table>
	<div class='ButtonArea'><input type='button' name='ReservSubmit' id='ReservSubmit' value='예약하기'><input type='button' id='ReservCancel' name='ReservCancel' value='취소하기'/></div>
</content>

</body>
</html>