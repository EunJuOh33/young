/*  ===공통=== */
var main = false;

//스크롤이동
function goTo(to){
	$('html, body').stop().animate({scrollTop : to});
};

$(function(){
	var _scrollReady = true;

	// gnb
	$('#header a.all-menu').on('click',function(){
		if ($(this).hasClass('active')) {
			$('.mask').remove();
			$('body').removeClass('ofH');
			$('.gnbwrap').removeClass('open');
			$('.header .fixmenu').removeClass('active');
			$(this).removeClass('active');
			//_scrollReady = true;
		} else {
			$('.gnbwrap').addClass('open');
			$('body').addClass('ofH');
			$('.header .fixmenu').addClass('active');
			$(this).addClass('active');
			$('body').append('<div class="mask"></div>');
			$('.mask').css({'z-index':900});
			//_scrollReady = false;
		}
		return false;
	});

	$('a.all-menu').on('click',function(){
		if ($(this).hasClass('active')) {
		} else {
		}
		return false;
	});

	// sub menu
	$('.topGnb > ul > li').on('mouseenter', function(){
		$(this).find('.snb').css({ 'height':$(this).find('.snb').find('ul').innerHeight() + 2, 'z-index':850 });
	});
	$('.topGnb > ul > li').on('mouseleave', function(){
		$(this).find('.snb').css({'height':0, 'z-index':10});
	});

	//footer
	/*$('.foot_menu .m1 a').click(function(){
		window.open('http://www.haveandbe.com/?bcd=','company','width=1045, height=750, left=0, top=0, location=no, menubar=no, status=no, toolbar=no');
		return false;
	});*/
	$('.foot_info .busnessinfo').click(function(){
		window.open('http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=2148763681','communicationViewPopup','width=750, height=700, left=0, top=0, location=no, menubar=no, status=no, toolbar=no, scrollbars=yes');
		return false;
	});
	$(document).on('click', '.sitemap .tit', function (){
		if ($('.familysite .tit').hasClass('on')) {
			$('.familysite .tit').click();
		}
		if ($('.language .tit').hasClass('on')) {
			$('.language .tit').click();
		}
		if ($(this).hasClass('on')) {
			$(this).removeClass('on');
			$(this).next('.sitemap_menu').removeClass('open');
		} else {
			$(this).addClass('on');
			$(this).next('.sitemap_menu').addClass('open');
		}

	});
	$(document).on('click', '.familysite .tit', function (){
		if ($('.sitemap .tit').hasClass('on')) {
			$('.sitemap .tit').click();
		}
		if ($('.language .tit').hasClass('on')) {
			$('.language .tit').click();
		}
		if ($(this).hasClass('on')) {
			$(this).removeClass('on');
			$(this).next('ul').removeClass('open');
		} else {
			$(this).addClass('on');
			$(this).next('ul').addClass('open');
		}

	});
	$(document).on('click', '.language .tit', function (){
		if ($('.sitemap .tit').hasClass('on')) {
			$('.sitemap .tit').click();
		}
		if ($('.familysite .tit').hasClass('on')) {
			$('.familysite .tit').click();
		}
		if ($(this).hasClass('on')) {
			$(this).removeClass('on');
			$(this).next('ul').removeClass('open');
		} else {
			$(this).addClass('on');
			$(this).next('ul').addClass('open');
		}

	});

	// 체크박스
	$(document).on('click', '.inp_check label', function (){
		if ($(this).parent().hasClass('readOnly')){return false;}
		if ($(this).parent().hasClass('disabled')){return false;}
		
		var tar = $(this).parent().find('input');
		var chk = tar.prop('checked');
		var grpNm = tar.attr('name');


		if ($(this).parent('.inp_check').hasClass('allChk')){ // 전체동의
			var chkStatus = tar.prop('checked');
			$("input:checkbox[name=" + grpNm + "]").each(function() {
				if (chkStatus) {
					$(this).closest(".inp_check").removeClass("checked");
					$(this).prop("checked",false);
				} else {
					$(this).closest(".inp_check").addClass("checked");
					$(this).prop("checked",true);
				}
			});
		} else {
			if ($(this).parent().hasClass('checked')) {
				$("input:checkbox[name=" + grpNm + "]").each(function() {
					$(this).closest('.inp_check.allChk').removeClass('checked');;
					$(this).closest('.inp_check.allChk input').prop("checked",false);
				});
				$(this).parent().removeClass('checked');
				tar.prop("checked",false);
			} else {
				$(this).parent().addClass('checked');
				tar.prop("checked",true);
			}
		}
		console.log(tar.prop('checked'));
		return false;
	});
	//라디오버튼
	$(document).on('click', '.inp_radio input', function (){
		if ($(this).parent().hasClass('readOnly')){return false;}
		if ($(this).parent().hasClass('disabled')){return false;}
		var grpNm = $(this).attr("name");
		$("input:radio[name=" + grpNm + "]").each(function() {
			$(this).closest(".inp_radio").removeClass("checked");
        	$(this).prop("checked",false);
		});
		$(this).parent().addClass("checked");
        $(this).parent().find("input").prop("checked",true);
	});
	//file upload
	$(document).on('click', '.btn_upload .add_file', function (){
		$(this).next('.inp_file').click();
	});
	$(document).on("click", ".addFile_btn .addFile_show", function(e){
		e.preventDefault();
		$(this).parent().find(".addFile_real").trigger("click");
	});

	// 아코디언
	$(document).on('click', '.slideTit > button', function (){
		var slideOpen = $(this).parent().hasClass('open');
		if (slideOpen) {
			$(this).parent().removeClass('open');
			$(this).parent().next('.slideCon').stop().slideUp(200);
		} else {
			$(this).parent().addClass('open');
			$(this).parent().next('.slideCon').stop().slideDown(200);
		}
	});

	// 대댓글
	$(document).on('click', '.eventView_box.beauty_reply .btn_reply', function (){
		var slideOpen = $(this).hasClass('active');
		if (slideOpen) {
			$(this).removeClass('active');
			$(this).parents('.view_comment').next('.cmt_replyWrap').stop().slideUp(300);
		} else {
			$('.eventView_box.beauty_reply .btn_reply.active').removeClass('active');
			$(this).closest('.eventView_box.beauty_reply').find('.cmt_replyWrap').stop().slideUp(300);
			$(this).addClass('active');
			$(this).parents('.view_comment').next('.cmt_replyWrap').stop().slideDown(300);
		}
		return false;
	});

	//탭메뉴
	$(document).on('click', '.tabMenu a', function(){
		var tar = $(this).attr('href');
		$(this).closest('ul').find('li').removeClass('on');
		$(this).parent().addClass('on');
		$(this).closest('.tabMenu').next('.tabContents').find('.tab_con').hide();
		$(tar).show();
		return false;
	});

	//구매후기 별점부여
	$('.rating_star_large .starPoint button').on('click', function(){
		var point = $(this).index() + 1;
		$('.rating_star_large .pointBg em').text(point);
		$('.rating_star_large .pointBg').css({'left': (point * 20) + '%'});
		$('.rating_star_large .pointBg').attr('point', (point * 20));
	});

	//포토후기
	if ($('#photoUpload').size() >= 1){
		$('#photoUpload .articleArea').sortable({
			items: '.articleItem'
			,helper: 'original'
			,axis: 'y'
			,handle: '.drag_guide'
			,forceHelperSize: true
			,forcePlaceholderSize: true
			,scroll: true
			,scrollSensitivity: 230
			,scrollSpeed: 20
			,activate: function(event, ui){
				ui.helper.css('height', 150).siblings().css('opacity', 0.6);
			}
			,beforeStop: function(event, ui){ 
				ui.helper.css('height', 'auto').siblings().css('opacity', 1);
			}
		});
		$('#photoUpload .articleArea').disableSelection();
	}
	
	//셀렉트바 초기 선택 표기
	$('.selectbox').each(function(){
		var txt_value = $(this).find('.selList input[checked=checked]').next('label').text();
		if (txt_value != '') {
			$(this).find('.selList label').parents('.selectbox').find('.title').text(txt_value);
		}
	});
});

