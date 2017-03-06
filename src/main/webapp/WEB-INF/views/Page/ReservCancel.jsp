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
        		   OutPutData+="<span class='Title'>��������</span>";
                   OutPutData+="<table id='ReservData' border='1' style='border-collapse: collapse;'>";
                   OutPutData+="<tbody><tr><th>�����ڸ� : </th><td>"+json.request.Reservater+"</td><th>�����ȣ : </th><td>"+json.request.ReservNumber+"</td></tr>";
                   OutPutData+="<tr><th>������ : </th><td>"+json.request.SelectDate+"</td><th>��ȭ��ȣ : </th><td>"+json.request.ReservPhone+"</td></tr>";
                   OutPutData+="<tr><th>����� : </th><td>"+json.request.ReservRoom+"</td><th>�����ο� : </th><td>"+json.request.AmountPeople+"</td></tr>";
                   if(json.request.Grill){
                	   OutPutData+="<tr><th>�׸���û : </th><td>��û</td>";   
                   }else{
                	   OutPutData+="<tr><th>�׸���û : </th><td>�̽�û</td>";
                   }
                   if(json.request.Barbecue){
                	   OutPutData+="<th>�ٺ�ť��û : </th><td>��û</td></tr>";   
                   }else{
                	   OutPutData+="<th>�ٺ�ť��û : </th><td>�̽�û</td></tr>";
                   }
                   OutPutData+="<tr><th>�ݾ� : </th><td>"+toCurrencyString(json.request.Pay)+"��</td><th>������� : </th><td>"+json.request.DepositWay+"</td></tr>";
                   if(!json.request.DepositCheck && !json.request.DepositSet){
                	   OutPutData+="<tr><th>������Ȳ : </th><td>�Աݴ��</td>";   
                   }else if(!json.DepositSet){
                	   OutPutData+="<tr><th>������Ȳ : </th><td>Ȯ�����</td>";
                   }else{
                	   OutPutData+="<tr><th>������Ȳ : </th><td>����Ȯ��</td>";
                   }
                   OutPutData+="<th>��ҽ�û : </th><td><input type='button' id='CancelSub' name='CancelSub' value='����ϱ�'/></td></tr>";
                   OutPutData+="<tr><th>����� �� : </th><td colspan='3'>"+json.request.Text+"</td></tr>";
                   OutPutData+="</tbody></table>";
                   OutPutData+="<input type='button' id='Close' name='Close' value='�ݱ�'/>";
                   $('#VisitArea').html('');
                   $('#VisitArea').append(OutPutData);
                   $('#CancelSub').bind('click',function(){
                      var CancelConfirm = confirm("����Ͻðڽ��ϱ�?");
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
                            	 	alert('��Ұ� �Ϸ�Ǿ����ϴ�.');
                            	 }
                             },
                             error:function(json){
                                alert('����.\n');
                                
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
        		   alert('���������� �����ϴ�.');
        		   InPutLoader();
        	   }
               	
           },
           error:function(json){
              alert('����.\n');
           }
       });

}
function InPutLoader(){
	var InputHTHML = "<span class='Title'>Reservation</span><br><input type='text' name='ReservNum' id='ReservNum' placeholder='�����ȣ�� �����ּ���'/><br> <input type='password' name='ReservPw' id='ReservPw' placeholder='��й�ȣ�� �Է����ּ���'/><br><input type='button' id='LoginButton' value='�α���' ><input type='button' id='GoBack' value='���' >";
	$('#VisitArea').html(InputHTHML);
	$('#LoginButton').on('click',function(){
        var ReservNum = $('#ReservNum').val();
        var ReservPw = $('#ReservPw').val();
        if(ReservNum == '' ){
           alert('�����ȣ�� �Է����ּ���');
        }else{
           if(ReservPw == '' || ReservPw.length < 4){
              alert('��й�ȣ�� �ٽ� �Է����ּ���');   
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
  

    var sSecond = "";      //������ ���ڿ� 
    

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
					���ô� ��
				</li>
				<li id='gbnreservation' class='GBN'>
					����
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