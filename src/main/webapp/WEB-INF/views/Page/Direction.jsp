<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Penshion</title>
<link rel="stylesheet" href="../resources/portfolio/css/Index.css">
<script rel="stylesheet" type="text/javascript" src="../resources/portfolio/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=sb0FnMQW6qy8fQpskyzI&submodules=geocoder"></script>
<script type="text/javascript">
$(document).ready(function(){
	var RowCount=0;
	$('.MenuList').click(function(){
		if($(this).text() != "Home"){
			var SelectPage = $(this).text();
			var EXP=document.location.href.split("/Direction");
			var	MoveURL=EXP[0];
				MoveURL=MoveURL+"/";
				MoveURL+=SelectPage;
				document.location.href = MoveURL;	
		}
	});
})</script>
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
	<div id="map" style="width:800px;height:400px;border:1px solid #ccc; margin:40px auto;"></div>
	<div style='background-color:#efefef;'>
		<table width="800" border="0" cellspacing="0" cellpadding="0" style="display:inline-block;">
			  <tbody><tr>
			    <td height="90" align="left" valign="top" colspan="3"><img width="219" height="50" src="../resources/images/traffic_tit2.jpg"></td>
			  </tr>
			  <tr>
		    <td align="left" class="gray" valign="top"><table border="0" cellspacing="0" cellpadding="0">
		      <tbody><tr>
		        <td width="20"><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>상봉터미널에서 오시는 방법</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>약 15분 간격으로 운행하며 청평행 버스 이용 (약 50분 소요) </td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/portfolio/images/point_2.jpg"></td>
		        <td><strong>동서울터미널에서 오시는 방법</strong></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>약 30분 간격으로 운행하며 청평행 버스 이용 (약 40분 소요) <br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/portfolio/images/point_2.jpg"></td>
		        <td><strong>청량리역에서 1330번 타고 오시는 방법</strong></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>롯데백화점 청량리지점 앞 1번 버스정류장에서 출발하는 모든 종류의 </td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>1330번 버스(빨간 시외버스)로 수시로 운행 (약 50분 소요)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>인천터미널에서 오시는 방법</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>약 1시간 간격으로 운행하며 청평행 버스 이용 (약 1시간 30분 ~ 2시간 소요)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>수원터미널에서 오시는 방법</strong></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>1시간 ~ 1시간 30분 간격으로 운행하며 청평행 이용 (약 1시간 30분 소요)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>상봉 또는 망우역에서 전철로 오시는 방법</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>상봉, 망우역에서 경춘선 전철로 약 20분 간격으로 운행하며 <br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>청평역이나 상천역에서 하차 (약40~50분 소요)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>청량리역, 용산역에서 ITX 청춘열차로 오시는방법</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>청량리역, 용산역에서 ITX청춘열차로 약30분~1시간 간격으로 운행하며 <br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>청평이나 가평에서 하차(약35분~40분 소요)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><p>- 평일시간표와 공휴일및 주말시간표가 상이하므로 ITX를 이용하실분들은<br>
		  &nbsp;&nbsp;시간표를 꼭 참조하세요.<br>
		          - 가평에서 내리실분들은 농협하나로마트에서 장을 보시고 경춘선 전철을 타시고<br>
		          상천역(1정거장)에서 픽업을 받으시면 됩니다.<br>
		            </p>
		          </td>
		      </tr>
		    </tbody></table></td>
		    <td width="1" align="left" class="gray" valign="top"></td>
		    <td align="left" class="gray" valign="top" style="padding-left: 50px;"><table border="0" cellspacing="0" cellpadding="0">
		      <tbody><tr>
		        <td width="20"><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>픽업안내</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>대중교통으로 오시는 커플룸 예약자에 한해서<br> 
						입퇴실 1회씩 픽업서비스를 해드립니다</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>자체픽업을 원할시 예약시 픽업신청(시간, 장소기재)을 하시고 <br>
					오시는날 도착30분 미리 전화를 주셔야 합니다</td>
		      </tr>
			  <tr>
		        <td>&nbsp;</td>
		        <td><font color="red"><strong>패밀리룸 체스트넛, 라일락 객실은 인원관계로 픽업이 불가능합니다.</strong></font><br>
					(마트측 픽업이나 택시를 이용해주세요)<br><br></td>
		      </tr>
			   
			   <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>픽업시간</strong> : 입실시 오후3시부터 오후6시, 퇴실시 오전10시50	분</td>
		      </tr>
			  <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		         <td><img src="../resources/images/point_2.jpg"></td>
		        <td>
		          <strong>자체픽업장소</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><font color="red"><strong>상천역, 청평역, 청평터미널</strong></font> 세곳입니다<br>
					전철타시는 분들은 상천역, ITX타시는분들은 청평역에 하차하세요
					<br><span style="color: red; font-weight: bold;">일요일 입실시 픽업은 교통혼잡으로 상천역만 픽업 가능합니다.<br> 
					마트측픽업, 택시이용도 불가합니다</span><br>
		</td>
		      </tr>
			  <!--
			  <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
			  
		      <tr>
		        <td><img src="images/s7_traffic/point_2.jpg" /></td>
		        <td><strong>마트측 픽업장소</strong>
		        ( ★ 극성수기 기간 전객실 픽업불가)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>청평역, 청평터미널 주변에 <font color="red"><strong>레몬마트</strong></font>가 있습니다 <br />청평에 오셔서 장 보실분들은 반드시<br />
		        <font color="red"><strong>레몬마트</strong></font>에서 1인당 1만5천원이상 구입후 마트측에서 픽업을 받으시면 되세요 <br />
		        다른마트로 가시면 픽업이 불가합니다.
		<br /></td>
		      </tr>
			  -->
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td rowspan="2">&nbsp;</td>
		        <td>*상천역 1분거리에는 <font color="red"><strong>호명산슈퍼</strong></font>가 있습니다.<br>(술, 생수, 음료수, 과자, 라면, 햇반등 판매합니다 )<br>
				</td>
		      </tr>
			  <tr>
		        <td><br><strong>픽업관련 더 자세한 안내는 공지사항 참조 또는<br> 010 5448 1952 전화상담 주세요</strong>
				<p><span style="color: red; font-weight: bold;">"극성수기기간 7월29일(금)~ 8월4일(목)픽업불가 (공지사항참조)"</span> <br>
					<strong>청평역, 청평터미널은 토요일, 공휴일, 시즌에 교통혼잡으로 <br>최대30분까지 시간이 더 걸릴수 있습니다. <br>상천역으로 오시면 빠른픽업이 가능합니다.</strong>
				</p>
				</td>
		        <td></td>
		      </tr>
		      <!--<tr>
		        <td>※ 메이플랜드에서 상천역까지 차로 5분 거리입니다. </td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td> (청평터미널, 청평역은 모두 차로 10분 거리입니다.)</td>
		      </tr>-->
		    </tbody></table></td>
		  </tr>
			</tbody></table>	
	</div>
	
