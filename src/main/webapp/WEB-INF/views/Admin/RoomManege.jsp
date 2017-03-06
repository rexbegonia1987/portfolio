<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="../resources/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/Loader.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/aReservList.css" />
<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		var MemberName = '<%= request.getParameter("MemberName") %>';
		var MemberId = '<%= request.getParameter("MemberId") %>';
		$("#Member").append(MemberName);
		$("#MemberName").val(MemberName);
		$('#MemberId').val(MemberId);
		$('#MenuList li').on('click',function(){
			var MovePage=$(this).text();
			if($(this).text() == 'Home'){
				MovePage = 'Implication';
			}
			var URL = window.location.href.replace('RoomManege',MovePage);
			$('form').attr('action',URL).submit();
		});
		AJAXRoomName($('#MemberId').val());
	
		 
         $('.SelectType').on('click',function(){
            $('.SelectType').each(function(){
               $(this).removeClass('Select');
            })
             $('.RoomList').each(function(){
               $(this).removeClass('Select');
            })
            $(this).addClass('Select');
            if($(this).attr('id') =='Modify'){
            	$('#RoomList').css('display','block');
            }else{
            	$('#RoomList').css('display','none');
            }
            $('input[type="text"]').each(function(){
            	$(this).val('');
            })
            $('select').each(function(){
            	$(this).val('0');
            })
            $("#MemberName").val(MemberName);
    		$('#MemberId').val(MemberId);
         });

		$('.Bill').on('keypress',function(e){
			 var key;

			    if(window.event){
			         key = window.event.keyCode; //IE
			    }else{
			         key = e.which; //firefox
			    }
			    // backspace or delete or tab
			    var event; 
			    if (key == 0 || key == 8 || key == 46 || key == 9){
			        event = e || window.event;
			        if (typeof event.stopPropagation != "undefined") {
			            event.stopPropagation();
			        } else {
			            event.cancelBubble = true;
			        }   
			        return ;
			    }

			    if (key < 48 || (key > 57 && key < 103) || key > 105 || e.shiftKey) {
			        e.preventDefault ? e.preventDefault() : e.returnValue = false;
			    }

			})
			$('input[type="button"]').on('click',function(){
			   var data=new Array();
			   var i=0;
			   var CheckNull = true;
			   $('.Bill').each(function(){
			      if($(this).val() != ''){
			         data[i] = $(this).attr('id') +'&'+$(this).val();
			         i++;   
			      }else{
			         CheckNull = false;
			      }
			   });
			   var Type =$('.SelectType.Select').attr('id');
			   if(CheckNull){
				   AJAXINPUT($('#MemberId').val(),$('#RoomName').val(),data,Type);
			   }else{
			      alert('입력하지 않은 값이 있습니다.');
			   }
			})

	})
function AJAXRoomName(ID){
		var MemberId = ID;
		
		$.ajax({
	        type: "Post",
	        url: 'RoomName',
	        dataType: 'json',
	        data: {
	        	'ID' :  MemberId
	        },
	        success: function(json)
	        {	
	        	var ListHTML ='';
	        	$('#RoomList').html('');
	        	for(var i = 0 ; i < json.request.length; i++){
	        		ListHTML+= '<span class="RoomList Room0'+i+'" id="Room'+i+'">'+json.request[i].RoomName +
	        		'</span>';
	        		
	        	}
	        	$('#RoomList').html(ListHTML)
	        	 $('.RoomList').on('click',function(){
          
            
           
         })
	        	$('.RoomList').on('click',function(){
	        		  $('.RoomList').each(function(){
	                      $(this).removeClass('Select');
	                   })
	                   $(this).addClass('Select');
	        		AJAXRoomMod(MemberId,$(this).text());
	        	})
	        },
	        error:function(json , ErrorCode , Error){
	        	
	    	    alert(Error);//'잘못된 접근입니다.\n');
	    	    var URL = window.location.href;
	        	URL = URL.replace('implication','Index');
	        }
	    });
	}
