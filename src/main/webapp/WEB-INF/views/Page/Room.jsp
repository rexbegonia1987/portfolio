<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/portfolio/css/Index.css">
<link rel="stylesheet" href="../resources/portfolio/css/Room.css">
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var Member = $('title').text();
	var RowCount=0;
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/Room");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
				document.location.href = MoveURL;	
		}
	});
	$('#SmallImage ul li').on('click',function(){
		var Index = $(this).index();
		$('.Select').fadeOut().removeClass('Select').addClass('hidden');
		$('.i'+Index).fadeIn().removeClass('hidden').addClass('Select');
	//	$('.Fimg').index(Index).removeClass('hidden');
	})
	$('.RoomNames li').on('click',function(){
		var RoomName = $(this).text().replace('호','');
		
		$('.Fimg').each(function(){
			var src = $(this).children('img').attr('src').split('/');
			var target = src.length-2;
			src[target] = RoomName;
			var csrc = src[0];
			for(var i = 1 ; i < src.length; i++){
				csrc+= "/"+src[i];
			}
			var src = $(this).children('img').attr('src',csrc);
			$(this).removeClass('Select');
			$(this).removeClass('hidden');
			$(this).addClass('hidden').fadeOut();
		})
		$('.Simg').each(function(){
			var src = $(this).children('img').attr('src').split('/');
			var target = src.length-2;
			src[target] = RoomName;
			var csrc = src[0];
			for(var i = 1 ; i < src.length; i++){
				csrc+= "/"+src[i];
			}
			var src = $(this).children('img').attr('src',csrc);
		})
		$('.i0').removeClass('hidden').addClass('Select').fadeIn();
	})
	
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

<content class='clearfix'>
	<aside>
		<ul class='RoomNames clearfix'>
			<li>201호</li>
			<li>202호</li>
			<li>203호</li>
			<li>204호</li>
			<li>301호</li>
			<li>302호</li>	
		</ul>
	</aside>
	<div id="contents">
		<div id="FullImage">
			<ul>
				<li class='Fimg hidden i0'><img src="../resources/portfolio/images/Room/201/1.jpg"></li>
				<li class='Fimg hidden i1'><img src="../resources/portfolio/images/Room/201/2.jpg"></li>
				<li class='Fimg hidden i2'><img src="../resources/portfolio/images/Room/201/3.jpg"></li>
				<li class='Fimg hidden i3'><img src="../resources/portfolio/images/Room/201/4.jpg"></li>
				<li class='Fimg hidden i4'><img src="../resources/portfolio/images/Room/201/5.jpg"></li>
				<li class='Fimg Select i5'><img src="../resources/portfolio/images/Room/201/6.jpg"></li>
				<li class='Fimg hidden i6'><img src="../resources/portfolio/images/Room/201/7.jpg"></li>
				<li class='Fimg hidden i7'><img src="../resources/portfolio/images/Room/201/8.jpg"></li>
				<li class='Fimg hidden i8'><img src="../resources/portfolio/images/Room/201/9.jpg"></li>
			</ul>
		</div>
		<div id="SmallImage">
			<ul class='clearfix'>
				<li class='Simg'><img src="../resources/images/Room/201/1.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/2.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/3.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/4.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/5.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/6.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/7.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/8.jpg"></li>
				<li class='Simg'><img src="../resources/images/Room/201/9.jpg"></li>
			</ul>
		</div>
	</div>	
</content>
</body>
</html>