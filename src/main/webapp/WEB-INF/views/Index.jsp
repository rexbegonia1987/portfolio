<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Welcome</title>
<script src='resources/js/jquery-3.1.1.min.js'></script>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
	<script src='resources/js/app.js'></script>
	<script src='resources/js/event.js'></script>
	
	<script>
		$(document).ready(function(){
			about = "<div class='col-md-12 col-xs-12'><div class='resumepic col-md-4 col-xs-8 col-md-offset-0 col-xs-offset-1'><img src='resources/img/resumepic.jpg' alt='증명사진' class='col-xs-12 col-md-12' style='z-index: 5'></div>		<div class='col-md-8 col-xs-12'><div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>이   름 : </p><p class='col-xs-6 col-md-8'>신세용 </p></div><div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>생년월일 : </p><p class='col-xs-6 col-md-8'>1987년 4월 5일</p></div>			<div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>전화번호 : </p><p class='col-xs-6 col-md-8'>010-5109-3286</p></div><div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>카카오톡 : </p><p class='col-xs-6 col-md-8'>rexbegonia87</p></div></div>		<div class='col-xs-8 col-sm-6'></div></div>";
			// $('section').html(about);
			$('.menu').on('click',function(){
				var sTop = $(window).scrollTop();
				var scrolling = setInterval(
					function(){
						
						sTop = sTop-10;
						$(window).scrollTop(sTop);
					if(sTop <= 0){
						clearInterval(scrolling);
					}

				},1);

				var page =$(this).attr('id');
				var htmlOutput = '';
				if(page == 'about'){
						htmlOutput =about;
				}

				$('section').fadeOut('slow',function(){$('section').html('');
										$('section').html(htmlOutput);
										$('section').fadeIn();
									});

			});
		})
	</script>
	<style>
	header{
		background-color: white;
		z-index:100;
	}
	#gnb{
		
		list-style: none;
		text-align: center;
		
	}
	#gnb li{
		cursor:pointer;
	}
	section{
		margin-top:40px;
		z-index:10;
		position: relative;
	}
	.resumepic{
		position: relative;
		z-index:11;

	}
	
	#welcome{
		text-align: center;
		background-color: blue;
	}

</style>
</head>

<body >
<header>
	<div id='header' class="row container-fluid">
		<a href="#" id='welcome' class='col-xs-3'>Welcome</a>
	<ul id='gnb' class='container-fluid row col-xs-6 col-xs-offset-3'>
		<li id='about' class='menu col-xs-3'>
			About
		</li>
		<li id='portfolio' class='menu col-xs-3'>
			PortFolio
		</li>
		<li id='' class='menu col-xs-3'>
			PortFolio
		</li>
		<li id='' class='menu col-xs-3'>
			PortFolio
		</li>
	</ul>
	</div>
</header>
<div class='col-md-12 col-xs-12 row'>
	<aside class='col-md-2'  style='background-color:blue;>
		<ol class='col-md-12 container-fluid''>
			<li>Penshion</li>
		</ol>
	</aside>
	<section class='row col-md-9 col-md-offset-2 col-xs-12'  style='background-color:yellow;'>
		<div class='col-md-8 col-xs-12'>
			<img class='col-md-12 col-xs-12' src= 'resources/img/Introduce.PNG' title='penshionIntro'/>
		</div>
		<div class='col-md-4 col-xs-12'>
			<h1>Penshion</h1>
			Java , Jsp , Spring 4.0 , Tomcat 9.0 , MariaDB 등을 사용하여<br>
			펜션 예약 ,  게시판 글 등록 및 읽기 , 오시는 길에 대한 설명 등이<br>
			포함되어 있는 홈페이지와<br>
			예약 현황 ,  예약 내역 확인, 기간별 수입 및 예약자 수 확인 등이 가능한<br>
			관리자 페이지를 개발하였습니다.<br>
			
		</div>
		<div class='col-md-4 col-xs-12'>
			<div class='col-md-12 col-xs-12'>
				<a href='Page/Introduce' class=''>펜션 홈페이지로 이동</a>
				<a href='Admin' class=''>펜션 관리자페이지로 이동</a>
			</div>
		</div>
		
		
		
	
	
	<!-- <div>
		<h1>{{appName}}</h1>
	    <ol>
	        <li ng-repeat="dic in dicList">{{dic.eng}} : {{dic.kor}}</li>
	    </ol>
	   
	    <form>
	        <div>
	            <label for="eng">eng:</label>
	            <input id="eng" ng-model = 'eng' type="text" placeholder="영어">
	            <label for="kor">kor:</label>
	            <input id="kor" ng-model='kor' type="text" placeholder="한글">
	            <button type="submit" ng-click='addDic(eng,kor)'>추가</button>
	        </div>
	    </form>
	
	</div>
	
	-->	
	</section>
</div>

</body>
</html>