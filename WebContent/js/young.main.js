(function($) {
	
	$.jart = $.jart || {};
	$.jart.main = $.jart.main || {};
	$.jart.main.scrn = $.jart.main.scrn || {};
	$.jart.main.bnr = $.jart.main.bnr || {};
	$.jart.main.bnr.cont = $.jart.main.bnr.cont || {};
	$.jart.main.topBnr = $.jart.main.topBnr || {};
	
	var loadScrn = 0;
	
	var searchOptions = {
		pageNumber : 1,
		rows : 4
	}
	
	$.jart.main.setIndex = function(){
		
		var $container = $('#container');
		
		$.dr.main.index().done(function(data){
			if(data.status === 200){
				var mainScrn = data.scrnList;
				var bnrReturnParams = data.bnrReturnParams;
				var bnrPagee = data.bnrPage;
				var topBnrList = data.topBnrList;
				/*console.log("topBnr == " + topBnr);
				console.log("JOSN : " + JSON.stringify(topBnr));
				console.log("evnet_list bnrPagee JOSN : " + JSON.stringify(bnrPagee));*/
				var language = data.language;
				//상단 중단 하단 화면 영역 S
				if(mainScrn){
					
					for(var i in mainScrn){
						var scrn = mainScrn[i];
						if(scrn.scrn_cd == '001'){
							$('#sec1 .secIn').html(scrn.cont);
							slickSec1();
						}else if(scrn.scrn_cd == '002'){
							$('#sec2 .secIn').html(scrn.cont);
							slickSec2();
						}else if(scrn.scrn_cd == '003'){
							$('#sec3 .secIn').html(scrn.cont);
							slickSec3();
						}
					}
					
				}else{
					$('#sec1').hide();
					$('#sec2').hide();
					$('#sec3').hide();
					$('.mainNavi li').not('li:eq(3)').remove();
				}
				//상단 중단 하단 화면 영역 E
				
				//띠배너 영역
				if(topBnrList.length > 0){
					$('#topBnr').show();
					$('#topBnr').css('background-color', topBnrList[0].topBnr_colr_no);
					var html = ""; 
					$.each(topBnrList, function (index, topBnr) {
						console.log(1);
			            html += "<div class=rollBanner>";
			            if(topBnr.url != null && topBnr.url != ""){
			            	if(topBnr.link_tp === '001'){
			            		html += "<a href='"+topBnr.url+"' target='_blank' style='color:"+topBnr.text_colr_no+"'>"+topBnr.text+"</a>";			            		
			            	}else{
			            		html += "<a href='"+topBnr.url+"' style='color:"+topBnr.text_colr_no+"'>"+topBnr.text+"</a>";
			            	}			            	
			            }else{
			            	html += "<a href='javascript:void(0)' style='color:"+topBnr.text_colr_no+"' onclick='$.jart.main.topBnr.issueCpn("+topBnr.cpn_mng_seq+")'>"+topBnr.text+"</a>";
			            }
			            html += "</div>";			
					});
					$("#topBnrList").append(html);

					$('.textBanner>div').slick({
						slidesToShow: 1,
						slidesToScroll: 1,
						speed: 500,
						autoplay: true,	
						autoplaySpeed: 3000,
						dots: false,
						vertical:true,
						verticalSwiping: true,
						prevArrow: false,
						nextArrow: false
					});					
				}
				
				//화면 하단 배너 영역 S
				if(bnrPagee.count > 0){
					$('.secEvt .event_list ul',$container).html($('#bnrContTemplate').render({
						list : bnrPagee.list
					}));
					// set paging
					// 서버로 부터 받은 전체 갯수와 현재 페이지를 이용 페이징 처리
					var pagingParam = {
						totalCount : parseInt(bnrPagee.count), // 전체 갯수
						pageNumber : parseInt(bnrPagee.pageNumber), // 현재 페이지
						listSize : parseInt(bnrPagee.rows),// 한페이지에 표시할 항목 개수
						//pageSize : parseInt($('#pages').val()), // page bar count 1 2 3 4 5 6 7 8 9 10
						functionName : '$.jart.main.bnr.cont.goToPage' // 각 페이지마다 click할 함수 이름
					};
					$.ib.paging.draw($('.secEvt .paging',$container),pagingParam);
					$('.secEvt',$container).show();
				}else{
					$('#sec4',$container).remove();
					$('.mainNavi li:eq(3)').remove();
				}
				
				if(bnrReturnParams){
					searchOptions.pageNumber = bnrReturnParams.pageNumer;
					searchOptions.rows = bnrReturnParams.rows;
					searchOptions.bnrSeq = bnrReturnParams.bnr_seq;					
				}
				//화면 하단 배너 영역 E
				
				//완료시
				if (window['YT']) {
					YT.loading = 0;
					YT.loaded = 0;
				}
				loadYT();	
				
			}else{
				$('.section').not('#sec5');//푸터를 제외한 모든 section 삭제
				$('.mainNavi li:eq(3)').remove();
			}
		});
	}
	
	
	
	$.jart.main.setPage = function(){
		$.jart.main.bnr.cont.setList();
		$.jart.main.scrn.setView();
	}
	
	$.jart.main.bnr.cont.setList = function(){
		var self = this;
		var $container = $('#container');
		searchOptions.bnrSeq = $.jart.main.bnr.bnr_seq;
		$.jart.main.bnr.cont.goToPage(1);
	};	
	
	$.jart.main.bnr.cont.goToPage = function(pageNumber){
		var self = this;
		var $container = $('#container');
		
		searchOptions.pageNumber = pageNumber;
		var bnrData = $.dr.bnr.cont.getPage(searchOptions);
	
		bnrData.done(function(bnr){
			if(bnr.status === 200 && bnr.page.count > 0){
				$('.secEvt .event_list ul',$container).html($('#bnrContTemplate').render({
					list : bnr.page.list
				}));
				// set paging
				// 서버로 부터 받은 전체 갯수와 현재 페이지를 이용 페이징 처리
				var pagingParam = {
					totalCount : parseInt(bnr.page.count), // 전체 갯수
					pageNumber : parseInt(bnr.page.pageNumber), // 현재 페이지
					listSize : parseInt(bnr.page.rows),// 한페이지에 표시할 항목 개수
					//pageSize : parseInt($('#pages').val()), // page bar count 1 2 3 4 5 6 7 8 9 10
					functionName : '$.jart.main.bnr.cont.goToPage' // 각 페이지마다 click할 함수 이름
				};
				$.ib.paging.draw($('.secEvt .paging',$container),pagingParam);
				$('.secEvt',$container).show();
			}	
		});
	}
	
	$.jart.main.scrn.setView = function(){
		var getScrnFirstData = $.dr.scrn.getView($.jart.main.scrn.cl_cd_main,$.jart.main.scrn.scrn_cd_first);
		var getScrnSecondData = $.dr.scrn.getView($.jart.main.scrn.cl_cd_main,$.jart.main.scrn.scrn_cd_second);
		var getScrnThirdData = $.dr.scrn.getView($.jart.main.scrn.cl_cd_main,$.jart.main.scrn.scrn_cd_third);
		
		getScrnFirstData.done(function(data){
			if(data.status === 200  && data.view){
				$('#sec1 .secIn').html(data.view.cont);
				loadScrn++;
				slickSec1();
			}else{
				$('#sec1').hide();
				$('.mainNavi li:eq(0)').remove();	
			}
		});
		
		getScrnSecondData.done(function(data){
			if(data.status === 200 && data.view){
				$('#sec2 .secIn').html(data.view.cont);
				loadScrn++;
				slickSec2();
			}else{
				$('#sec2').hide();
				$('.mainNavi li:eq(1)').remove();
			}
		});

		getScrnThirdData.done(function(data){
			if(data.status === 200  && data.view){
				$('#sec3 .secIn').html(data.view.cont);
				loadScrn++;
				slickSec3();
			}else{
				$('#sec3').hide();
				$('.mainNavi li:eq(2)').remove();
			}
		});
		
		$.jart.main.loadScrn();
	}
	
	$.jart.main.loadScrn = function(){
		setTimeout(function(){
			if(loadScrn == 3){
				loadYT();	
			}else{
				$.jart.main.loadScrn();			
			}
		},500);
	}
	
	$.jart.main.topBnr.issueCpn = function(cpnMngSeq){
		$.ib.loginCheck().done(function(data){
		if(data.status == "200"){
			if( data.apiLogin.authorities[0].authority == "ROLE_USER"){
				$.dr.topBnr.getCpnIssueCnt(cpnMngSeq, "001").done(function(data){
					if(data.status == "200"){
						switch(data.cnt) {
						    case 0:
						    	showLayerConfirm("쿠폰 다운로드가 완료되었습니다.")
						        break;
						    case 1:
						    	showLayerAlert("이미 다운로드 받으셨습니다.");
						        break;
						    case 2:
						    	showLayerConfirm("쿠폰 발급 제한 수를 초과했습니다.")
						        break;												    	
						    default:
						    	showLayerConfirm("시스템 오류입니다. 관리자에게 문의바랍니다.")
					        	break;
						}
					}else{
						showLayerConfirm("시스템 오류입니다. 관리자에게 문의바랍니다.")
					}
				});
				
			}else{
				showLayerConfirm("온라인 회원만 가능합니다.<br/>회원가입하시겠습니까?")
				.ok(function() {
					location.href = $.context + "/ko/cstm/joinus01";
				});
			}
		
		}else{
			showLayerConfirm("로그인이 필요 합니다. 로그인하시겠습니까?")
			.ok(function() {
				location.href = $.context + "/ko/login";
				});
			}
		});			
	}
	
})(jQuery);