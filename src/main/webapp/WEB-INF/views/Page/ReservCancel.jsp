<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Penshion</title>
<link rel="stylesheet" href="../resources/portfolio/css/style.css">
<link rel="stylesheet" href="../resources/portfolio/css/Index.css">
<link rel="stylesheet" href="../resources/portfolio/css/Loader.css">
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/ReservCancel");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
			document.location.href = MoveURL;	
		}
	})
	InPutLoader();
})
      
	
function OutPutText(Num , Pw){
       var OutPutData = '';
       var Title =$('title').text();
       $.ajax({
           type: "Post",
           url: "ReservCancelData",
           dataType: 'json',
           data: {
              "ReservNum": Num,
              "Pw": Pw,
              "MemberAddress" : Title.toLowerCase()
           },
           success: function(json)
           {
        	   if(json.request.Result){
        		   OutPutData+="<span class='Title'>예약정보</span>";
                   OutPutData+="<table id='ReservData' border='1' style='border-collapse: collapse;'>";
                   OutPutData+="<tbody><tr><th>예약자명 : </th><td>"+json.request.Reservater+"</td><th>예약번호 : </th><td>"+json.request.ReservNumber+"</td></tr>";
                   OutPutData+="<tr><th>예약일 : </th><td>"+json.request.SelectDate+"</td><th>전화번호 : </th><td>"+json.request.ReservPhone+"</td></tr>";
                   OutPutData+="<tr><th>예약방 : </th><td>"+json.request.ReservRoom+"</td><th>예약인원 : </th><td>"+json.request.AmountPeople+"</td></tr>";
                   if(json.request.Grill){
                	   OutPutData+="<tr><th>그릴신청 : </th><td>신청</td>";   
                   }else{
                	   OutPutData+="<tr><th>그릴신청 : </th><td>미신청</td>";
                   }
                   if(json.request.Barbecue){
                	   OutPutData+="<th>바베큐신청 : </th><td>신청</td></tr>";   
                   }else{
                	   OutPutData+="<th>바베큐신청 : </th><td>미신청</td></tr>";
                   }
                   OutPutData+="<tr><th>금액 : </th><td>"+toCurrencyString(json.request.Pay)+"원</td><th>결제방법 : </th><td>"+json.request.DepositWay+"</td></tr>";
                   if(!json.request.DepositCheck && !json.request.DepositSet){
                	   OutPutData+="<tr><th>예약현황 : </th><td>입금대기</td>";   
                   }else if(!json.DepositSet){
                	   OutPutData+="<tr><th>예약현황 : </th><td>확정대기</td>";
                   }else{
                	   OutPutData+="<tr><th>예약현황 : </th><td>예약확정</td>";
                   }
                   OutPutData+="<th>취소신청 : </th><td><input type='button' id='CancelSub' name='CancelSub' value='취소하기'/></td></tr>";
                   OutPutData+="<tr><th>남기신 말 : </th><td colspan='3'>"+json.request.Text+"</td></tr>";
                   OutPutData+="</tbody></table>";
                   OutPutData+="<input type='button' id='Close' name='Close' value='닫기'/>";
                   $('#VisitArea').html('');
                   $('#VisitArea').append(OutPutData);
                   $('#CancelSub').bind('click',function(){
                      var CancelConfirm = confirm("취소하시겠습니까?");
                      if(CancelConfirm){
                    	 $('#VisitArea').html('<div id="Loader"></div>');
                    	 $.ajax({
                    		 type: "Post",
                             url: "Cancel",
                             dataType: 'json',
                             data: {
                                "ReservNum": Num,
                                "Pw": Pw,
                                "MemberAddress" : Title.toLowerCase()
                             },
                             success:function(json){
                            	 if(json.request.Result){
                            	 	alert('취소가 완료되었습니다.');
                            	 }
                             },
                             error:function(json){
                                alert('에러.\n');
                                
                             }
                         });
                      }
                      InPutLoader(); 
            	   })
            	   $('#Close').on('click',function(){
            			InPutLoader();
            		})   
        	   }else{
        		   $('#VisitArea').html('<div id="Loader"></div>');
        		   alert('예약정보가 없습니다.');
        		   InPutLoader();
        	   }
               	
           },
           error:function(json){
              alert('에러.\n');
           }
       });

}
function InPutLoader(){
	var InputHTHML = "<span class='Title'>Reservation</span><br><input type='text' name='ReservNum' id='ReservNum' placeholder='예약번호를 적어주세요'/><br> <input type='password' name='ReservPw' id='ReservPw' placeholder='비밀번호를 입력해주세요'/><br><input type='button' id='LoginButton' value='로그인' ><input type='button' id='GoBack' value='취소' >";
	$('#VisitArea').html(InputHTHML);
	$('#LoginButton').on('click',function(){
        var ReservNum = $('#ReservNum').val();
        var ReservPw = $('#ReservPw').val();
        if(ReservNum == '' ){
           alert('예약번호를 입력해주세요');
        }else{
           if(ReservPw == '' || ReservPw.length < 4){
              alert('비밀번호를 다시 입력해주세요');   
           }else{
              $('#VisitArea').html('');
              $('#VisitArea').html('<div id="Loader"></div>');
              OutPutText(ReservNum,ReservPw);

           }
        }
     });
	$('#GoBack').on('click',function(){
		$('#Reservation').click();
	})
	$('#ReservNum').on('keydown',function(key){
		if (key.keyCode == 13) {
            $("#ReservPw").focus();
        }
	});
	$('#ReservPw').on('keydown',function(key){
		if (key.keyCode == 13) {
            $("#LoginButton").click();
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
   <div id="LoginVisit">
      <div id="VisitArea">
     </div>
  </div>
</content>
	
	
</body>
</html>