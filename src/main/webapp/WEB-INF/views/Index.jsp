<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Welcome</title>
<script src='resources/js/jquery-3.1.1.min.js'></script>
	<!-- �������� �ּ�ȭ�� �ֽ� CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

	<!-- �ΰ����� �׸� -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<!-- �������� �ּ�ȭ�� �ֽ� �ڹٽ�ũ��Ʈ -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
	<script src='resources/js/app.js'></script>
	<script src='resources/js/event.js'></script>
	
	<script>
		$(document).ready(function(){
			about = "<div class='col-md-12 col-xs-12'><div class='resumepic col-md-4 col-xs-8 col-md-offset-0 col-xs-offset-1'><img src='resources/img/resumepic.jpg' alt='�������' class='col-xs-12 col-md-12' style='z-index: 5'></div>		<div class='col-md-8 col-xs-12'><div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>��   �� : </p><p class='col-xs-6 col-md-8'>�ż��� </p></div><div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>������� : </p><p class='col-xs-6 col-md-8'>1987�� 4�� 5��</p></div>			<div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>��ȭ��ȣ : </p><p class='col-xs-6 col-md-8'>010-5109-3286</p></div><div class='col-xs-12 row'><p class='col-xs-6 col-md-4'>īī���� : </p><p class='col-xs-6 col-md-8'>rexbegonia87</p></div></div>		<div class='col-xs-8 col-sm-6'></div></div>";
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
			Java , Jsp , Spring 4.0 , Tomcat 9.0 , MariaDB ���� ����Ͽ�<br>
			��� ���� ,  �Խ��� �� ��� �� �б� , ���ô� �濡 ���� ���� ����<br>
			���ԵǾ� �ִ� Ȩ��������<br>
			���� ��Ȳ ,  ���� ���� Ȯ��, �Ⱓ�� ���� �� ������ �� Ȯ�� ���� ������<br>
			������ �������� �����Ͽ����ϴ�.<br>
			
		</div>
		<div class='col-md-4 col-xs-12'>
			<div class='col-md-12 col-xs-12'>
				<a href='Page/Introduce' class=''>��� Ȩ�������� �̵�</a>
				<a href='Admin' class=''>��� �������������� �̵�</a>
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
	            <input id="eng" ng-model = 'eng' type="text" placeholder="����">
	            <label for="kor">kor:</label>
	            <input id="kor" ng-model='kor' type="text" placeholder="�ѱ�">
	            <button type="submit" ng-click='addDic(eng,kor)'>�߰�</button>
	        </div>
	    </form>
	
	</div>
	
	-->	
	</section>
</div>

</body>
</html>