<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/portfolio/css/Index.css">
<link rel="stylesheet" href="../resources/portfolio/css/Introduce.css">
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var Member = $('title').text();
	var RowCount=0;
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/Introduce");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
				document.location.href = MoveURL;	
		}
	});
	
	
})
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

<content class='clearfix'>
	<h2>Welcome</h2>
	<h3>Maple Lend</h3>
	<div id='TextArea'>
		<p>�����÷���� ������ ���� ���������</p>
		<p>�Ҹ� ��ŭ �Ƹ��ٿ� �ڿ������ �ڶ��ϰ� �ֽ��ϴ�.</p>
		<p>12���� ������ ���Ǹ��� �ٸ��������� �ٸ� �������� �����ο� ��Ʈ���Ĵ� �����÷��� ���� �ڶ��Դϴ�.</p>
		<p>5000���̻��� ��å�ο� �ɰ� ������ ������ �ְ�, ������, ī��, Ŭ����������, �̴��౸, ���Ϻ�, Ź���� </p>
		<p>�پ��� ��� �Ÿ��� �����ϴ�.</p>		
	</div>
	<div style='text-align:center;border:1px solid #ccc;margin-top:40px;padding:20px;'>
		<div style="width:640px; magin:0 auto;display:inline-block;">
			<img src="../resources/portfolio/images/Introduce/1.jpg" width='435' style='float:left;'>
			<img src="../resources/portfolio/images/Introduce/2.jpg" width='205' style='float:left;'>
			<img src="../resources/portfolio/images/Introduce/3.jpg" width='205' style='float:left;'>
			<p style="width:205px;display:inline-block;float:left;margin:0px;padding:0px;" >
				<img src="../resources/portfolio/images/Introduce/4.jpg" width='205'>
				<img src="../resources/portfolio/images/Introduce/5.jpg" width='205'>
			</p>
			<img src="../resources/portfolio/images/Introduce/6.jpg" width='435' style='float:left;'>
			<img src="../resources/portfolio/images/Introduce/7.jpg" width='640' style='float:left;'>
		</div>
	</div>
	
</content>
</body>
</html>