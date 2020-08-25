/* main layout */
var footH = $('#footer').outerHeight();
var i_visual, i_artist, i_studio, i_evt, i_foot;

/* 20200316 솔라바이옴 레이어팝업 */
function setCookie(name, value, expiredays) {
	var today = new Date();
	today.setDate(today.getDate() + expiredays);
	document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
} 

function getCookie(name) { 
    var cName = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) { 
        var y = (x+cName.length); 
        if ( document.cookie.substring( x, y ) == cName ) { 
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
} 

function closePopupNotToday(){	             
	setCookie('notToday23','Y', 1);
	$("#layer_solar").hide('fade');
	$('.solarmask').hide('fade');
} 

function closePopup(){
	$("#layer_solar").hide('fade');
	$('.solarmask').hide('fade');
} 


$(document).ready(function() {
	
	$('#header a.all-menu').click();
	$('#main .mainWrap').fullpage({
		easing:'easeOutSine',
		scrollingSpeed: '800',
		lockAnchors: true,
		recordHistory: false,
		loopHorizontal: false,
		touchSensitivity: 15,
		fixedElements: '',
		normalScrollElements: '',
		afterLoad: function(anchorLink, index){
		}	
	});
	function mainInit(){
		i_visual = $('#sec1').index();
		i_artist = $('#sec2').index()
		i_studio = $('#sec3').index();
		i_evt = $('#sec4').index();
	}
	$(document).on('click', '.mainNavi a', function () {
		var i = $('.mainNavi a').index(this);
		$('.mainNavi li').removeClass('on');
		$('.mainNavi li').eq(i).addClass('on');

});

});
/* section1 */
$(function(){
	$('.mVisualWrap').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		speed: 1000,
		arrows: false,
		fade: true,
		dots: true,
		pauseOnFocus: false,
		pauseOnHover: false,
		autoplay: true,
		autoplaySpeed: 5000,
		infinite: true
	});
});


/* section2 */
function slickSec2(){
	/* section2 */
	$('.artistWrap').on('init', function() {
		setTimeout(function(){ $('.artistWrap').find('.slick-current').addClass('slickAni'); },100);
	})
	.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		speed: 1000,
		arrows: false,
		fade: true,
		dots: true,
		zIndex: 100
	})
	.on('beforeChange', function(event, slick, currentSlide, nextSlide){
		$(this).find('.item').eq(currentSlide).removeClass('slickAni');
		$(this).find('.item').eq(nextSlide).addClass('slickAni');
		if (nowPlaying) { stopVideo(); }
	});
}

/* section3 */
function slickSec3(){
	$('.studioWrap').on('init', function() {
		setTimeout(function(){ $('.studioWrap').find('.slick-current').addClass('slickAni'); },100);
	})
	.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		speed: 1000,
		arrows: false,
		fade: true,
		dots: true,
		zIndex: 100
	})
	.on('beforeChange', function(event, slick, currentSlide, nextSlide){
		$(this).find('.item').eq(currentSlide).removeClass('slickAni');
		$(this).find('.item').eq(nextSlide).addClass('slickAni');
		if (nowPlaying) { stopVideo(); }
	});
}


var loadedVod = false;
var nowPlaying = false;
function loadYT(){
	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	
	window.onYouTubeIframeAPIReady = function(){
		if (typeof playerInfoList === 'undefined') return;
		//alert('vod');
		for (var i = 0; i < playerInfoList.length; i++) {
			var curplayer = createPlayer(playerInfoList[i]);
			players[i] = curplayer;
		}
	}
	
};
var playerInfoList = [
	{id:'player0', controls:'0', autohide:'1', videoId:''},
	{id:'player1', controls:'0', autohide:'1', videoId:''}
];
function onYouTubeIframeAPIReady() {
	if (typeof playerInfoList === 'undefined') return;
	//alert('vod');
	for (var i = 0; i < playerInfoList.length; i++) {
		var curplayer = createPlayer(playerInfoList[i]);
		players[i] = curplayer;
	}
}
var players = new Array();
function createPlayer(playerInfo) {
	return new YT.Player(playerInfo.id, {
		width: '100%',
		height: '100%',
		videoId: playerInfo.videoId,
		wmode: 'transparent',
		events: {
            'onReady': onPlayerReady,
			'onStateChange': onPlayerStateChange
		},
		playerVars: {
			autoplay: 0,
			autohide: 1,
			controls: 0,
			showinfo: 0,
			rel: 0,
			modestbranding: 1,
			wmode: 'transparent'
		}
	});
}
function onPlayerReady(event) {
	loadedVod = true;
}
function onPlayerStateChange(event) {
	if(event.data == YT.PlayerState.ENDED){
		$('.vodArea').removeClass('playing');
		nowPlaying = false;
		//console.log('end');
	}
}
function playVOD(ele,videoId){
	if (loadedVod) {
		if (nowPlaying) {
			stopVideo();
		}
		players[ele].loadVideoById(videoId);
		players[ele].setPlaybackQuality('hd1080');
		players[ele].seekTo(0).playVideo();
		if (ele == 0) {
			$('#sec2 .vodArea').stop().animate({'opacity':'1'}, 200, 'easeInOutQuad', function(){
				$('#sec2 .vodArea').addClass('playing');
				nowPlaying = true;
			})
		} else if (ele == 1) {
			$('#sec3 .vodArea').stop().animate({'opacity':'1'}, 200, 'easeInOutQuad', function(){
				$('#sec3 .vodArea').addClass('playing');
				nowPlaying = true;
			})
		}
	}	
}
function stopVideo(){
	nowPlaying = false;
	$('.vodArea').stop().animate({'opacity':'0'}, 200, 'easeInOutQuad', function(){
		for(var i = 0; i < players.length; i++){
			players[i].stopVideo();
		}
		$('.vodArea').removeClass('playing');
		$('.vodArea').css({'opacity':''});
	});
}