</content>
	
</body>
<script type="text/javascript">
$.ajax({
    type: "Post",
    url: 'Map',
    dataType: 'json',
    data: {
    	'Member':$('title').text().toLowerCase()
    },
    success: function(json)
    {
    	var address = json.request.Result;
    
    	naver.maps.Service.geocode({
    	    address: address
    	}, function(status, response) {
    	    if (status !== naver.maps.Service.Status.OK) {
    	        return alert('Something wrong!');
    	    }

    	    var result = response.result, // 검색 결과의 컨테이너
    	        items = result.items; // 검색 결과의 배열
    	        var center = new naver.maps.LatLng(items[0].point.y, items[0].point.x)
    	        var mapOptions = {
    	       	    center: center,
    	       	    zoom: 10,
    				minZoom: 1, //지도의 최소 줌 레벨
    				zoomControl: true, //줌 컨트롤의 표시 여부
    				zoomControlOptions: { //줌 컨트롤의 옵션
    				    position: naver.maps.Position.TOP_RIGHT
    				}
    	       	};
    	        var map = new naver.maps.Map('map', mapOptions);
    	        var marker = new naver.maps.Marker({
    	            position: center,
    	            map: map
    	        });
    	    // do Something
    	});

    },
    error:function(json){
	    alert('에러.\n');
    }
});	

</script>
</html>