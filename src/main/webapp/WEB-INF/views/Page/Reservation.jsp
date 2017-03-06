<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Penshion</title>
<link rel="stylesheet" type="text/css" href="../resources/portfolio/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/portfolio/css/Calendar.css" />
<link rel="stylesheet" href="../resources/portfolio/css/jquery-ui.min.css">
<link rel="stylesheet" href="../resources/portfolio/css/jquery-ui.structure.min.css">
<link rel="stylesheet" href="../resources/portfolio/css/jquery-ui.theme.min.css">
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>


<script type="text/javascript">
$(document).ready(function(){
	
	//var TempMember = window.location.href.split('.');
	var CatchMember = 'penshion';// TempMember[1];
	$('#Member').val(CatchMember);
	var NowDate = new Date();
	CalendarCall(NowDate.getFullYear(), NowDate.getMonth());
	$('#LastMonth').click(function(){
		var LastMonth = parseInt($('#NowMonth').text())-2;
		var NowYear = parseInt($('#NowYear').text());
		if(LastMonth<0){
			NowYear = NowYear-1;
			LastMonth = 11;
		}
		CalendarCall(NowYear, LastMonth);
	})
	$('#NextMonth').click(function(){
		var NextMonth = parseInt($('#NowMonth').text());
		var NowYear = parseInt($('#NowYear').text());
		if(NextMonth>11){
			NowYear = NowYear+1;
			NextMonth = 0;
		}
		CalendarCall(NowYear, NextMonth);
	})
	$('#MoveToday').click(function(){
		CalendarCall(NowDate.getFullYear(), NowDate.getMonth());
	})
	
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/Reservation");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
			document.location.href = MoveURL;	
		}
		
	})
	$('#PopUpClose').click(function(){
		$('#PopUpArea').addClass('hide');
		$('.LeftForm').html("");
	})
	$('#RCancel').on('click',function(){
		$('#PopUpArea').addClass('hide');
		$('.LeftForm').html("");
	});
	$('#RSubmit').on('click', function(){
		if($('#SelectRoom').val() != ""){
			var URL = window.location.href;
			URL = URL.replace('Reservation','ReservationDecide');
			
			$('#ReservData').attr('action',URL).submit();
			
		}else{
			alert("방을 선택해주세요");
		}
	})
	$('#Grill').on('change',function(){
		if($(this).is(":checked")){
			$('#Barbecue').removeAttr('disabled','false');	
		}else{
			$('#Barbecue').prop('disabled','true');
		}
		
	})
	$('#CloseReserv').on('click',function(){
		$(this).parent().parent().html('');
	})
	function CalendarCall(y,m){
		
		$('#NowYear').text(y);
		$('#NowMonth').text(m+1);
		$('#CalendarData').html('');
		
		 $.ajax({
		        type: "Post",
		        url: 'ReservationData',
		        dataType: 'json',
		        data: {
		        	'Member' : CatchMember,
		 			'Year' : y,
		 			'Month' : m
		        },
		        success: function(json)
		        {
		        	var RoomsName = json.request.RoomsName;
		         	DrawCalendar(json.request.Data, json.request.WeekOfDate,RoomsName,json.request.ReservData,json.request.ReservDataLine);
		         	
		        },
		        error:function(json){
		    	    alert('에러.\n');
		        }
		    });	
	}
	function DrawCalendar(A , W , R , RD , RDL){
		var Data = A;
		var Temp=0;
		var TempDate;
		var DataInput;
		var RoomsName= R.split(",");
		var ReservData=new Array(RDL);
		var TempReservData;
		var LineCheck = 0;
		var TempReservDate;
		
			
			for(var l = 0 ; l < RDL ; l++){
				TempReservData = RD[l].split(":");
				ReservData[l] = TempReservData;
			}
			
			for(var i = 0 ; i < W ; i++){
				$('#CalendarData').append("<tr>");
				for(var j = 0 ; j < 7 ; j++){
					DataInput = "<td class='NomalDay'>";
					if( i == 0 && parseInt(Data[Temp]) > 7){
						DataInput += "<span class = 'Date Data0"+Data[Temp]+"'>"+Data[Temp]+"</span>";	
						
					}else if(i >2 && parseInt(Data[Temp]) < 7){
						DataInput += "<span class = 'Date Data20"+Data[Temp]+"'>"+Data[Temp]+"</span>";
					}else{
						DataInput += "<span class = 'Date Data1"+Data[Temp]+"'>"+Data[Temp]+"</span>";
					}
					
					for(var k = 0; k < RoomsName.length ; k++){
						
							DataInput +="<span class = 'RoomsName "+ k +"'>" + RoomsName[k] + "</span>";					
						
					}
					DataInput += "</td>";
					$('#CalendarData').append(DataInput);
					Temp++;
				
				}
				$('#CalendarData').append("</tr>");
			}
		if(parseInt($('#NowYear').text()) >= parseInt(NowDate.getFullYear())){
			if(parseInt($('#NowMonth').text()) > (parseInt(NowDate.getMonth())+1) || parseInt($('#NowYear').text()) > parseInt(NowDate.getFullYear())){
				$('.NomalDay').each(function(){
					$(this).addClass('Possib');
				})
				
			}else if(parseInt($('#NowMonth').text()) == parseInt(NowDate.getMonth())+1 && parseInt($('#NowYear').text()) == parseInt(NowDate.getFullYear()) ){
				var Break = 0;
				$('.NomalDay').each(function(){
					//$(this).css('background-color','gray');
					//alert($(this).children('.Date').text());
					if(parseInt($(this).children('.Date').text()) < parseInt(NowDate.getDate()) || $(this).index() < 7){
						if(Break !=2){
							$(this).css('background-color','rgb(200,200,200)');
							$(this).addClass('LastDate');
								
						}
						
						if(parseInt($(this).children('.Date').text()) == 1 && Break == 1){
							$(this).addClass('Possib');
							
							Break = 2;
						}else if(parseInt($(this).children('.Date').text()) == 1 && Break == 0){
							Break == 1;
						}else if(Break == 2){
							$(this).addClass('Possib');
						}
					}else{
						$(this).addClass('Possib');
						Break = 2;
					}
					
				})
			}else{
				$('.NomalDay').each(function(){
					$(this).css('background-color','rgb(200,200,200)');
					$(this).addClass('LastDate');
				})
			}
		}
	if(RDL != 0){
		for(var m = 0 ; m < RDL ; m++ ){
			//var ReservData=new Array(RDL);
			TempReservDate = ReservData[m][0].split("-");
			//alert(parseInt(TempReservDate[1]) +":"+ parseInt($('#NowMonth').text()))
			if(parseInt(TempReservDate[1]) < parseInt($('#NowMonth').text()) || TempReservDate[0] <  parseInt($('#NowYear').text())){
				$('.Data0'+TempReservDate[2]).siblings('span').each(function(){
					
					if($(this).text() == ReservData[m][2]){
						if(ReservData[m][3] == 0){
							$(this).addClass('gray');	
						}else{
							$(this).addClass('green');
						}
						
					}
				})
			}else if(parseInt(TempReservDate[1]) > parseInt($('#NowMonth').text())  || TempReservDate[0] >  parseInt($('#NowYear').text())){
				
				$('.Data20'+parseInt(TempReservDate[2])).siblings('span').each(function(){
					if($(this).text() == ReservData[m][2]){
						if(ReservData[m][3] == 0){
							$(this).addClass('gray');	
						}else{
							$(this).addClass('green');
						}
					}
				})
			}else {
				$('.Data1'+parseInt(TempReservDate[2])).siblings('span').each(function(){
					if($(this).text() == ReservData[m][2]){
						if(ReservData[m][3] == 0){
							$(this).addClass('gray');	
						}else{
							$(this).addClass('green');
						}
					}
				})
			}	
	
	}
	
		
	}
		
	$('.LastDate').on('click',function(){
		alert("예약이 불가능한 날입니다");
	})
	$('.Possib').on('click',function(){
		var NowScrolltop = $(window).scrollTop();
		$('#PopUpBackGround').css('margin-top',100+NowScrolltop + "px");
		$('.hide').removeClass();
		ReservPop(this , RoomsName, $(this).children('.Date').text());
		
	})
	
	}
});

