<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="../resources/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/Loader.css" />
<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		$('#LoginSubmit').on('click',function(){
			//alert($('ID').val());
			$.ajax({
		        type: "Post",
		        url: 'Login',
		        dataType: 'json',
		        data: {
		        	'ID' : $('#ID').val(),
		 			'Pw' : $('#Pw').val()
		        },
		        success: function(json)
		        {
		        	var SuccessSend = "<input type='text' id='MemberName' name='MemberName' style='display:none;'/><input type='text' id='MemberId' name='MemberId' style='display:none;'/>";
		        	$('form').html('');
		        	$('form').append('<div id="Loader"></div>');
		        	$('form').append(SuccessSend);
		        	$('#MemberName').val(json.request.MemberName);
		        	$('#MemberId').val(json.request.ID);
		        	var URL = window.location.href;
		        	URL+= "Implication"
		        	alert("'"+$('#MemberName').val()+"'님 환영합니다.");
		        	$('form').attr('action',URL).submit();
		         	
		        },
		        error:function(json){
		    	    alert('로그인에 실패하였습니다.\n');
		        }
		    });	
		});
		$("#ID").keydown(function (key) {
	        if (key.keyCode == 13) {
	            $("#Pw").focus();
	        }
	    }); 
		$("#Pw").keydown(function (key) {
	        if (key.keyCode == 13) {
	            $("#LoginSubmit").click();
	        }
	    });  

	})
</script>
</head>
<body>
<content>
	<div id='DataForm'>
		<form method="post">
			<div>환영합니다</div>
			<div><input type = 'text' id='ID' name='ID' placeholder='아이디'/></div>
			<div><input type = 'password' id='Pw' name='Pw' placeholder='비밀번호'/></div>
			<div><input type='button' id='LoginSubmit' name='LoginSubmit' value='로그인' /><input type='button' id='NewInfo' name='NewInfo' value='회원가입'/></div>
		</form>
	</div>
</content>
</body>
</html>