//리스트 무한스크롤
allPdtList = false;
dataReady = true;
function autoContsAtch(){
	$(window).on('scroll', function() {
		var maxHeight = $(document).height();
		var currentScroll = $(window).scrollTop() + $(window).height();
		var footHeight = $('#footer').outerHeight();
		var targetT;

		if (allPdtList){
			targetT = maxHeight - $('.recommendPdt').height() - $('.pdtListEvent').height() - footHeight;
			if (targetT <= currentScroll && dataReady) {
				dataReady = false;
				dataLoad();
			}
		} else {
			targetT = maxHeight - footHeight;
			if (targetT <= currentScroll && dataReady) {
				dataReady = false;
				dataLoad();
			}
		}
	});
};

// 제품리스트 더보기
function listBack(i){
	var i;
	var _position = $('#pdtList li').eq(i).offset().top;
	goTo(_position - 20);
};

// 제품리스트 더보기 버튼
function moreList(t){
	$(t).parent().addClass('listLoading');
	$('<img src="../../images/common/loading_small.gif" alt="로딩중" />').insertAfter(t);
	$(t).remove();
};
function listLoad(){
	$('.listLoading').html('<a href="javascript:void(0);" onclick="moreList(this);"><span class="txt">더 많은 <br />제품보기</span></a>');
};