function ReservPop(Data , R , Date){
	$('#PopUpArea').height($(document).height());
	$('#SelectRoom').val("");
	var MonthCheck =$(Data).children('.Date').attr('class').replace('Date Data','');
	var SendMonth=$('#NowMonth').text();
	var SendYear = $('#NowYear').text();
	if(parseInt(MonthCheck)> 200){
		if(parseInt(SendMonth) == 12){
			SendMonth = "1";
			SendYear = parseInt(SendYear)+1;
		}else{
			SendMonth = parseInt(SendMonth)+1;		
		}
	}else if(parseInt(MonthCheck)> 19 && parseInt(MonthCheck) < 110){
		if(parseInt(SendMonth) == 1){
			SendMonth = "12";
			SendYear = parseInt(SendYear)-1;
		}else{
			SendMonth = parseInt(SendMonth)-1;
		}
	}
	var ReservRoom = new Array();
	var tempCheckR = '';
	var tempCheckRNum = 0;
	$(Data).children('.RoomsName').each(function(){
		
		tempCheckR =$(this).attr('class').replace(' ','').replace(' ','').replace("RoomsName","").replace(/[0-9]/ig,''); 
		if( tempCheckR != ''){
			ReservRoom[tempCheckRNum] = $(this).index()-1 + ',' + tempCheckR;
			tempCheckRNum++;
		}
		//alert($(this).attr('class').replace(' ','').replace(' ','').replace("RoomsName",""));	
	});
	
	
	
	
	$('.year').text(SendYear);
	$('.month').text(SendMonth);
	$('.date').text(Date);
	if(parseInt(SendMonth) < 10){
		SendMonth = '0'+ SendMonth;
	}
	if(parseInt(Date) < 10){
		Date = "0"+Date;
	}
	$('#SDate').attr('value',SendYear + '-' + SendMonth + '-' + Date);
	//$('#PopUpContent').text(R);
	var TempFormHtml='';
	for(var i = 0 ; i < R.length ; i++){
		TempFormHtml = "<div class='RData RData" + i +"'><input type='Button' class='TheRoom' id='Data" + i + "' value='" + R[i] + "'/><input type='button' class='Select' id='R"+i+ "' value='예약하기'/></div>";
		$('.LeftForm').append(TempFormHtml);
		
	}
	$('.Select').on('click',function(){
		$('#SelectRoom').val($(this).siblings('.TheRoom').val());
		RoomMData($('#Member').val(), $(this).siblings('.TheRoom').val());
	})
	var tempInput;
	for(var i = 0 ; i < ReservRoom.length ; i++){
			tempInput = ReservRoom[i].split(',');
		if(tempInput[1] == 'gray'){
			$('.RData'+tempInput[0]).children('#R'+tempInput[0]).attr('disabled',true).val('예약불가');
		}else if(tempInput[1] == 'green'){
			//alert($('#R'+i).val());
			/*$('#R'+i).attr('disabled',true);
			$('#R'+i).val('예약불가');*/
			//alert("Best");
			$('.RData'+tempInput[0]).children('#R'+tempInput[0]).attr('disabled',true).val('예약불가');
		}	
	}
	
}

