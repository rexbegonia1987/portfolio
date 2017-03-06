$(window).on('scroll',function(){
	if($(window).scrollTop() !=0 ){
		$('header').css({'position':'fixed','top':0,'left':0,'width':'100%'});
		$('#welcome').css('display','none');
		$('#gnb').removeClass('col-xs-6');
		$('#gnb').removeClass('col-xs-offset-3')
		$('#gnb').addClass('col-xs-12');
		
	}else{
		$('header').attr('style','');
		$('#welcome').css('display','inline-block');
		$('#gnb').addClass('col-xs-6');
		$('#gnb').addClass('col-xs-offset-3')
		$('#gnb').removeClass('col-xs-12');
	}
	
})	