// 버튼 bg color 상속
// var btnBgColor;
// function setBtnBG(){
// 	$('.btn_wrapBG').each(function(i){
// 		btnBgColor = $('.btn_wrapBG').eq(i).attr('data-color');
// 		console.log(btnBgColor);
// 		$('.btn_wrapBG').eq(i).find('.btnType5 .bg').css({'background-color':btnBgColor});
// 	});
// }

/* 장바구니 */
$(function(){
	var order = $('#container').hasClass('order');
	if (order && $('.aside_con').index() > 0){
		var _scrollT = $(window).scrollTop();
		var _winW = $(window).width();
		var _cartT = $('.aside_con').offset().top;
		var _posY;

		$(window).on('scroll resize', function(){
			fixQuickBar();
		});

		function fixQuickBar(){	
			_winW = $(window).width();
			_winH = $(window).height();
			_scrollT = $(window).scrollTop();
			_targetT = $('#container').height() - $('.aside_area').outerHeight();
			_posY = _scrollT - _cartT;

			if (_scrollT > _targetT) {
				$('.aside_area').addClass('max');
			} else {
				$('.aside_area').removeClass('max');
			}

			if (_scrollT > _cartT && _winW > 1240){
				$('.aside_area').addClass('fixed');
				// if (_winW < 1280) {
				// 	$('.aside_area').addClass('fixedW');
				// } else {
				// 	$('.aside_area').removeClass('fixedW');
				// }
			} else {
				$('.aside_area').removeClass('fixed fixedW max');
			}
		}
	}
});

//ul 서치박스
$(function(){
	$(document).on('click', '.selectbox .title', function(){
		if ($(this).parent('.selectbox').hasClass('disabled')) {return false;}
	
		var target = $(this).parent();
	
		if (target.hasClass('open')) {
			$(this).siblings('.selList').stop().animate({'maxHeight' : 0+'px'}, 250, 'easeOutCubic');
			setTimeout(function(){
				target.find('.selList').hide();
				target.removeClass('open');
			},250);			
		} else {
			//$('.selectbox.open .title').click();
			$(this).parent('.selectbox').addClass('open');
			$(this).siblings('.selList').show();
			$(this).siblings('.selList').stop().animate({'maxHeight' : 250+'px'}, 500, 'easeOutCubic');
		};
	});

	$(document).on('click', '.selectbox .selList label', function (){
		/*
		var disabled = $(this).prev('input').prop('disabled');
		if (disabled) {return false}
		*/

		var txt_value = $(this).text();
		var target = $(this).parents('.selectbox');
		target.find('.title').text(txt_value);
		target.find('input').removeAttr('checked');
		$(this).prev('input').attr('checked','checked');
		$(this).parents('.selList').stop(true, false).animate({'maxHeight' : 0+'px'}, 250, 'easeOutCubic');
		setTimeout(function(){
			target.removeClass('open');
			target.find('.selList').hide();
		},250);
	});

	$(document).on('mouseleave', '.selectbox', function(){
		var _target = $(this);
		_target.find('.selList').stop(true, false).animate({'maxHeight' : 0+'px'}, 250, 'easeOutCubic');
		setTimeout(function(){
			_target.removeClass('open');
			_target.find('.selList').hide();
		},250);
	});
});