function RoomMData( M , R){
	 
	
	$.ajax({
		 type: "Post",
	        url: 'ReservRoomMData',
	        dataType: 'json',
	        data: {
	        	'Member' : M,
	 			'Room' : R
	        },
	        success: function(json)
	        {
	        	var RootinNum = json.request[0].MOP-json.request[0].NOP;
				var AmountPeopleTemp ="";
				for( var i = 0 ; i <= RootinNum ; i++){
					if(i == 0){
						AmountPeopleTemp += "<input type='radio' value='" + (json.request[0].NOP + i) + "' checked='checked' name='AmountPeople'>"+ (json.request[0].NOP + i) +"명";
						$('#NumOfPeople').val(json.request[0].NOP);
						$('#SendAPeople').val(json.request[0].Nop);
					}else{
						AmountPeopleTemp += "<input type='radio' value='" + (json.request[0].NOP + i) + "' name='AmountPeople'>"+ (json.request[0].NOP + i) +"명";
					}
						
				}
				$('#AmountPeopleArea').html(AmountPeopleTemp);
				$('input[name=AmountPeople]').on('change',function(){
					$('#SendAPeople').val($('input[name=AmountPeople]:checked').val());
				})
				
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
	<div id='Calendar'>
      	<div id='MoveArea' class='clearfix'>
      		<span id="MoveToday">오늘</span>
      		<span id="LastMonth">◀</span>
       	<span id = "Today"><span id='NowYear'></span> 年 <span id='NowMonth'></span> 月</span>
       	<span id="NextMonth">▶</span>
      	</div>
       <table id="CalendarTable" cellspacing='0' cellpadding='0'>
       	<thead>
        	<tr>
        		<td class='DayLine'>일</td>
        		<td class='DayLine'>월</td>
        		<td class='DayLine'>화</td>
        		<td class='DayLine'>수</td>
        		<td class='DayLine'>목</td>
        		<td class='DayLine'>금</td>
        		<td class='DayLine'>토</td>
        	</tr>
        </thead>
        <tbody id="CalendarData">
        </tbody>	
       </table>
      </div>
      <div id='MoveReservArea'>
      <div id='MoveReservTitle' class='clearfix'><span id='RTitle'>예약확인</span><span id='CloseReserv'>X</span></div>
      	<div><a href='ReservCancel' id='ReservCancel'>이동하기</a></div>
      </div>
</content>
<div id = 'PopUpArea' class='hide'>
	<div id = 'PopUpBackGround'>
		<span id="ReservTitle">예약하기</span>
		<span id='PopUpClose'>X</span>
		<div id = 'PopUpContent'>
			<form method="post" id="ReservData" >
				<div class='LeftForm'>
				</div>
				<div class='RightForm'>
					<input type='text' id='Member' name = 'Member' style='display:none;'/>
					<div id='SelectDate'><span class='year'></span>년<span class='month'></span>월<span class='date'></span>일<input type='text' name = 'SDate' id='SDate' style='display:none'/></div>
					<Input type='text' name='SelectRoom' id='SelectRoom' placeholder='예약하실방을 선택해주세요' readonly>
					<label id='AmountPeopleArea'>
					</label>
					<div id='BBQ&Grill'>
						<label id='GRILL'><input type='checkbox' id='Grill' name='Grill'>그릴을 신청합니다.</label>
						<label id='BBQ'><input type='checkbox' id='Barbecue' name ='Barbecue' disabled='true'>바베큐를 신청합니다.</label>						
					</div>
					<Input type='text' id='SendAPeople' name ='SendAPeople' style='display:none'/>
					<Input type='text' id = 'NumOfPeople' name = 'NumOfPeople' style='display:none'/>
					<input type='button' id='RSubmit' value='예약하기'/>
					<input type='button' id='RCancel' value='취소하기'/>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>