function AJAXRoomMod(ID,RN){
	var MemberId = ID;
	var RoomName = RN;
	$.ajax({
        type: "Post",
        url: 'RoomModify',
        dataType: 'json',
        data: {
        	'ID' :  MemberId,
        	'RoomName' : RoomName
        },
        success: function(json)
        {	
        	var Result = json.request;
        	var Length = Result.length;
        	var Temp;
        	for(var i = 0 ; i < Length ; i++){
        		Temp = Result[i].split('&');
				$('#'+Temp[0]).val(Temp[1]);	
        		
        	}
        },
        error:function(json , ErrorCode , Error){
        	
    	    alert(Error);//'잘못된 접근입니다.\n');
    	    var URL = window.location.href;
        	URL = URL.replace('RoomManege','Index');
        	window.location.href(URL);
        }
    });
}
function AJAXINPUT(ID,RN,Data,Type){
	var MemberId = ID;
	var RoomName = RN;
	var DATA = Data;
	var Type = Type;
	var Length = Data.length;
	$.ajaxSettings.traditional = true;
	$.ajax({
        type: "Post",
        url: 'RoomInsert',
        dataType: 'json',
        data: {
        	'ID' :  MemberId,
        	'RoomName' : RoomName,
        	'Data' : DATA,
        	'Type' : Type,
        	'Length' : Length
        },
        success: function(json)
        {	
        	if(json.request.Result =='Success'){
        		var URL = window.location.href;
        		if(Type == 'ADD'){
        			alert('성공적으로 입력하셨습니다.');
        		}else{
        			alert('성곡적으로 변경하였습니다.');
        		}
    			$('#SendMember').attr('action',URL).submit();
        	}
        },
        error:function(json , ErrorCode , Error){
        	
    	    alert(Error);//'잘못된 접근입니다.\n');
    	    var URL = window.location.href;
        	URL = URL.replace('implication','Index');
        }
    });
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
 <content style='text-align:center;'>
      <div id="SelectType">
         <span id="ADD" class='SelectType Select'>추가</span>
         <span id="Modify" class='SelectType'>수정</span>
      </div>
      <div id="RoomList" style='display:none;'>
      </div>
      <table id="DataArea" border='1' style='width:900px;margin:0 auto; border-collapse: collapse;text-align:center;'>
         <tbody>
            <tr>
               <th>방 이름 : </th>
               <td><input type="text" id="RoomName"></td>
               <th>최소인원 : </th>
               <td>
                  <select name="NumOfPerson" id="NumOfPerson" class='OfPerson Bill'>
                     <option value="0">선택해주세요</option>
                     <option value="2">2</option>
                     <option value="3">3</option>
                     <option value="4">4</option>
                     <option value="5">5</option>
                     <option value="6">6</option>
                     <option value="7">7</option>
                     <option value="8">8</option>
                     <option value="9">9</option>
                     <option value="10">10</option>
                  </select>
               </td>
               <th>최대인원 : </th>
               <td>
                  <select name="MaxOfPerson" id="MaxOfPerson" class='OfPerson Bill'>
                     <option value="0">선택해주세요</option>
                     <option value="2">2</option>
                     <option value="3">3</option>
                     <option value="4">4</option>
                     <option value="5">5</option>
                     <option value="6">6</option>
                     <option value="7">7</option>
                     <option value="8">8</option>
                     <option value="9">9</option>
                     <option value="10">10</option>
                  </select>
               </td>
            </tr>
            <tr>
               <th></th>
               <th>평일</th>
               <th>금요일</th>
               <th>토요일</th>
               <th>일요일</th>
               <th></th>
            </tr>
            <tr>
               <th>비수기</th>
               <td><input type="text" class='Bill' id="NDailyBill"></td>
               <td><input type="text" class='Bill' id="NFridayBill"></td>
               <td><input type="text" class='Bill' id="NSaturdayBill"></td>
               <td><input type="text" class='Bill' id="NSundayBill"></td>
               <td>비수기금액</td>
            </tr>
            <tr>
               <th>준성수기</th>
               <td><input type="text" class='Bill' id="SDailyBill"></td>
               <td><input type="text" class='Bill' id="SFridayBill"></td>
               <td><input type="text" class='Bill' id="SSaturdayBill"></td>
               <td><input type="text" class='Bill' id="SSundayBill"></td>
               <td>준성수기금액</td>
            </tr>
            <tr>
               <th>성수기</th>
               <td><input type="text" class='Bill' id="PDailyBill"></td>
               <td><input type="text" class='Bill' id="PFridayBill"></td>
               <td><input type="text" class='Bill' id="PSaturdayBill"></td>
               <td><input type="text" class='Bill' id="PSundayBill"></td>
               <td>성수기금액</td>
            </tr>
            <tr>
               <th>비고 : </th>
               <td colspan="5"><textarea name="ACT" id="ACT" style='width:90%;' rows="10"></textarea></td>
            </tr>
         </tbody>
      </table>
      <p id="BtnArea"><input type="button" id="SubButton" value='확인'></p>
   </content>
</body>
</html>