//제품수량 up down 버튼
function qtyUp(num){
	if ($(num).parent('.inp_qty').hasClass('readOnly')) {return false;}
	var thisVal = parseInt($(num).parents('.inp_qty').find("input").val());
	intVal = thisVal+1;
	$(num).parents('.inp_qty').find("input").val(intVal);
}
function qtyDown(num){
	if ($(num).parent('.inp_qty').hasClass('readOnly')) {return false;}
	var thisVal = parseInt($(num).parents('.inp_qty').find("input").val());
	if(thisVal > 1){
		value = thisVal-1;
		$(num).parents('.inp_qty').find("input").val(value);
	}
}

// sns 주소복사
function copyLink() {
	var clipboard = new Clipboard('#copyCurrentFullUrl');
	clipboard.on('success', function(e) {
		showLayerAlert('주소가 복사되었습니다.<br>원하는 곳에 붙여넣기(Ctrl+V)해주세요');
		e.clearSelection();
	});
	clipboard.on('error', function(e) {
		console.error('Action:', e.action);
		console.error('Trigger:', e.trigger);
	});
}

/* layer */
var open_pos,
	winH, docH, layerH,
	hasScroll;

function showLayer(e){
	$('.mask').remove();
	$('#'+e).imagesLoaded(function() {
		layerH = $('#'+e).outerHeight();
		docH = layerH + 100;
		winH = $(window).height();
		open_pos = $(window).scrollTop();
		hasScroll = $('#' + e + ':has(.scrollarea)').length;

		if (docH > winH){
			$('body').removeClass('ofH');
			$('#'+e).addClass('layerScale');
			$('html, body').stop().animate({scrollTop : 0});
			$('#wrap').css({'height' : docH, 'overflow' : 'hidden'});
		} else {
			$('#'+e).css({'top' : '50%', 'margin-top' : -layerH/2});
			$('body').addClass('ofH');
		}

		if (hasScroll > 0) {
			$('#' + e).find('.scrollarea').mCustomScrollbar();
		}

		$('#'+e).addClass('on').stop().fadeIn(200);
		$('#wrap').append('<div class="mask"></div>');
	});
}

function resizeLayer(e){
	$('#'+e).imagesLoaded(function() {
		layerH = $('#'+e).outerHeight();
		docH = layerH + 100;
		winH = $(window).height();
		
		if (docH > winH){
			$('#'+e).addClass('layerScale');
			$('html, body').stop().animate({scrollTop : 0});
			$('#wrap').css({'height' : docH, 'overflow' : 'hidden'});
			$('body').removeClass('ofH');
		} else {
			$('#'+e).removeClass('layerScale');
			$('#'+e).css({'top' : '50%', 'margin-top' : -layerH/2});
			$('body').addClass('ofH');
		}

	});
}

function showLayerAlert(msg){
	var options  = {};
	$('.mask').remove();
	$('#layer_alert').imagesLoaded(function() {
		$('#layer_alert').find('.txt').html(msg)
		$('#layer_alert').find('.btnType2.ok').attr('onclick', 'hideLayer("layer_alert");return false;');
		layerH = $('#layer_alert').outerHeight();
		docH = layerH;
		winH = $(window).height();
		open_pos = $(window).scrollTop();

		if (docH > winH){
			$('body').removeClass('ofH');
			$('#layer_alert').addClass('layerScale');
			$('html, body').stop().animate({scrollTop : 0});
			$('#wrap').css({'height' : docH, 'overflow' : 'hidden'});
		} else {
			$('#layer_alert').css({'top' : '50%', 'margin-top' : -layerH/2});
			$('body').addClass('ofH');
		}

		$('#layer_alert').addClass('on').stop().fadeIn(200);
		$('#wrap').append('<div class="mask"></div>');
	});
	return {
        ok: function (fun) {
        	options.ok_callBack = fun;
        	$('#layer_alert').find('.btnType2.ok').unbind('click');
        	$('#layer_alert').find('.btnType2.ok').removeAttr('onclick');
        	$('#layer_alert').find('.btnType2.ok').on('click', function(){
    			if(options.ok_callBack != null)
				{
					options.ok_callBack();
				}
    			hideLayer("layer_alert");
				options.ok_callBack = null;
    			return false;
    		});
            return this;
        }
    };
}

