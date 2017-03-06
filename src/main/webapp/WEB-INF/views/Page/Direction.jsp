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
		        <td><strong>����͹̳ο��� ���ô� ���</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>�� 15�� �������� �����ϸ� û���� ���� �̿� (�� 50�� �ҿ�) </td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/portfolio/images/point_2.jpg"></td>
		        <td><strong>�������͹̳ο��� ���ô� ���</strong></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>�� 30�� �������� �����ϸ� û���� ���� �̿� (�� 40�� �ҿ�) <br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/portfolio/images/point_2.jpg"></td>
		        <td><strong>û���������� 1330�� Ÿ�� ���ô� ���</strong></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>�Ե���ȭ�� û�������� �� 1�� ���������忡�� ����ϴ� ��� ������ </td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>1330�� ����(���� �ÿܹ���)�� ���÷� ���� (�� 50�� �ҿ�)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>��õ�͹̳ο��� ���ô� ���</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>�� 1�ð� �������� �����ϸ� û���� ���� �̿� (�� 1�ð� 30�� ~ 2�ð� �ҿ�)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>�����͹̳ο��� ���ô� ���</strong></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>1�ð� ~ 1�ð� 30�� �������� �����ϸ� û���� �̿� (�� 1�ð� 30�� �ҿ�)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>��� �Ǵ� ���쿪���� ��ö�� ���ô� ���</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>���, ���쿪���� ���ἱ ��ö�� �� 20�� �������� �����ϸ� <br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>û���̳� ��õ������ ���� (��40~50�� �ҿ�)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>û������, ��꿪���� ITX û�῭���� ���ô¹��</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>û������, ��꿪���� ITXû�῭���� ��30��~1�ð� �������� �����ϸ� <br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>û���̳� ���򿡼� ����(��35��~40�� �ҿ�)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><p>- ���Ͻð�ǥ�� �����Ϲ� �ָ��ð�ǥ�� �����ϹǷ� ITX�� �̿��ϽǺе���<br>
		  &nbsp;&nbsp;�ð�ǥ�� �� �����ϼ���.<br>
		          - ���򿡼� �����Ǻе��� �����ϳ��θ�Ʈ���� ���� ���ð� ���ἱ ��ö�� Ÿ�ð�<br>
		          ��õ��(1������)���� �Ⱦ��� �����ø� �˴ϴ�.<br>
		            </p>
		          </td>
		      </tr>
		    </tbody></table></td>
		    <td width="1" align="left" class="gray" valign="top"></td>
		    <td align="left" class="gray" valign="top" style="padding-left: 50px;"><table border="0" cellspacing="0" cellpadding="0">
		      <tbody><tr>
		        <td width="20"><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>�Ⱦ��ȳ�</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>���߱������� ���ô� Ŀ�÷� �����ڿ� ���ؼ�<br> 
						����� 1ȸ�� �Ⱦ����񽺸� �ص帳�ϴ�</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>��ü�Ⱦ��� ���ҽ� ����� �Ⱦ���û(�ð�, ��ұ���)�� �Ͻð� <br>
					���ô³� ����30�� �̸� ��ȭ�� �ּž� �մϴ�</td>
		      </tr>
			  <tr>
		        <td>&nbsp;</td>
		        <td><font color="red"><strong>�йи��� ü��Ʈ��, ���϶� ������ �ο������ �Ⱦ��� �Ұ����մϴ�.</strong></font><br>
					(��Ʈ�� �Ⱦ��̳� �ýø� �̿����ּ���)<br><br></td>
		      </tr>
			   
			   <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td><img src="../resources/images/point_2.jpg"></td>
		        <td><strong>�Ⱦ��ð�</strong> : �Խǽ� ����3�ú��� ����6��, ��ǽ� ����10��50	��</td>
		      </tr>
			  <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		         <td><img src="../resources/images/point_2.jpg"></td>
		        <td>
		          <strong>��ü�Ⱦ����</strong><br></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><font color="red"><strong>��õ��, û��, û���͹̳�</strong></font> �����Դϴ�<br>
					��öŸ�ô� �е��� ��õ��, ITXŸ�ôºе��� û�򿪿� �����ϼ���
					<br><span style="color: red; font-weight: bold;">�Ͽ��� �Խǽ� �Ⱦ��� ����ȥ������ ��õ���� �Ⱦ� �����մϴ�.<br> 
					��Ʈ���Ⱦ�, �ý��̿뵵 �Ұ��մϴ�</span><br>
		</td>
		      </tr>
			  <!--
			  <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
			  
		      <tr>
		        <td><img src="images/s7_traffic/point_2.jpg" /></td>
		        <td><strong>��Ʈ�� �Ⱦ����</strong>
		        ( �� �ؼ����� �Ⱓ ������ �Ⱦ��Ұ�)</td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>û��, û���͹̳� �ֺ��� <font color="red"><strong>����Ʈ</strong></font>�� �ֽ��ϴ� <br />û�� ���ż� �� ���Ǻе��� �ݵ��<br />
		        <font color="red"><strong>����Ʈ</strong></font>���� 1�δ� 1��5õ���̻� ������ ��Ʈ������ �Ⱦ��� �����ø� �Ǽ��� <br />
		        �ٸ���Ʈ�� ���ø� �Ⱦ��� �Ұ��մϴ�.
		<br /></td>
		      </tr>
			  -->
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		      </tr>
		      <tr>
		        <td rowspan="2">&nbsp;</td>
		        <td>*��õ�� 1�аŸ����� <font color="red"><strong>ȣ��꽴��</strong></font>�� �ֽ��ϴ�.<br>(��, ����, �����, ����, ���, �޹ݵ� �Ǹ��մϴ� )<br>
				</td>
		      </tr>
			  <tr>
		        <td><br><strong>�Ⱦ����� �� �ڼ��� �ȳ��� �������� ���� �Ǵ�<br> 010 5448 1952 ��ȭ��� �ּ���</strong>
				<p><span style="color: red; font-weight: bold;">"�ؼ�����Ⱓ 7��29��(��)~ 8��4��(��)�Ⱦ��Ұ� (������������)"</span> <br>
					<strong>û��, û���͹̳��� �����, ������, ���� ����ȥ������ <br>�ִ�30�б��� �ð��� �� �ɸ��� �ֽ��ϴ�. <br>��õ������ ���ø� �����Ⱦ��� �����մϴ�.</strong>
				</p>
				</td>
		        <td></td>
		      </tr>
		      <!--<tr>
		        <td>�� �����÷��忡�� ��õ������ ���� 5�� �Ÿ��Դϴ�. </td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td> (û���͹̳�, û���� ��� ���� 10�� �Ÿ��Դϴ�.)</td>
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

    	    var result = response.result, // �˻� ����� �����̳�
    	        items = result.items; // �˻� ����� �迭
    	        var center = new naver.maps.LatLng(items[0].point.y, items[0].point.x)
    	        var mapOptions = {
    	       	    center: center,
    	       	    zoom: 10,
    				minZoom: 1, //������ �ּ� �� ����
    				zoomControl: true, //�� ��Ʈ���� ǥ�� ����
    				zoomControlOptions: { //�� ��Ʈ���� �ɼ�
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
	    alert('����.\n');
    }
});	

</script>
</html>