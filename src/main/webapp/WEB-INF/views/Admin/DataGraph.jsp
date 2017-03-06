<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="../resources/css/Index.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/aReservList.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/Loader.css" />

<script rel="stylesheet" type="text/javascript" src="../resources/js/jquery-3.1.1.min.js"></script>
<script rel="stylesheet" type="text/javascript" src = "../resources/js/excanvas.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.highlighter.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.logAxisRenderer.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.cursor.min.js"></script>
<script type="text/javascript" src="../resources/plugins/jqplot.pointLabels.min.js"></script>

<link rel="stylesheet" href="../resources/css/jquery.jqplot.min.css">
<script>
	$(document).ready(function(){
		var MemberName = '${request.MemberName}';
		var MemberId = '${request.MemberId}';
		var Button = false;
		$('#MenuList li').on('click',function(){
			var MovePage=$(this).text();
			if($(this).text() == 'Home'){
				MovePage = 'Implication';
			}
			var URL = window.location.href.replace('DataGraph',MovePage);
			$('form').attr('action',URL).submit();
		});
		$("#Member").append(MemberName);
		$("#MemberName").val(MemberName);
		$('#MemberId').val(MemberId);
		$('#PopUpArea').height($(document).height());

		 //var data = [['월',0],['화',7],['수',1],['목',1],['금',3],['토',2],['일',1]];
		 //var data2 = [[2002, 11200], [2003, 12200], [2004, 10400], [2005, 9900], [2006, 12100], 
		//	           [2007, 14800], [2008, 11400], [2009, 13300], [2010, 11000], [2011, 13000]];

		 var TODAY = new Date();

	
	$('.SendButton').on('click',function(){
		var Dis = $(this).attr('id').split('_');
		AJAXFUC(MemberId,Dis[2],Dis[1],FastCheck(Dis[1]),Setting(Dis[2],Dis[1]));
	});
	$('#Fast_Week_Reserv').click();
	$('#DetailView').on('click',function(){
    $('#SendArea').slideToggle();
    $('#Detail').html('');
    var DetailHTML ='';
    DetailHTML += '<p> 선택 : <span href="#" class="Select1" id="Pay">수익</span><span href="#" class="Select1" id="Reserv">예약수</span></p>'
    $('#Detail').html(DetailHTML);
    $('#Detail').slideToggle();
    $('.Select1').on('click',function(){
        $('.Select1').css('background-color','white').removeClass('SelectWay');
        $(this).css('background-color','#ccc').addClass('SelectWay');
        var DetailSelect ='<p id="SelectTerm"> 기간 : <span href="#" class="Select2" id="Week">주간</span><span href="#" class="Select2" id="Month">월별</span><span href="#" class="Select2" id="Admin1">임의</span></p>'
        if($(this).attr('id') =='Pay'){
             var DetailSelect ='<p id="SelectTerm"> 기간 : <span href="#" class="Select2" id="Week">주간</span><span href="#" class="Select2" id="Month">월별</span><span href="#" class="Select2" id="Admin1">임의</span></p>'
        }else{

        }
        $('#SelectTerm').remove();
        $('#SelectDM').remove();
        $('#SelectDM').remove();
        $('#GetMonth').remove();
        $('#SelectWk').remove();
        $('#SendButtonArea').remove();
        $(this).parent().after(DetailSelect);
        $('.Select2').on('click',function(){
            $('.Select2').css('background-color','white').removeClass('SelectTerm');
            $(this).css('background-color','#ccc');
            $(this).addClass('SelectTerm');
             $('#SelectDM').remove();
             $('#GetMonth').remove();
             $('#SelectWk').remove();
             $('#SendButtonArea').remove();
             Button =false;
            var DetailTerm ='<p id="SelectDM">';
              DetailTerm +='</p>';
            $(this).parent().after(DetailTerm);
            if($(this).attr('id') =='Week'){
                $('#SelectDM').html('');
                $('#SelectDM').html('<select id="GetYear"><option value="0">선택하기</option></select>');
                var NowDate = new Date();
                for(var i = 0 ; i < 3 ; i++){
                    $('#GetYear').append('<option value="'+(NowDate.getFullYear()-i)+'">'+(NowDate.getFullYear()-i)+"</option>");
                }
                $('#GetYear').on('change',function(){
                   $('#GetMonth').remove();
                    $('#SelectWk').remove();
                    $('#SendButtonArea').remove();
                    Button =false;
                    $('#SelectDM').append('<select id="GetMonth"><option value="0">선택하기</select></select>');
                    for(var j = 1 ; j <=12 ; j++){
                        $('#GetMonth').append('<option value="'+NumStr(j)+'">'+j+'</option>')
                    }
                    $('#GetMonth').on('change',function(){
                        $('#SendButtonArea').remove();
                         var SendDate = $('#GetYear').val() +'-' +$('#GetMonth').val();
                         var WeekNum = getDate(SendDate);
                         $('#SelectWk').remove();
                         $('#Detail').append('<p id="SelectWk"></p>');
                         for( var k = 1 ; k <= WeekNum; k++){
                            $('#SelectWk').append('<span class="Week" id="Week'+k+'">'+k+'주차</span>');
                         }
                         Button =false;
                         $('.Week').on('click',function(){
                             $('.Week').css('background-color','white').removeClass('WeekNum');
                             $(this).css('background-color','#ccc').addClass('WeekNum');
                             $('#SendButtonArea').remove();
                             if(!Button){
                            	 $('#Detail').append('<p id="SendButtonArea"><input type="button" id="SendData" name="SendData" value="확인하기"></p>');
                            	 Button=true;
                             }
                             
                             $('#SendData').on('click',function(){
                                var SendMonth = $('#GetYear').val() + '-'+ $('#GetMonth').val()
                                var TheWay = $('.SelectWay').attr('id');
                                var TheTerm = $('.SelectTerm').attr('id');
                                var TheWeek = $('.WeekNum').attr('id');
                                TheWeek = TheWeek.replace('Week','');
                            	var THEWEEK=WeekTerm(SendMonth,TheWeek);
                            	AJAXFUC(MemberId,TheWay,TheTerm,THEWEEK,Setting(TheWay,TheTerm));
                             })
                         })
                    })
                   
                });
            }else if($(this).attr('id') =='Month'){
                $('#SelectDM').html('');
                $('#SelectDM').html('<select id="GetYear"><option value="0">선택하기</option></select>');
                var NowDate = new Date();
                for(var i = 0 ; i < 3 ; i++){
                    $('#GetYear').append('<option value="'+(NowDate.getFullYear()-i)+'">'+(NowDate.getFullYear()-i)+"</option>");
                }
                $('#GetYear').on('change',function(){
                   $('#GetMonth').remove();
                    $('#SelectWk').remove();
                    $('#SendButtonArea').remove();
                    Button =false;
                    $('#SelectDM').append('<select id="GetMonth"><option value="0">선택하기</select></select>');
                    for(var j = 1 ; j <=12 ; j++){
                        $('#GetMonth').append('<option value="'+NumStr(j)+'">'+j+'</option>')
                    }
                    $('#GetMonth').on('change',function(){
                        $('#SendButtonArea').remove();
                        Button=false;
                        if(!Button){
                       	 $('#Detail').append('<p id="SendButtonArea"><input type="button" id="SendData" name="SendData" value="확인하기"></p>');
                       	 Button=true;
                        }
                        $('#SendData').on('click',function(){
                            var TheWay = $('.SelectWay').attr('id');
                            var TheTerm = $('.SelectTerm').attr('id');
                            var TheDate = SendMonth($('#GetYear').val(),$('#GetMonth').val());
                            AJAXFUC(MemberId,TheWay,TheTerm,TheDate,Setting(TheWay,TheTerm));
                         })
                         
                    })
                   
                });
            }else{
                $('#SelectDM').html('');
                $('#SelectDM').html('<span class="DatetView StartDate">시작일</span><input type="text" id="StartDate" class="Picker" name="StartDate" style="display:none;"><span class="DatetView EndDate">종료일</span><input type="text" id="EndDate" class="Picker" name="EndDate" style="display:none;">');
                $('.Picker').on('change',function(){
                	var InputDate = $(this).val().split('-');
                	var ViewDate = InputDate[0] +'년'+InputDate[1]+'월'+InputDate[2]+'일';
                	$('.'+$(this).attr('id')).text(ViewDate);
                })
                $('#StartDate').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    showAnim:'blind',
                    showOn:'button'
                });
                $('#StartDate').on('change',function(){
                    var StartDate = $(this).val();
                    var EndDate= $('#EndDate').val();
                    if(EndDate < StartDate && $('#EndDate').val() !='' ){
                        alert('값을 잘못입력하셨습니다.');
                        $(this).val('');
                    }else if(StartDate != '' && EndDate !=''){
                    	if(!Button){
                    		$('#Detail').append('<p id="SendButtonArea"><input type="button" id="SendData" name="SendData" value="확인하기"></p>');
                    		Button=true;
                    	}
                    	$('#SendData').on('click',function(){
                    		 var TheWay = $('.SelectWay').attr('id');
                    		 var TheTerm = "Month"
                             var TheDate = [StartDate,EndDate];
                             AJAXFUC(MemberId,TheWay,TheTerm,TheDate,Setting(TheWay,TheTerm));
                    		
                           // alert(EndDate +'::' + StartDate);

                         })
                    }
                })
                $('img.ui-datepicker-trigger').css('cursor:pointer');
                $.datepicker.setDefaults({dateFormat:'yy-mm-dd'});
                $('#EndDate').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    showAnim:'blind',
                    showOn:'button'
                });
                $('#EndDate').on('change',function(){
                    var EndDate = $(this).val();
                    var StartDate = $('#StartDate').val();
                    if(EndDate < StartDate){
                        alert('값을 잘못입력하셨습니다.');
                        $(this).val('');
                    }else if(StartDate != '' && EndDate !=''){
                    	if(!Button){
                    		$('#Detail').append('<p id="SendButtonArea"><input type="button" id="SendData" name="SendData" value="확인하기"></p>');
                    		Button=true;	
                    	}
                    	$('#SendData').on('click',function(){
                           
                    		 var TheWay = $('.SelectWay').attr('id');
                    		 var TheTerm = "Month"
                             var TheDate = [StartDate,EndDate];
                             AJAXFUC(MemberId,TheWay,TheTerm,TheDate,Setting(TheWay,TheTerm));

                         })
                    }
                })
            }
          
        });
    })
   })

		
});
function AJAXFUC(ID,Way,Target,Term,Set){
	var StartDate = Term[0];
	var EndDate = Term[1];
	$('#chart').html('');
	$('#PopUpArea').css('display','block');
	$('#PopUpContent').addClass('Loader');
	$.ajax({
        type: "Post",
        url: 'DataGraphData',
        dataType: 'json',
        data: {
        	'ID' : ID,
        	'Way': Way,
        	'Target' : Target,
        	'SD' : StartDate,
        	'ED' : EndDate
 		
        },
        success: function(json)
        {
        	$('#PopUpArea').css('display','none');
        	$('#PopUpContent').removeClass('Loader');
        	$.jqplot("chart", [json.request],Set);
        	
         	
        },
        error:function(json){
    	    alert('로그인에 실패하였습니다.\n');
        }
    });	
	
}
function Setting(D1,D2){
	var Way=D1;
	var Term = D2;
	var Data1,Data2;
	if(Way == "Reserv"){
		Data2 = "예약";
	}else{
		Data2 = "수입";
	}
	if(Term == 'Week'){
		Data1 = "요일";
	}else{
		Data1 = "날짜"
	}
	var Result ={
		      // Give the plot a title.
		      title: 'DataGraph',
		   // Turns on animatino for all series in this plot.
	            animate: true,
	            // Will animate plot on calls to plot1.replot({resetAxes:true})
	            animateReplot: true,
	            series:[
	                {
	                    rendererOptions: {
	                        // speed up the animation a little bit.
	                        // This is a number of milliseconds.
	                        // Default for a line series is 2500.
	                        animation: {
	                            speed: 2000
	                        }
	                    }
	                }
	            ],
		      // You can specify options for all axes on the plot at once with
		      // the axesDefaults object.  Here, we're using a canvas renderer
		      // to draw the axis label which allows rotated text.
		      axesDefaults: {
		        labelRenderer: $.jqplot.CanvasAxisLabelRenderer
		      },
		      // Likewise, seriesDefaults specifies default options for all
		      // series in a plot.  Options specified in seriesDefaults or
		      // axesDefaults can be overridden by individual series or
		      // axes options.
		      // Here we turn on smoothing for the line.
		      seriesDefaults: {
		          rendererOptions: {
		              smooth: false
		          }
		      },
		      // An axes object holds options for all axes.
		      // Allowable axes are xaxis, x2axis, yaxis, y2axis, y3axis, ...
		      // Up to 9 y axes are supported.
		      axes: {
		        // options for each axis are specified in seperate option objects.
		        xaxis: {
		          label: Data1,
		         
                  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
                  renderer: $.jqplot.CategoryAxisRenderer,
                  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                  tickOptions: {
                	  pad:1,
                	  angle:-60
                  },
                  autoscale:true,
                  pad:1
		          // Turn off "padding".  This will allow data point to lie on the
		          // edges of the grid.  Default padding is 1.2 and will keep all
		          // points inside the bounds of the grid.
		          
		        },
		        yaxis: {
		          label: Data2,
		          renderer: $.jqplot.LinearAxisRenderer,  
                  labelOptions:{
                      fontFamily:'Helvetica',
                      fontSize: '11pt'
                      
                  },
                  numberTicks:6,
                  autoscale:true,
                  tickOptions: {
                      formatString: "%'d"
                     
                  },
                  pad:0
		        }
		      },
		      highlighter: {
	                show: true, 
	                showLabel: true, 
	                tooltipAxes: 'y',
	                tooltipLocation : 'ne'
	            }
	}
	return Result;
}
function getDate(SendDate) {
  // (objDate)YYYY-MM-DD 타입으로 입력하세요.
  var objDate = SendDate
  var arrDate = objDate.split("-");
  //입력일의 요일.( 0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일 )
  var thisDate =new Date(arrDate[0],arrDate[1]-1);
//  var thisWeek = thisDate.getDay();
  //입력일의  마지막일자
  var lastDate =new Date(arrDate[0],arrDate[1]-1,0);
  var last2Date =new Date(arrDate[0],arrDate[1]-1,1);
  var lastDays = lastDate.getDate();
  var monthSWeek = last2Date.getDay();
  var nWeek =0;
  if(parseInt((lastDays - 7 + monthSWeek)%7) !=0){
    nWeek=parseInt((lastDays - 7 + monthSWeek)/7)+1;
  }else{
    nWeek=parseInt((lastDays - 7 + monthSWeek)/7)
  }
  return nWeek;
 }
 function NumStr(Num){
    var Result;
    if(Num<10){
        Result='0'+Num;
    }else{
        Result=Num;
    }

    return Result;
 }
 function NowWeekTerm(YM){
	 var YearMonth = YM.split('-');
	 var NLastDate = new Date(YearMonth[0],YearMonth[1]-1,0);
     var NowDays = NLastDate.getDay();
     var NowDate = NLastDate.getDate();
     var GetSunday = NowDate-NowDays;
     var Sunday,Saterday;
     if(GetSunday < 0){
    	 var BLastDate = new Date(YearMonth[0],(YearMonth[1]-1),0);
    	 Sunday= date.getFullYear() +'-'+ NumStr(date.getMonth()+1) +'-'+ NumStr(BLastDate.getDate()+GetSunday);
     }else if(GetSunday ==0){
    	 Sunday= NLastDate.getFullYear() +'-'+ NumStr(NLastDate.getMonth()+1) +'-'+ NumStr(NowDate)
     }else{
    	 Sunday= NLastDate.getFullYear() +'-'+ NumStr(NLastDate.getMonth()+1) +'-'+ NumStr(GetSunday);	 
     }
     if(GetSunday+6 > NLastDate.getDate()){
    	 var TempDate = GetSunday+6-NLastDate.getDate();
    	 if(YearMonth[1]==12){
    		 Saterday = (NLastDate.getFullYear()+1) +'-01-'+ NumStr(GetSunday+6);
    	 }
     }else{
    	 Saterday = NLastDate.getFullYear() +'-'+ NumStr(NLastDate.getMonth()+1) +'-'+ NumStr(GetSunday+6);	 
     }
     
     
     var Result = [Sunday,Saterday];
     return Result;
 }
 function WeekTerm(YM,Num){
	 var YearMonth = YM.split('-');
	 var date = new Date(YearMonth[0],YearMonth[1]-1,1);
     var FirstDays = date.getDay();
     var NWeekFirstDate;
   	if(FirstDays != 0){
   		NWeekFirstDate=7*Num -FirstDays+1;	
   	}else{
   		NWeekFirstDate=7*(Num -1)+1;
   	}
   	var TheDate = YearMonth[0]+'-'+NumStr(YearMonth[1])+'-'+NumStr(NWeekFirstDate);
     var SendData = SendWeek(TheDate);	
     return SendData;
 }
 function SendWeek(YMD){
	 var TheDate = YMD.split('-');
	 var date = new Date(YMD);
	 var day = date.getDay();
	 var Result;
	 var Sunday,Saterday
	 if(TheDate[2]-day <=0){
		 var BLastDate;
		 if(parseInt(TheDate[1]) ==1){
			 BLastDate = new Date(parseInt(TheDate[0])-1,12,0);
		 }else{
			 BLastDate = new Date(TheDate[0],parseInt(TheDate[1])-1,0);
		 }
		 Sunday = BLastDate.getFullYear()+'-'+NumStr(BLastDate.getMonth()+1)+'-'+NumStr(BLastDate.getDate()-(7-day));
		 
	 }else{
		 Sunday = TheDate[0]+'-'+TheDate[1]+'-'+NumStr(parseInt(TheDate[2])-day); 
	 }
	 var GetSaterday=new Date(Sunday);
	 var TempDate = new Date(GetSaterday.getFullYear(),+GetSaterday.getMonth()+1,0);
	 if(GetSaterday.getDate()+6 >TempDate.getDate()){
		 if(GetSaterday.getMonth() !=11){
			 Saterday = GetSaterday.getFullYear() + '-'+NumStr(GetSaterday.getMonth()+2)+'-'+NumStr(6-TempDate.getDay());	 
		 }else{
			 Saterday = (GetSaterday.getFullYear()+1) + '-'+NumStr(1) + '-' +NumStr(6-TempDate.getDay());
		 }
		 
	 }else{
		 Saterday = GetSaterday.getFullYear() + '-'+NumStr(GetSaterday.getMonth()+1)+'-'+NumStr(GetSaterday.getDate()+6);
	 }
	 Result = [Sunday,Saterday];
	return Result;

 }