function showLayerConfirm(msg){
	var options  = {};
	$('.mask').remove();
	$('#layer_confirm').imagesLoaded(function() {
		$('#layer_confirm').find('.txt').html(msg)
		$('#layer_alert').find('.btnType2.ok').attr('onclick', 'hideLayer("layer_confirm");return false;');
		$('#layer_alert').find('.btnType4.cancel').attr('onclick', 'hideLayer("layer_confirm");return false;');
		layerH = $('#layer_confirm').outerHeight();
		docH = layerH;
		winH = $(window).height();
		open_pos = $(window).scrollTop();
		if (docH > winH){
			$('body').removeClass('ofH');
			$('#layer_confirm').addClass('layerScale');
			$('html, body').stop().animate({scrollTop : 0});
			$('#wrap').css({'height' : docH, 'overflow' : 'hidden'});
		} else {
			$('#layer_confirm').css({'top' : '50%', 'margin-top' : -layerH/2});
			$('body').addClass('ofH');
		}
		$('#layer_confirm').addClass('on').stop().fadeIn(200);
		$('#wrap').append('<div class="mask"></div>');
	});
	
	return {
        ok: function (fun) {
        	options.ok_callBack = fun;
        	$('#layer_confirm').find('.btnType2.ok').unbind('click');
        	$('#layer_confirm').find('.btnType2.ok').removeAttr('onclick');
    		$('#layer_confirm').find('.btnType2.ok').on('click', function(){
    			if(options.ok_callBack != null)
				{
					options.ok_callBack();
				}
    			hideLayer("layer_confirm");
				options.ok_callBack = null;
    			return false;
    		});
    		return this;
        },
        cancel: function (fun) {
        	options.cancel_callBack = fun;
        	$('#layer_confirm').find('.btnType4.cancel').unbind('click');
        	$('#layer_confirm').find('.btnType4.cancel').removeAttr('onclick');
        	$('#layer_confirm').find('.btnType4.cancel').on('click', function(){
    			if(options.cancel_callBack != null)
				{
					options.cancel_callBack();
				}
    			hideLayer("layer_confirm");
				options.cancel_callBack = null;
    			return false;
    		});
        	return this;
        }
    };
};

function hideLayer(e){
	$('#'+e).removeClass('on, layerScale').hide();
	$('body').removeClass('ofH');
	$('.mask').remove();
	$('#wrap').css({'height' : '100%', 'overflow' : 'visible'});
	$('html, body').stop().animate({scrollTop : open_pos}, 50);
	if (hasScroll > 0) {
		$('#' + e).find('.scrollarea').mCustomScrollbar('destroy');
	}
}

// loading
function loading(){
	$('body').addClass('sizeS loading');
};
function loadComplete(){
	$('body').removeClass('loading');
	//setTimeout(function(){ $('body').removeClass('loading'); }, 750);
};
function loadCompleteImmediately(){
	$('body').removeClass('sizeS loading');
};
$(window).on('load', function(){
	loadComplete();
	if (main) {		
		setTimeout(function(){
			if ($('#header a.all-menu').hasClass('active')) {
				$('#header a.all-menu').click();
			}
		}, 1750);
	}
});

$(function () {
	$(document).on("click", ".infoPop .infoPop_btn", function () {
		$(this).parent('.infoPop').find('.infoPopWrap').toggle();
		return false;
	});
})
function infoPopClose(){
	$('.infoPopWrap').hide();
}

// 제품상세 - 사은품 레이어
function showGiftLayer(e){
	$('#' + e).stop().fadeIn(200);
	$('#' + e).find('.scrollarea').mCustomScrollbar();
}
function hideGiftLayer(e){
	$('#'+e).stop().fadeOut(100);
}

// SNS 주소복사
function urlCopy() {
	if( $(".urlCopy_box").css("display")=="none" ){
		$(".urlCopy_box").show(); 
		$(".sns_url a").addClass('copy'); 
	} else {
		$(".urlCopy_box").hide(); 
		$(".sns_url a").removeClass('copy'); 
	}
	//return false;
}

// 장바구니, 위시리스트 담기
function shoppingAlram(val){
	if ($('#shoppingAlram').length <= 0 && $('#wishItemDup').length <= 0){
		var alramPop = $('<div id="shoppingAlram"></div>');
		var wishDup = $('<div id="wishItemDup"></div>');
		if (val == 'C'){
			alramPop.appendTo('#wrap');
			$('#shoppingAlram').addClass('cart', function(){
				$('#shoppingAlram').animate({ opacity:1, bottom:'48%' }, 200, 'easeOutQuad', function(){
					$('#shoppingAlram').animate({ bottom:'50%' }, 200, 'easeOutQuad', function(){
						setTimeout(function(){ 
							$('#shoppingAlram').animate({ left:58, bottom:155, width:20, height:20, opacity:0.5 }, 500, 'easeInQuint', function(){
								$('#shoppingAlram').animate({ opacity:0 }, 100, function(){
									setTimeout(function(){ $('#shoppingAlram').remove(); }, 200);
								});
							});
						}, 500);
						setTimeout(function(){ $('#header .util .cart').addClass('active'); }, 1200);
					});
				});
			});
		} else if (val == 'W'){
			alramPop.appendTo('#wrap');
			$('#shoppingAlram').addClass('wish', function(){
				$('#shoppingAlram').animate({ opacity:1, bottom:'48%' }, 200, 'easeOutQuad', function(){
					$('#shoppingAlram').animate({ bottom:'50%' }, 200, 'easeOutQuad', function(){
						setTimeout(function(){ $('#shoppingAlram').animate({ bottom:'45%', opacity:0 }, 200, 'easeOutQuad'); }, 500);
					});
				});
			});
			setTimeout(function(){ $('#shoppingAlram').remove(); }, 1500);
		} else if (val == 'WD'){
			wishDup.appendTo('#wrap');
			$('#wishItemDup').animate({ opacity:1 }, 300, function(){
				setTimeout(function(){ $('#wishItemDup').animate({ opacity:0 }, 300, 'easeOutQuad'); }, 700);
			});
			setTimeout(function(){ $('#wishItemDup').remove(); }, 1500);
		};
	};
};


//이미지 중앙 크롭
//ex) imgAlign('.reviewItem .thumb');
function imgAlign(val){
	var _target = $(val);
	_target.imagesLoaded(function() {
		_target.each(function(){
			var _tgtImg = $(this).find('img');
			var _width = _tgtImg.width();
			var _height = _tgtImg.height();
			
			if (_height/_width < 1){
				if (_height/_width > _tgtImg.parent().innerHeight() / _tgtImg.parent().width()){
					_tgtImg.addClass('vAlign');
				} else {
					_tgtImg.addClass('hAlign');
				}
			} else {
				_tgtImg.addClass('vAlign');
			}
		});
	});
};

$(window).on('load', function(){
	imgAlign('.shopmain .reviewList .repImage, .photoRvRecomm .thumb, .photoRvRecomm .repImage');
});

jQuery.fn.imgCrop = function( _o ){
	return this.each(function(){
		var  o = jQuery.extend({}, _o);
		var $image = jQuery(this);
		var $tgtImg = $image.find('img');
		var $width = $tgtImg.width();
		var $height = $tgtImg.height();
		var destroy = o.destroy;

		if (!destroy){
			return false;
		} else {
			if ($height/$width < 1){
				$tgtImg.addClass('hAlign');
			} else {
				$tgtImg.addClass('vAlign');
			}
		}
	});
};