function SendMonth(Y,M){
	
	var StartMonth = new Date(Y,M-1,1);
	var EndMonth = new Date(Y,M,0);
	var StartDate = StartMonth.getFullYear() +'-'+ NumStr(StartMonth.getMonth()+1) + "-" + NumStr(StartMonth.getDate());
	var EndDate = EndMonth.getFullYear() +'-'+ NumStr(EndMonth.getMonth()+1) + "-" + NumStr(EndMonth.getDate());
	var Result =[StartDate,EndDate];	
	return Result;
}
function FastCheck(Term){
	var TERM = Term;
	var Result;
	var TODAY = new Date();
	var Today =TODAY.getFullYear() + "-" + NumStr(TODAY.getMonth()+1) + "-" + NumStr(TODAY.getDate());
	var StartDate;
	if(TERM == 'Week'){
		if(TODAY.getDate() < 7){
			if(TODAY.getMonth() == 0){
				var LDATE = new Date((TODAY.getFullYear()-1),12,0);
				StartDate =LDATE.getFullYear()+"-"+12+"-"+NumStr(LDATE.getDate()-(6-TODAY.getDate())); 
				Result=[StartDate,Today];
			}else{
				var LDATE = new Date(TODAY.getFullYear(),TODAY.getMonth()-1,0);
				StartDate =LDATE.getFullYear()+"-"+Numstr(LDATE.getMonth+1)+"-"+NumStr(LDATE.getDate()-(6-TODAY.getDate()));
				Result=[StartDate,Today];
			}
		}else{
			StartDate = TODAY.getFullYear()+"-"+NumStr(TODAY.getMonth()+1)+"-"+NumStr(TODAY.getDate()-6);
			Result=[StartDate,Today];
		}
	}else{
		var LDATE = new Date(TODAY.getFullYear(),TODAY.getMonth()+1,0);
		if(LDATE.getDate != TODAY.getDate()){
			if(TODAY.getMonth() !=0){
				StartDate =TODAY.getFullYear()+"-"+NumStr(TODAY.getMonth())+"-" +NumStr(TODAY.getDate());	
			}else{
				StartDate =(TODAY.getFullYear()-1)+"-"+12+"-" +NumStr(TODAY.getDate());
			}
			
		}else{
			StartDate = TODAY.getFullYear()+"-"+NumStr(TODAY.getMonth()+1)+"-"+NumStr(1);
		}
		Result=[StartDate,Today];
	}
	return Result;
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
<content>
<div id="chart" style="width:800px;height:304px;margin:0 auto; text-align:center;"></div>
<div id="SendArea" class='ui-helper-reset' style='text-align: center;margin:20px auto;'>
    <input type="button" class="SendButton" id="Fast_Week_Pay" value='최근 1주일간 수익'>
    <input type="button" class="SendButton" id="Fast_Month_Pay" value='최근 한달간 수익'>
    <input type="button" class="SendButton" id="Fast_Week_Reserv" value='최근 1주일간 예약'>
    <input type="button" class="SendButton" id="Fast_Month_Reserv" value='최근 한달간 예약'>
</div>

<div id="DetailArea" style='text-align: center;margin:0px auto;'>
    <input type="button" id='DetailView' class="DetailView" value='사용자 임의로 범위 설정하여 검색하기' style='width:800px;'>
    <div id="Detail" style='display: none;'>
        <input type="button" id='1' class="1" value='사용자 임의로 범위 설정하여 검색하기' style='width:800px;'>
        <input type="button" id='2' class="2" value='사용자 임의로 범위 설정하여 검색하기' style='width:800px;'>
    </div>
</div>
</content>
<div id='PopUpArea'>
	<div id='PopUpContent' style='display:inline-block; width:75px;height:75px;margin-top:80px;'>
	</div>
</div>
</body>
</html>