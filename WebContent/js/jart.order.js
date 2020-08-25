(function($) {

	$.jart = $.jart || {};
	$.jart.ordr = $.jart.ordr || {};
	$.jart.ordr.noregsns = $.jart.ordr.noregsns || {};
	$.jart.ordr.noregsns.crt = $.jart.ordr.noregsns.crt || {};
	
	//TODO:임시
	$.jart.ordr.noregsns.crt.pntVl = 10;
	
	$.jart.ordr.noregsns.crt.prdInfos = new Map();
	$.jart.ordr.noregsns.crt.prdQtyInfos = new Map();

	$.jart.ordr.noregsns.crt.salStatCdSO = '';
	$.jart.ordr.noregsns.crt.salStatCdST = '';
	$.jart.ordr.noregsns.crt.salStatCdNA = '';
	
	//주문정보
	$.jart.ordr.noregsns.crt.crtParams = {
		ordrReqCrtSeqs : {}
		, ordrReqInfoList : []
	};
	var crtParams = $.jart.ordr.noregsns.crt.crtParams;
	
	//var crtParams = [];
	
	var $container = $('#container');
	var $sideInfoArea = $('#sideInfoArea', $container);
	var crtPrdInfo = []; 
	
	$.jart.ordr.noregsns.crt.setViewPage = function() {
		$.jart.ordr.noregsns.crt.setCrtInfo();
	};

	//장바구니 상품 리스트 셋팅
	$.jart.ordr.noregsns.crt.setCrtInfo = function() {
		var tmpSeq = '';
		$('#crtListArea', $container).empty();
		
		$.jart.common.cart.getCartList().done(function(tmpCrtInfo){
			if(tmpCrtInfo && tmpCrtInfo.length > 0) {
				var prdMngSeqs = [];
				$.each(tmpCrtInfo, function() {
					prdMngSeqs.push(this.crt.prd_mng_seq);
				});
				var param = {
					prdMngSeqs : [],
					isForNoRegSns : true
				};
				//상품정보 셋팅
				param.prdMngSeqs = prdMngSeqs;
				$.dr.prd.mng.crtPrdInfoList(JSON.stringify(param)).done(function(data) {
					if(data && data.crtPrdInfos && data.crtPrdInfos.length > 0) {

						var criteoViewBasketList = [];//크리테오 viewBasket 변수
//						var recopickBasketList = [];//레코픽 Basket 변수
						
						$.each(data.crtPrdInfos, function() {
							$.jart.ordr.noregsns.crt.prdInfos.put(this.prdMngview.prd_mng_seq, this);
						});
						
						//장바구니 상품 리스트
						//삭제할 상품 정보
						var delCrtList = [];
						
						$.each(tmpCrtInfo, function(crtIndex) {
							var criteoViewBasketItem = {};
//							var recopickBasketItem = {};
							
							var crt = this.crt;
							crt.index = crtIndex+1;
							var crtPrdList = this.crtPrdList;
							var crtRwrdprcList = this.crtRwrdprcList;
							var crtRwrdprcPrdList = this.crtRwrdprcPrdList;
							var thisPrdInfo = $.jart.ordr.noregsns.crt.prdInfos.get(crt.prd_mng_seq);
							var hasOpt = false;
							var hasRwrdprc = false;
							var thisPrdMng = thisPrdInfo.prdMngview;
							var thisPrdList = thisPrdInfo.prdList;
							var thisRwrdprcList = thisPrdInfo.rwrdprcMnglist;
							var thisRwrdprcPrdList = thisPrdInfo.rwrdprcMngPrdlist;
							if(thisPrdList.length > 1) {
								hasOpt = true;
							}
							if(typeof thisRwrdprcList != 'undefined' && thisRwrdprcList.length > 0 && thisPrdMng.rwrdprc_fl == 'Y') {
								hasRwrdprc = true;
							}
							
							//Criteo 변수 상품 ID
							criteoViewBasketItem['id'] = crt.prd_mng_seq;
							
							//Recopick 변수 상품 ID
//							recopickBasketItem['id'] = crt.prd_mng_seq;
							
							$.each(thisPrdList, function() {
								if(!$.jart.ordr.noregsns.crt.prdQtyInfos.containsKey(this.prd_seq)) {
									var tmpPsblStkQty = Number(this.stk_qty) - Number(this.sal_qty) - Number(this.safe_stk_qty);
									$.jart.ordr.noregsns.crt.prdQtyInfos.put(this.prd_seq, tmpPsblStkQty);
								}
								
								if(thisPrdMng.sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdSO){
									if(this.sal_stat_cd != $.jart.ordr.noregsns.crt.salStatCdST
										&& this.sal_stat_cd != $.jart.ordr.noregsns.crt.salStatCdSO){
										this.sal_stat_cd = $.jart.ordr.noregsns.crt.salStatCdNA;
									}else{
										//prd_mng가 일시품절 -> prd 는 판매가능인 경우 -> prd는 일시품절
										this.sal_stat_cd = $.jart.ordr.noregsns.crt.salStatCdSO;
									}
								}else if(thisPrdMng.sal_stat_cd != $.jart.ordr.noregsns.crt.salStatCdST){
									//prd_mng가 판매불가한 경우 -> prd 판매불가
									this.sal_stat_cd = $.jart.ordr.noregsns.crt.salStatCdNA;
								}else{
									//prd_mng가 판매가능이지만 prd가 판매불가한 경우 -> 판매불가
									if((this.sal_stat_cd != $.jart.ordr.noregsns.crt.salStatCdSO)
											&&(this.sal_stat_cd != $.jart.ordr.noregsns.crt.salStatCdST)){
										this.sal_stat_cd = $.jart.ordr.noregsns.crt.salStatCdNA;
									}
								}
							});
							
							//1. tr crt : prdMngInfo
							crt.hasOpt = hasOpt;
							crt.attch_url = thisPrdMng.attch_url;
							crt.prd_ko_nm = thisPrdMng.prd_ko_nm;
							var crtListHtml = $($('#crtListTemplate').render(crt));
							var crtOptListHtml;
							var crtPrdListHtml = $();
							
							var crtRwrdprcTypetHtml;
							var crtRwrdprcListHtml;
							var crtRwrdprcOptListHtml = $();
							
							thisPrdMng.hasOpt = hasOpt;
							thisPrdMng.hasRwrdprc = hasRwrdprc;
							thisPrdMng.totalEventRstcQty = 0;
							if(thisPrdMng.event_prch_fl == 'Y') {
								$.each(crtPrdList, function() {
									thisPrdMng.totalEventRstcQty += Number(this.ordr_qty);
								});
							}
							crtListHtml.data('prdMngData', thisPrdMng);
							crtListHtml.data('crtData', crt);
							
							if(thisPrdMng.tmd_flag_cnt > 0) {
								thisPrdMng.hasOpt = false;
								thisPrdMng.hasRwrdprc = false;
								crtListHtml = $($('#crtListTimeDealTemplate').render(crt));
								crtListHtml.data('prdMngData', thisPrdMng);
								crtListHtml.data('crtData', crt);
								$('#crtListArea', $container).append(crtListHtml);
								return true;
							}
							
							if(!hasOpt) {
								//1.1. 옵션 X : hidden prdInfo
								//1.1.1. 일시품절
								var psbl_stk_qty = -1;
								var tmpCriteoOrdrQty = 0;
								if(crtPrdList && crtPrdList.length > 0 && crtPrdList[0].ordr_qty) {
									psbl_stk_qty = (Number($.jart.ordr.noregsns.crt.prdQtyInfos.get(thisPrdList[0].prd_seq)) - Number(crtPrdList[0].ordr_qty));
									tmpCriteoOrdrQty = crtPrdList[0].ordr_qty;
								}
								$.jart.ordr.noregsns.crt.prdQtyInfos.put(thisPrdList[0].prd_seq, psbl_stk_qty);
								
								if((thisPrdList[0].sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdSO ||
										thisPrdList[0].sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdNA)
										|| psbl_stk_qty < 0) {
									crt.sal_stat_cd = thisPrdList[0].sal_stat_cd;
									crtListHtml = $($('#crtListSoldOutTemplate').render(crt));
									crtListHtml.data('prdMngData', thisPrdMng);
									crtListHtml.data('crtData', crt);
								}
								$.jart.ordr.noregsns.crt.prdQtyInfos.put(thisPrdList[0].prd_seq, psbl_stk_qty);
								crtPrdList[0].prd_mng_seq = thisPrdMng.prd_mng_seq;
								crtListHtml.data('crtPrdData', crtPrdList[0]);
								crtListHtml.data('prdData', thisPrdList[0]);
								crtRwrdprcTypetHtml = $($('#crtRwrdprcListType1Template').render({prd_mng_seq : crt.prd_mng_seq}));
								
								//Criteo 상품 개수
								criteoViewBasketItem['quantity'] = tmpCriteoOrdrQty;
								criteoViewBasketItem['price'] = thisPrdList[0].sal_prc;
								criteoViewBasketList.push(criteoViewBasketItem);
								crtPrdInfo = criteoViewBasketList;
								
								//Recopick 상품 개수
//								recopickBasketItem['count'] = tmpCriteoOrdrQty;
//								recopickBasketList.push(recopickBasketItem);
								
							} else {
								//1.2. 옵션 O : prdInfo
								crtRwrdprcTypetHtml = $($('#crtRwrdprcListType2Template').render({prd_mng_seq : crt.prd_mng_seq}));
								var prdListMap = new Map();
								$.each(thisPrdList, function(crtOptIndex) {
									this.index = crtOptIndex+1;
									this.prd_mng_seq = thisPrdMng.prd_mng_seq;
									prdListMap.put(this.prd_seq, this);
									var psbl_stk_qty = Number($.jart.ordr.noregsns.crt.prdQtyInfos.get(this.prd_seq));
									if(this.sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdSO || (Number(psbl_stk_qty)) < 0) {
										this.soldOutFl = true;
									}else if(this.sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdNA) {
										this.notAvailableFl = true;
									}
									crtOptListHtml = $($('#crtOptionListTemplate').render(this));
									crtOptListHtml.data('prdData', this);
									crtListHtml.find('.crtOptionListArea').append(crtOptListHtml);
									crtListHtml.find('.crtOptionList').show();
								});
								
								var totalQty = 0;
								var totalPrice = 0;
								
								//1.2.1. tr crt's crt_prd_list
								$.each(crtPrdList, function(crtPrdIndex) {
									this.index = crtPrdIndex+1;
									this.prd_mng_seq = crt.prd_mng_seq;
									var tmpThisPrd = prdListMap.get(this.prd_seq);
									var psbl_stk_qty = (Number($.jart.ordr.noregsns.crt.prdQtyInfos.get(tmpThisPrd.prd_seq)) - Number(this.ordr_qty));
									if(tmpThisPrd.sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdSO || Number(psbl_stk_qty) < 0) {
										this.soldOutFl = true;
									}else if(tmpThisPrd.sal_stat_cd == $.jart.ordr.noregsns.crt.salStatCdNA) {
										this.notAvailableFl = true;
									}
									this.prd_ko_nm = tmpThisPrd.prd_ko_nm; 
									$.jart.ordr.noregsns.crt.prdQtyInfos.put(this.prd_seq, psbl_stk_qty);
									var tmpCrtPrdListHtml = $($('#crtPrdListTemplate').render(this));
									tmpCrtPrdListHtml.data('crtPrdData', this);
									tmpCrtPrdListHtml.data('prdData', tmpThisPrd);
									tmpCrtPrdListHtml.data('prdMngData', thisPrdMng);
									crtPrdListHtml.push.apply(crtPrdListHtml, tmpCrtPrdListHtml);

									totalQty = totalQty + Number(this.ordr_qty);
									totalPrice = totalPrice + tmpThisPrd.sal_prc;
									
								});
								
								//Criteo 상품 개수
								criteoViewBasketItem['quantity'] = totalQty;
								//Criteo 상품 가격
								criteoViewBasketItem['price'] = totalPrice;
								criteoViewBasketList.push(criteoViewBasketItem);
								
								//Recopick 상품 개수
//								recopickBasketItem['count'] = totalQty;
//								recopickBasketList.push(recopickBasketItem);
								
							}
							if(hasRwrdprc) {
								$.each(thisRwrdprcList, function(rwrdprcIndex) {
									this.index = rwrdprcIndex+1;
									this.prd_mng_seq = crt.prd_mng_seq;
									crtRwrdprcListHtml = $($('#crtRwrdprcListTemplate').render(this));
									crtRwrdprcListHtml.data('rwrdprcData', this);
									var tmpRwrdprcMngSeq = this.rwrdprc_mng_seq;
									var hasRwrdprcOpt = 0;
									crtRwrdprcOptListHtml = $();
									var tmpRwrdprcPrdNm = '';
									$.each(thisRwrdprcPrdList, function(rwrdprcOptIndex) {
										if(tmpRwrdprcMngSeq == this.rwrdprc_mng_seq) {
											tmpRwrdprcPrdNm = this.prd_ko_nm;
											this.prd_mng_seq = thisPrdMng.prd_mng_seq;
											this.index = rwrdprcOptIndex+1;
											var tmpCrtRwrdprcOptListHtml = $($('#crtRwrdprcOptListTemplate').render(this));
											tmpCrtRwrdprcOptListHtml.data('rwrdprcPrdData', this);
											crtRwrdprcOptListHtml.push.apply(crtRwrdprcOptListHtml, tmpCrtRwrdprcOptListHtml);
											hasRwrdprcOpt++;
										}
										crtRwrdprcListHtml.find('#crtRwrdprcOptListArea').append(crtRwrdprcOptListHtml);
									});
									crtRwrdprcTypetHtml.find('#crtRwrdprcListArea').append(crtRwrdprcListHtml);
									if(hasRwrdprcOpt > 1) {
										crtRwrdprcListHtml.find('#crtRwrdprcOptList').attr('style', '');
										crtRwrdprcListHtml.find('.opt_prdname').remove();
									} else {
										crtRwrdprcListHtml.find('.opt_prdname').find('p').html(tmpRwrdprcPrdNm);
									}
								});
							}
							//render
							$('#crtListArea', $container).append(crtListHtml);
							if(hasOpt) {
								$('#crtListArea', $container).append(crtPrdListHtml);
							}
							if(hasRwrdprc) {
								$('#crtListArea', $container).append(crtRwrdprcTypetHtml);
								$.each($('.crtR'+crt.prd_mng_seq).find('.selectbox'), function() {
									$(this).find('li:first').find('label').trigger('click');
								});
								$.each($('.crtR'+crt.prd_mng_seq).find('.selectbox').find('li'), function() {
									var targetLi = this;
									var rwrdprcMngSeq = $(targetLi).data('rwrdprcPrdData').rwrdprc_mng_seq;
									var rwrdprcPrdSeq = $(targetLi).data('rwrdprcPrdData').prd_seq;
									var crtRwrdprcPrdSeq = 0;
									if(crtRwrdprcPrdList){
										$.each(crtRwrdprcPrdList, function() {
											var crtRwrdprcMngSeq = this.rwrdprc_mng_seq;
											var crtRwrdprcPrdSeq = this.prd_seq;
											if(crtRwrdprcMngSeq == rwrdprcMngSeq && crtRwrdprcPrdSeq == rwrdprcPrdSeq) {
												$(targetLi).find('label').trigger('click');
												return false;
											}
										});										
									}
								});
							}
							
							//1+1 수량 정보 확인							
							if(thisPrdMng.event_prch_fl != crt.event_prch_fl || thisPrdMng.event_prch_qty != crt.event_prch_qty
									|| thisPrdMng.event_prch_pmt_qty != crt.event_prch_pmt_qty || thisPrdMng.event_prch_rstc_qty != crt.event_prch_rstc_qty){
								delCrtList.push(thisPrdMng.prd_mng_seq);
							}

							// 20191129 NPAY 버튼 예외 처리
							// 패밀리 세일 NPAY 버튼 예외 처리
							if (thisPrdMng.prd_mng_seq == '21277' || thisPrdMng.prd_mng_seq == '21276' || thisPrdMng.prd_mng_seq == '21275' || thisPrdMng.prd_mng_seq == '21266' || thisPrdMng.prd_mng_seq == '21273' || thisPrdMng.prd_mng_seq == '21272' || thisPrdMng.prd_mng_seq == '21271' || thisPrdMng.prd_mng_seq == '21270' || thisPrdMng.prd_mng_seq == '21269' || thisPrdMng.prd_mng_seq == '21268' || thisPrdMng.prd_mng_seq == '21266' || thisPrdMng.prd_mng_seq == '21265' || thisPrdMng.prd_mng_seq == '21264' || thisPrdMng.prd_mng_seq == '21263' || thisPrdMng.prd_mng_seq == '21262' || thisPrdMng.prd_mng_seq == '21261' || thisPrdMng.prd_mng_seq == '21260' || thisPrdMng.prd_mng_seq == '21259' || thisPrdMng.prd_mng_seq == '21258' || thisPrdMng.prd_mng_seq == '21257' || thisPrdMng.prd_mng_seq == '21256' || thisPrdMng.prd_mng_seq == '21254' || thisPrdMng.prd_mng_seq == '21253' || thisPrdMng.prd_mng_seq == '21252' || thisPrdMng.prd_mng_seq == '21251' || thisPrdMng.prd_mng_seq == '21250' || thisPrdMng.prd_mng_seq == '21249' || thisPrdMng.prd_mng_seq == '21247' || thisPrdMng.prd_mng_seq == '21246' || thisPrdMng.prd_mng_seq == '21245' || thisPrdMng.prd_mng_seq == '21244' || thisPrdMng.prd_mng_seq == '21243' || thisPrdMng.prd_mng_seq == '21242' || thisPrdMng.prd_mng_seq == '21241' || thisPrdMng.prd_mng_seq == '21240' || thisPrdMng.prd_mng_seq == '21239' || thisPrdMng.prd_mng_seq == '21238' || thisPrdMng.prd_mng_seq == '21237' || thisPrdMng.prd_mng_seq == '21236' || thisPrdMng.prd_mng_seq == '21255' || thisPrdMng.prd_mng_seq == '21278' || thisPrdMng.prd_mng_seq == '21279' || thisPrdMng.prd_mng_seq == '21280') {
								$('.naver_pay').remove();
							}
							// 패밀리 세일 NPAY 버튼 예외 처리
							// 20191129 NPAY 버튼 예외 처리

						});
						$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
						//$('.chkAll', $container).trigger('click');
						setTimeout(function() { $('.chkAll', $container).trigger('click'); }, 1000);
						
						try{
//							Criteo 장바구니페이지 트래커
							window.criteo_q = window.criteo_q || [];
							window.criteo_q.push( 
						        { event: "setAccount", account: 30252 },
								{ event: "setHashedEmail", email: cstmMd5HashEmail },
								{ event: "setSiteType", type: "d" },
						        { event: "viewBasket", item: criteoViewBasketList}
							);	
						}catch(e){}
						
						try{
							/*Recopick 장바구니*/
//							recoPick('sendLog','basket', recopickBasketList);
						}catch(e){}		
						
						//1+1 수량정보 변경 삭제
						if(delCrtList && delCrtList.length > 0){
							showLayerAlert('1+1 이벤트 수량정보가 변경되었습니다.</br>상품을 장바구니에 다시담아 주십시요.')
							delCrtList.forEach(function(obj,idx,arr){
								$('.crtP' + obj).find('.td_btn button').trigger('click');
							})
						}
												
					} else {
						$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
					}
	        	});
			} else {
				$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
			}
			$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
			//loadComplete();
		});
	};

	//이벤트 공통 S
	//장바구니 리스트 상태 셋팅
	$.jart.ordr.noregsns.crt.setCrtDataAreaStat = function() {
		if($('#crtListArea', $container).find('tr').length > 0) {
			$('#noCrtData', $container).hide();
			$('#crtDataArea', $container).show();
			$('#crtDelBtns', $container).show();
		} else {
			$('#noCrtData', $container).show();
			$('#crtDataArea', $container).hide();
			$('#crtDelBtns', $container).hide();
		}
	};
	
	$.jart.ordr.noregsns.crt.setOrdrPrcInfo = function() {
		//Google Analytics 필요데이터
		var productList = [];
		//1. 전체 장바구니 금액 재계산 + 사은품 수량 변경
		$.each($('tr[class^=crtP]', $('#crtListArea')), function() { 
			var prdMngData = $(this).data('prdMngData');
			var crtData = $(this).data('crtData');
			crtData.totlSalPrc = 0;
			crtData.totlDcSalPrc = 0;
			crtData.ordrQty = 0;
			crtData.eventPrdQty = 0;
			//Google Analytics 필요데이터
			var gaData = {};
			gaData['id'] = String(prdMngData.prd_mng_seq);
			gaData['name'] = prdMngData.prd_ko_nm;
			gaData['category'] = prdMngData.full_cat_ko_nm.split('>')[prdMngData.full_cat_ko_nm.split('>').length-1];
			gaData['variant'] = [];
			//Google Analytics
			if(!prdMngData.hasOpt) {
				//1.1. 옵션 X
				var prdData = $(this).data('prdData');
				var crtPrdData = $(this).data('crtPrdData');
				var ordrQty = Number(crtPrdData.ordr_qty) - Number(crtPrdData.event_prd_qty);
				var salPrc = prdData.stdprc_prc * ordrQty;
				var dcFl = prdData.dc_fl;
				var dcSalPrc = prdData.sal_prc * ordrQty;
				crtData.totlSalPrc += salPrc;
				crtData.ordrQty = Number(crtData.ordrQty) + Number(crtPrdData.ordr_qty);
				crtData.eventPrdQty += crtPrdData.event_prd_qty;
				crtData.dcFl = dcFl;
				if(salPrc != dcSalPrc) {
					crtData.totlDcSalPrc += dcSalPrc;
				} else {
					crtData.totlDcSalPrc += salPrc;
				}
				$(this).find('.td_qty').find('.crtQty').val(crtData.ordrQty);
				$('tr[class^=crtR'+crtData.prd_mng_seq+']', $('#crtListArea')).find('.opt_qty').html(crtData.ordrQty - crtData.eventPrdQty);
			} else {
				//1.2. 옵션 O
				$.each($('tr[class^=crtC'+crtData.prd_mng_seq+']', $('#crtListArea')), function() {
					var prdData = $(this).data('prdData');
					var crtPrdData = $(this).data('crtPrdData');
					var ordrQty = Number(crtPrdData.ordr_qty) - Number(crtPrdData.event_prd_qty);
					var salPrc = prdData.stdprc_prc * ordrQty;
					var dcFl = prdData.dc_fl;
					var dcSalPrc = prdData.sal_prc * ordrQty;
					crtData.totlSalPrc += salPrc;
					crtData.ordrQty = Number(crtData.ordrQty) + Number(crtPrdData.ordr_qty);
					crtData.eventPrdQty += crtPrdData.event_prd_qty;
					crtData.dcFl = dcFl;
					if(salPrc != dcSalPrc) {
						crtData.totlDcSalPrc += dcSalPrc;
						if(dcSalPrc == 0) {
							$(this).find('.cost').html('0');
						} else {
							$(this).find('.cost').html($.ib.addComma(dcSalPrc));
						}
					} else {
						crtData.totlDcSalPrc += salPrc;
						$(this).find('.cost').html($.ib.addComma(salPrc));
					}
					//Google Analytics 장바구니보기
					gaData.variant.push(prdData.prd_ko_nm);
				});
				$(this).find('.td_qty').html(crtData.ordrQty);
				$('tr[class^=crtR'+crtData.prd_mng_seq+']', $('#crtListArea')).find('.opt_qty').html(crtData.ordrQty - crtData.eventPrdQty);
			}
			//2. 구매 사은품 셋팅
			if(prdMngData.hasRwrdprc) {
				crtData.rwrdprc = [];
				crtData.rwrdprcPrd = [];
				$.each($('.liR'+crtData.prd_mng_seq, $('#crtListArea')), function() {
					var rwrdprcData = $(this).data('rwrdprcData');
					var rwrdprcPrdData = $(this).find('.liRP'+rwrdprcData.rwrdprc_mng_seq).find('input[checked=checked]').parents('li:first').data('rwrdprcPrdData');
					if(rwrdprcPrdData) {
						rwrdprcData.prd_seq = rwrdprcPrdData.prd_seq;
						
					}
				});
			}
			//3. 상품 금액 표시
			var crtPrcHtml = '';
			if(crtData.totlDcSalPrc != crtData.totlSalPrc) {
				crtPrcHtml += '<span class="normal">'+$.ib.addComma(crtData.totlSalPrc)+'</span>';
				crtPrcHtml += $.ib.addComma(crtData.totlDcSalPrc);
			} else {
				crtPrcHtml += $.ib.addComma(crtData.totlSalPrc);
			}
			$(this).find('.td_price').find('.cost').html(crtPrcHtml);
			//Google Analytics 장바구니보기
			gaData['price'] = String(prdMngData.sal_prc);
			gaData['quantity'] = crtData.ordrQty;
			
			//AceCounter 에이스 카운트 장바구니 상세 + 다음 검색광고 & 다음 DDN 리타겟팅 코드  S
			try{
				//에이스 카운트
				_A_amt.push(String(crtData.totlDcSalPrc));	//제품소계
				_A_nl.push(String(gaData.quantity));	//제품수량
				_A_pn.push(gaData.name);	//제품명
				_A_pl.push(gaData.id);	//제품ID
				_A_ct.push(gaData.category); //제품카테고리
				//다음 DDN
				roosevelt_params.bag[0].item.push(
					{id : gaData.id,
					price : gaData.price,
					ea : String(gaData.quantity)}
				);	
				//Google Analytics 장바구니보기
				(prdMngData.hasOpt) || delete gaData.variant;
				productList.push(gaData);
			}catch(e){}
			//AceCounter 에이스 카운트 장바구니 상세 + 다음 검색광고 & 다음 DDN 리타겟팅 코드  E	
		});
		//Google Analytics 장바구니보기 S
		try{
			dataLayer.push({
				'event':'checkout',
				'ecommerce':{
					'checkout':{
						'actionField':{'step':1,'option':'cartView'},
						'products': productList
					}
				}
			});
		}catch(e){}
		//Google Analytics 장바구니보기 E
		
		$.each($('tr[class^=tr_soldout]', $('#crtListArea')), function() {
			var prdMngData = $(this).data('prdMngData');
			if(prdMngData.tmd_flag_cnt > 0) {
				return true;
			}
			if(prdMngData && !prdMngData.hasOpt) {
				//1.1. 옵션 X
				var crtData = $(this).data('crtData');
				crtData.totlSalPrc = 0;
				crtData.totlDcSalPrc = 0;
				crtData.ordrQty = 0;
				crtData.eventPrdQty = 0;
				var prdData = $(this).data('prdData');
				var crtPrdData = $(this).data('crtPrdData');
				if(crtPrdData) {
					var ordrQty = crtPrdData.ordr_qty - crtPrdData.event_prd_qty;
					var salPrc = prdData.stdprc_prc * ordrQty;
					var dcFl = prdData.dc_fl;
					var dcSalPrc = prdData.sal_prc * ordrQty;
					crtData.totlSalPrc += salPrc;
					crtData.ordrQty += crtPrdData.ordr_qty;
					crtData.eventPrdQty += crtPrdData.event_prd_qty;
					if(salPrc != dcSalPrc) {
						crtData.totlDcSalPrc += dcSalPrc;
					} else {
						crtData.totlDcSalPrc += salPrc;
					}
				} else {
					return true;
				}
			} else {
				//1.2. 옵션 O
				var prdData = $(this).data('prdData');
				var crtPrdData = $(this).data('crtPrdData');
				if(crtPrdData) {
					var crtData = {};
					crtData.totlSalPrc = 0;
					crtData.totlDcSalPrc = 0;
					crtData.ordrQty = 0;
					crtData.eventPrdQty = 0;
					var ordrQty = 1;
					var salPrc = prdData.stdprc_prc * ordrQty;
					var dcFl = prdData.dc_fl;
					var dcSalPrc = prdData.sal_prc * ordrQty;
					crtData.totlSalPrc += salPrc;
					crtData.ordrQty += 1;
					crtData.eventPrdQty += 0;
					if(salPrc != dcSalPrc) {
						crtData.totlDcSalPrc += dcSalPrc;
						$(this).find('.cost').html($.ib.addComma(dcSalPrc));
					} else {
						crtData.totlDcSalPrc += salPrc;
						$(this).find('.cost').html($.ib.addComma(salPrc));
					}
				} else {
					return true;
				}
			}
			var crtPrcHtml = '';
			if(crtData.totlDcSalPrc != crtData.totlSalPrc) {
				crtPrcHtml += '<span class="normal">'+$.ib.addComma(crtData.totlSalPrc)+'</span>';
				crtPrcHtml += $.ib.addComma(crtData.totlDcSalPrc);
			} else {
				crtPrcHtml += $.ib.addComma(crtData.totlSalPrc);
			}
			$(this).find('.td_price').find('.cost').html(crtPrcHtml);
		});
		$.jart.ordr.noregsns.crt.setFinalOrdrPrcInfo();
	};
	
	//최종 주문금액 계산
	$.jart.ordr.noregsns.crt.setFinalOrdrPrcInfo = function() {
		$('#totlPrdSellPrc', $sideInfoArea).html('0');
		$('#totlSalePrc', $sideInfoArea).html('0');
		$('#finalSttlPrc', $sideInfoArea).html('0');
		$('#paymentPoint', $sideInfoArea).html('0');
		var totlPrdSellPrc = 0;
		var totlSalePrc = 0;
		var finalSttlPrc = 0;
		var paymentPoint = 0;
		var calcCrtPrds = [];
		$.each($('input[name=selCrtCb]:checked', $container), function() {
			var targetTr = $(this).parents('tr:first');
			var prdMngData = $(targetTr).data('prdMngData');
			var crtData = $(targetTr).data('crtData');
			calcCrtPrds.push(crtData.prd_mng_seq);
			totlPrdSellPrc += crtData.totlSalPrc;
			if(crtData.totlSalPrc != crtData.totlDcSalPrc) {
				finalSttlPrc += crtData.totlDcSalPrc;
			} else {
				finalSttlPrc += crtData.totlSalPrc;
			}
		});
		totlSalePrc = (totlPrdSellPrc - finalSttlPrc);
		paymentPoint =(finalSttlPrc*$.jart.ordr.noregsns.crt.pntVl/100)
		$('#totlPrdSellPrc', $sideInfoArea).html($.ib.addComma(totlPrdSellPrc));
		$('#totlSalePrc', $sideInfoArea).html($.ib.addComma(totlSalePrc*-1));
		$('#finalSttlPrc', $sideInfoArea).html($.ib.addComma(finalSttlPrc));
		$('#paymentPoint', $sideInfoArea).html('+'+$.ib.addComma(paymentPoint));
		crtParams.ordrReqCrtSeqs = calcCrtPrds;
		$.jart.ordr.noregsns.crt.selCrtsBtnPass();
	};
	
	//주문하기 유효성 체크
	$.jart.ordr.noregsns.crt.selCrtsBtnPass = function() {
		var naverPayEnable = "Y";
		var createNaverPay = false;
		if(crtParams.ordrReqCrtSeqs.length > 0) {
			if($('#ordrBtn', $sideInfoArea).hasClass('disabled')){
				createNaverPay = true;
				$('#naverPayElement').children('div').remove();
			}
			$('#ordrBtn', $sideInfoArea).removeClass('disabled');
		} else {
			naverPayEnable = "N";
			if(!$('#ordrBtn', $sideInfoArea).hasClass('disabled')){
				createNaverPay = true;
				$('#naverPayElement').children('div').remove();
			}
			$('#ordrBtn', $sideInfoArea).addClass('disabled');
		}
		
		if(!createNaverPay && $('#naverPayElement').find('div').length === 0){
			createNaverPay = true;
		}
		
		//네이버 페이
		if($('#naverPayElement').length > 0 && createNaverPay){
			naver.NaverPayButton.apply({
				BUTTON_KEY: "9F32A604-6FB7-4701-9A9A-E0D11BD78856",
				TYPE : "C", // 버튼 모음 종류 설정
				COLOR : 1, // 버튼 모음의 색 설정
				COUNT : 1, // 버튼 개수 설정. 구매하기 버튼만 있으면 1, 찜하기 버튼도 있으면 2를 입력.
				ENABLE: naverPayEnable, // 품절 등의 이유로 버튼 모음을 비활성화할 때에는 "N" 입력
				BUY_BUTTON_HANDLER : buy_nc,
				//BUY_BUTTON_LINK_URL : $.context + "/api/ep/naverpay/order", // 링크 주소 (필요한 경우만 사용) 
				//WISHLIST_BUTTON_HANDLER:wishlist_nc,
				EMBED_ID: "naverPayElement",
				//WISHLIST_BUTTON_LINK_URL:"/shop/common/NpayZZimAPI.asp", // 찜하기 팝업
				"":""
			});
		}
	}
	
	// 20191126
	$.jart.ordr.noregsns.crt.npayBtnAction = function() {
		window.criteo_q = window.criteo_q || [];
		console.log(crtPrdInfo);
		window.criteo_q.push(
			{ event: "setAccount", account: 30252 },
			{ event: "setHashedEmail", email: cstmMd5HashEmail },
			{ event: "setSiteType", type: "d" },
			{
				event: "trackTransaction", id: "npay" + Math.floor(Math.random()*999999), 
				item: crtPrdInfo
			}
		);
	};
	// 20191126
	
	$.jart.ordr.noregsns.crt.addEvent = function() {
		//전체 상품 선택
		$container.on('click', '.chkAll', function() {
			var chk = $(this).closest('.inp_check').hasClass('checked');
			
			$.each($('.selCrtCb', $container), function() {
				if ($(this).parent().hasClass('readOnly')){return true;}
				if ($(this).parent().hasClass('disabled')){return true;}
				var tar = $(this).parent().find('input');
				if(!chk) {
					$(this).parent().addClass('checked');
					tar.prop("checked",true);
				} else {
					$(this).parent().removeClass('checked');
					tar.prop("checked",false);
				}
			});
			$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
		});
		
		//상품 선택
		$container.on('click', '.selCrtCb', function() {
			if(!$(this).parent().find('input').prop('checked')) {
				$(this).parent().find('input').prop('checked', true);
			} else {
				$(this).parent().find('input').prop('checked', false);
			}
			
			var count = 0;
			$.each($('.selCrtCb', $container), function() {
				if($(this).parent().find('input').prop('checked') == true){
					count ++ ;
				}
			});
			
			if(count == $('.selCrtCb').parent().find('input').length){
				$('.chkAll').closest('.inp_check').addClass('checked');
			}else{
				$('.chkAll').closest('.inp_check').removeClass('checked');
			}
			
			$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
		});
		
		//옵션 선택
		$container.on('click', '.crtOptionListArea > li > label', function() {
			var $thisLi = $(this);
			var $crtTr = $(this).parents('tr:first');
			var prdMngData = $crtTr.data('prdMngData');
			var prdData = $(this).parent().data('prdData');
			if(prdData.soldOutFl) {
				showLayerAlert('일시품절된 상품입니다.')
				.ok(function() {
					var target = $thisLi.parents('.selectbox');
					target.find('.title').text('추가 옵션 선택');
					target.find('input').removeAttr('checked');
					$(this).parents('.selList').stop(true, false).animate({'maxHeight' : 0+'px'}, 250, 'easeOutCubic');
					setTimeout(function(){
						target.removeClass('open');
						target.find('.selList').hide();
					},250);
					return false;
				});
			}else if(prdData.notAvailableFl) {
				showLayerAlert('판매불가 상품입니다.')
				.ok(function() {
					var target = $thisLi.parents('.selectbox');
					target.find('.title').text('추가 옵션 선택');
					target.find('input').removeAttr('checked');
					$(this).parents('.selList').stop(true, false).animate({'maxHeight' : 0+'px'}, 250, 'easeOutCubic');
					setTimeout(function(){
						target.removeClass('open');
						target.find('.selList').hide();
					},250);
					return false;
				});
			}else {
				var crtData = $crtTr.data('crtData');
				var crtPrdData = {};
				var prdData = $(this).parent().data('prdData');
				// 이미 선택 확인
				var aldFl = false;
				$.each($('tr[class^=crtC'+crtData.prd_mng_seq+']', $('#crtListArea')), function() {
					if(prdData.prd_seq == $(this).data('prdData').prd_seq) {
						aldFl = true;
						return false;
					}
				});
				var target = $(this).parents('.selectbox');
				target.find('.title').text('추가 옵션 선택');
				target.find('input').removeAttr('checked');
				$(this).prev('input').attr('checked','checked');
				$(this).parents('.selList').stop(true, false).animate({'maxHeight' : 0+'px'}, 250, 'easeOutCubic');
				setTimeout(function(){
					target.removeClass('open');
					target.find('.selList').hide();
				},250);
				if(aldFl) {
					return false;
				}
				//1. crtPrdData setting
				crtPrdData.prd_mng_seq = crtData.prd_mng_seq;
				crtPrdData.prd_seq = prdData.prd_seq;
				crtPrdData.prd_ko_nm = prdData.prd_ko_nm;
				crtPrdData.ordr_qty = 1;
				crtPrdData.event_prd_qty = 0;
				if(prdMngData.event_prch_fl === 'Y' && 1 <= prdMngData.event_prch_rstc_qty 
					&& prdMngData.event_prch_qty == 1 && prdMngData.event_prch_pmt_qty > 0){
						for(var i = 0; i < prdMngData.event_prch_pmt_qty; i++){
							crtPrdData.event_prd_qty++
						}
				}
				crtPrdData.ordr_qty += crtPrdData.event_prd_qty;
				var psblStkQty = (Number($.jart.ordr.noregsns.crt.prdQtyInfos.get(crtPrdData.prd_seq))-Number(crtPrdData.ordr_qty));
				if(psblStkQty < 0) {
					showLayerAlert('재고가 부족합니다.');
					return false;
				} else if(prdMngData.event_prch_fl === 'Y' && (prdMngData.totalEventRstcQty + crtPrdData.ordr_qty) > prdMngData.event_prch_rstc_qty) {
					showLayerAlert('1회 최대 ' + prdMngData.event_prch_rstc_qty + '개 구매 가능합니다.');
					return false;
				}
				prdMngData.totalEventRstcQty += crtPrdData.ordr_qty;
				$.jart.ordr.noregsns.crt.prdQtyInfos.put(crtPrdData.prd_seq, psblStkQty);
				var crtPrdListHtml = $($('#crtPrdListTemplate').render(crtPrdData));
				crtPrdListHtml.data('crtPrdData', crtPrdData);
				crtPrdListHtml.data('prdData', prdData);
				
				//2. add this crtC's last
				if($('tr[class^=crtC'+crtData.prd_mng_seq+']').length > 0) {
					$('tr[class^=crtC'+crtData.prd_mng_seq+']:last', $('#crtListArea')).after(crtPrdListHtml);
				} else {
					$('tr[class^=crtP'+crtData.prd_mng_seq+']', $('#crtListArea')).after(crtPrdListHtml);
				}
				$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
				return false;
			}
		});
		
		//수량변동
		$container.on('click', '.inp_qty > button', function() {
			var $crtTr = $(this).parents('tr:first');
			var prdData = $crtTr.data('prdData');
			var crtPrdData = $crtTr.data('crtPrdData');
			var prdMngData = $('.crtP'+crtPrdData.prd_mng_seq).data('prdMngData');
			var isUp = $(this).hasClass('qtyUp');
			var tmpPsblStkQty = Number($.jart.ordr.noregsns.crt.prdQtyInfos.get(prdData.prd_seq));
			if(isUp) {
				var psblStkQty = Number($.jart.ordr.noregsns.crt.prdQtyInfos.get(prdData.prd_seq)) - 1;
				if(prdMngData.event_prch_fl === 'Y'){
					psblStkQty -= (Number(prdMngData.event_prch_pmt_qty));
					if(psblStkQty < 0) {
						showLayerAlert('재고가 부족합니다.');
						return false;
					} else {
						var chkTmpOrdrQty = crtPrdData.ordr_qty;
						var chkTmpRstcQty = 0;
						if((((crtPrdData.ordr_qty - crtPrdData.event_prd_qty) + 1) % prdMngData.event_prch_qty) === 0) {
							for(var i = 0; i < prdMngData.event_prch_pmt_qty; i++){
								chkTmpOrdrQty += 1;
								chkTmpRstcQty += 1;
							}
						}
						chkTmpOrdrQty += 1;
						chkTmpRstcQty += 1;
						if(((chkTmpOrdrQty) > prdMngData.event_prch_rstc_qty) || ((prdMngData.totalEventRstcQty + chkTmpRstcQty) > prdMngData.event_prch_rstc_qty)) {
							showLayerAlert('1회 최대 ' + prdMngData.event_prch_rstc_qty + '개 구매 가능합니다.');
							return false;
						} else if((((crtPrdData.ordr_qty - crtPrdData.event_prd_qty) + 1) % prdMngData.event_prch_qty) === 0) {
							for(var i = 0; i < prdMngData.event_prch_pmt_qty; i++){
								qtyUp(this);
								crtPrdData.ordr_qty += 1;
								crtPrdData.event_prd_qty += 1;
								tmpPsblStkQty -= 1;

								prdMngData.totalEventRstcQty += 1;
							}
						}
						qtyUp(this);
						crtPrdData.ordr_qty += 1;
						tmpPsblStkQty -= 1;
						
						prdMngData.totalEventRstcQty += 1;
					}
				} else if(prdData.max_prch_dd_qty > 0) {
					if(psblStkQty < 0) {
						showLayerAlert('재고가 부족합니다.');
						return false;
					}
					//상품당 최대구매수량	
					if(Number(crtPrdData.ordr_qty) < prdData.max_prch_dd_qty){
						qtyUp(this);
						crtPrdData.ordr_qty += 1;
						tmpPsblStkQty -= 1;
					} else {
						showLayerAlert('1회 최대 ' + prdData.max_prch_dd_qty + '개 구매 가능합니다.');	
					}
				} else {
					if(psblStkQty < 0) {
						showLayerAlert('재고가 부족합니다.');
						return false;
					}
					//일반(최대구매수량 없음)
					qtyUp(this);
					crtPrdData.ordr_qty += 1;
					tmpPsblStkQty -= 1;
				}
			} else {
				if((Number(crtPrdData.ordr_qty) - Number(crtPrdData.event_prd_qty)) > 1){
					if(prdMngData.event_prch_fl === 'Y' 
						&& ((Number(crtPrdData.ordr_qty) - Number(crtPrdData.event_prd_qty)) % prdMngData.event_prch_qty) === 0 ){
						for(var i = 0; i < prdMngData.event_prch_pmt_qty; i++){
							qtyDown(this);
							crtPrdData.ordr_qty = Number(crtPrdData.ordr_qty) - 1;
							crtPrdData.event_prd_qty = crtPrdData.event_prd_qty - 1;
							tmpPsblStkQty += 1;
							
							prdMngData.totalEventRstcQty -= 1;
						}
					}
					qtyDown(this);	
					crtPrdData.ordr_qty = Number(crtPrdData.ordr_qty) - 1;
					tmpPsblStkQty += 1;
					
					prdMngData.totalEventRstcQty -= 1;
				}
			}
			$.jart.ordr.noregsns.crt.prdQtyInfos.put(prdData.prd_seq, tmpPsblStkQty);
			$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
		});
		
		//사은품 변경
		$container.on('click', 'li[class^=liRP] > label', function() {
			var targetLi = $(this).parents('li:first');
			var rwrdprcPrdData = targetLi.data('rwrdprcPrdData');
			$(targetLi).parents('li:first').data('rwrdprcData').prd_seq = targetLi.data('rwrdprcPrdData').prd_seq;
			$(targetLi).parents('li:first').data('rwrdprcData').erp_no = targetLi.data('rwrdprcPrdData').erp_no;
		});
		
		//옵션 삭제
		$container.on('click', '.delCrtPrdBtn', function() {
			var targetTr = $(this).parents('tr:first');
			var tmpCrtPrdSeq = $(targetTr).data('crtPrdData').crt_prd_seq;

			//Google Analytics 장바구니 삭제 필요 데이터
			var prdMngSeq = $(targetTr).data('crtPrdData').prd_mng_seq;
			var crtPCrtData = $('.crtP'+prdMngSeq).data('crtData');
			var crtPPrdData = $('.crtP'+prdMngSeq).data('prdMngData');
			var crtCData = $('.crtC'+prdMngSeq).data('crtPrdData');
			crtPPrdData.totalEventRstcQty -= Number($(targetTr).data('crtPrdData').ordr_qty);
			var delCartFl = false;
			//Google Analytics 장바구니 삭제 필요 데이터
			if(tmpCrtPrdSeq && tmpCrtPrdSeq > 0) {
				var psblStkQty = (Number($.jart.ordr.noregsns.crt.prdQtyInfos.get($(targetTr).data('crtPrdData').prd_seq))+Number($(targetTr).data('crtPrdData').ordr_qty));
				$.jart.ordr.noregsns.crt.prdQtyInfos.put($(targetTr).data('crtPrdData').prd_seq, psblStkQty);
				if(tmpCrtPrdSeq > 0) {
					$.dr.crt.prd.delete(JSON.stringify({crtPrdSeq : tmpCrtPrdSeq})).done(function(data) {
						if(data.status == '200') {
							$(targetTr).remove();
							$.jart.common.cart.getCartList().done(function(data){
								if(data && data.length > 0) {
									$('#hCartCnt').html(data.length);
									$('#hCartCnt').closest('.cart').addClass('active');
								} else {
									$('#hCartCnt').html('');
									$('#hCartCnt').closest('.cart').removeClass('active');
								}
								//AceCounter + Google Analytics
								delCartFl = true;
								afterDelCart(delCartFl);
							});
						} else {
							showLayerAlert('잘못된 요청입니다.')
							.ok(function() {
								location.reload();
							});
						}
						$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
					});
				} else {
					$(targetTr).remove();
					$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
				}
			} else {
				var thisPrdData = $(targetTr).data('prdData');
				$.jart.common.cart.removeStorage(thisPrdData.prd_mng_seq, thisPrdData.prd_seq);
				$(targetTr).remove();
				$.jart.common.cart.getCartList().done(function(data){
					if(data && data.length > 0) {
						$('#hCartCnt').html(data.length);
						$('#hCartCnt').closest('.cart').addClass('active');
					} else {
						$('#hCartCnt').html('');
						$('#hCartCnt').closest('.cart').removeClass('active');
					}
					//AceCounter + Google Analytics
					delCartFl = true;
					afterDelCart(delCartFl);
				});
				$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
			}
			//AceCounter 에이스 카운트 장바구니 삭제 (옵션삭제) + Google Analytics 장바구니 삭제 S
			function afterDelCart(delCartFl){
				try{
					if(delCartFl){
						//AceCounter 
						AEC_F_D(String(prdMngSeq),'o',crtCData.ordr_qty);
						//Google Analytics
						dataLayer.push({
							'event':'removeFromCart',
							'ecommerce':{
								'remove':{
									'products': [{
										'name' : crtPCrtData.prd_ko_nm,
										'id' : String(prdMngSeq),
										'price' : String(crtPPrdData.sal_prc),
										'category' : crtPPrdData.full_cat_ko_nm.split('>')[crtPPrdData.full_cat_ko_nm.split('>').length-1],
										'variant' : crtCData.prd_ko_nm,
										'quantity' : crtCData.ordr_qty
									}]	
								}
							}
						});
					}
				}catch(e){}
			}
			//AceCounter 에이스 카운트 장바구니 삭제 (옵션삭제) + Google Analytics 장바구니 삭제  E
		});
		
		//상품 삭제
		$container.on('click', '.delCrtBtn', function() {
			var tmpSeq = $(this).parents('tr:first').data('crtData').crt_seq;
			var tmpPrdMngSeq = $(this).parents('tr:first').data('crtData').prd_mng_seq;
			//AceCounter + Google Analytics
			var crtData = $(this).parents('tr:first').data('crtData');
			var variant = [];
			$.each($('#crtListArea').find($('.crtC'+tmpPrdMngSeq)), function() {
				variant.push($(this).data('crtPrdData').prd_ko_nm);
			});
			var delCartFl = false;
			//AceCounter + Google Analytics
			if(tmpSeq && tmpSeq > 0) {
				var crtSeqs = [];
				crtSeqs.push(tmpSeq);
				if(crtSeqs.length > 0) {
					$.dr.crt.delete(JSON.stringify({crtSeqs : crtSeqs})).done(function(data) {
						if(data.status == '200') {
							$('.crtP'+tmpPrdMngSeq).remove(); 
							$('.crtC'+tmpPrdMngSeq).remove();
							$('.crtR'+tmpPrdMngSeq).remove();
							$.jart.common.cart.getCartList().done(function(data){
								if(data && data.length > 0) {
									$('#hCartCnt').html(data.length);
									$('#hCartCnt').closest('.cart').addClass('active');
								} else {
									$('#hCartCnt').html('');
									$('#hCartCnt').closest('.cart').removeClass('active');
								}
								//AceCounter + Google Analytics
								delCartFl = true;
								afterDelCart(delCartFl);
							});
							$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
						} else {
							showLayerAlert('잘못된 요청입니다.')
							.ok(function() {
								location.reload();
							});
						}
						$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
					});
				}
			} else {
				$.jart.common.cart.removeStorage(tmpPrdMngSeq);
				$('.crtP'+tmpPrdMngSeq).remove(); 
				$('.crtC'+tmpPrdMngSeq).remove();
				$('.crtR'+tmpPrdMngSeq).remove();
				$.jart.common.cart.getCartList().done(function(data){
					if(data && data.length > 0) {
						$('#hCartCnt').html(data.length);
						$('#hCartCnt').closest('.cart').addClass('active');
					} else {
						$('#hCartCnt').html('');
						$('#hCartCnt').closest('.cart').removeClass('active');
					}
					//AceCounter + Google Analytics
					delCartFl = true;
					afterDelCart(delCartFl);
				});
				$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
				$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
			}
			//AceCounter 에이스 카운트 장바구니 삭제 (상품삭제) + Google Analytics 장바구니 삭제 S
			function afterDelCart(delCartFl){
				try{
					if(delCartFl){
						var thisPrdMngSeq = String(crtData.prd_mng_seq);
						var thisOrdrQty = crtData.ordrQty;
						var price = (crtData.totlDcSalPrc) ? crtData.totlDcSalPrc : crtData.totlSalPrc;
						if(thisOrdrQty && price){
							price = String(Math.floor(price / thisOrdrQty));
						}
						//AceCounter 
						AEC_F_D(thisPrdMngSeq,'o',thisOrdrQty);//스트링 인트
						//Google Analytics
						dataLayer.push({
							'event':'removeFromCart',
							'ecommerce':{
								'remove':{
									'products': [{
										'name' : crtData.prd_ko_nm,
										'id' : thisPrdMngSeq,
										'price' : price,
										'variant' : (variant) ? variant : '',
										'quantity' : thisOrdrQty
									}]	
								}
							}
						});
					}
				}catch(e){}
			}
			//AceCounter 에이스 카운트 장바구니 삭제 (상품삭제) + Google Analytics 장바구니 삭제 E
		});
		
		//선택상품 삭제
		$container.on('click', '#selCrtDel', function() {
			var crtSeqs = [];
			var tmpSnsFl = true;
			//에이스 카운트 + Google Analytics 필요 데이터
			var productList = [];
			var delCartFl = false;
			$.each($('input[name=selCrtCb]:checked', $container), function() {
				var thisCrtSeq = $(this).parents('tr:first').data('crtData').crt_seq;
				
				if(thisCrtSeq && thisCrtSeq > 0) {
					crtSeqs.push(thisCrtSeq);
					//에이스 카운트 + Google Analytics 필요 데이터 S
					var gaData = {};
					var thisCrtData = $(this).parents('tr:first').data('crtData');
					var thisOrdrQty = thisCrtData.ordrQty;
					var price = (thisCrtData.totlDcSalPrc) ? thisCrtData.totlDcSalPrc : thisCrtData.totlSalPrc;
					if(thisOrdrQty && price){
						price = Math.floor(price / thisOrdrQty);
					}
					gaData['name'] = thisCrtData.prd_ko_nm;
					gaData['id'] = String(thisCrtData.prd_mng_seq);
					gaData['price'] = String(price);
					gaData['quantity'] = thisOrdrQty;
					if(thisCrtData.hasOpt){
						gaData['variant'] = [];
						$.each($('#crtListArea').find($('.crtC'+thisCrtSeq)), function() {
							($(this).data('crtPrdData').prd_ko_nm) && gaData.variant.push($(this).data('crtPrdData').prd_ko_nm);
						});
					}
					productList.push(gaData);
					//에이스 카운트 + Google Analytics 필요 데이터 E
				} else {
					tmpSnsFl = false;
					return false;
				}
			});
			if(tmpSnsFl && crtSeqs.length > 0) {
				$.dr.crt.delete(JSON.stringify({crtSeqs : crtSeqs})).done(function(data) {
					if(data.status == '200') {
						$.each($('input[name=selCrtCb]:checked', $container), function() {
							var tmpSeq = $(this).parents('tr:first').data('crtData').prd_mng_seq;
							$('.crtP'+tmpSeq).remove(); 
							$('.crtC'+tmpSeq).remove();
							$('.crtR'+tmpSeq).remove();
						});
						$.jart.common.cart.getCartList().done(function(data){
							if(data && data.length > 0) {
								$('#hCartCnt').html(data.length);
								$('#hCartCnt').closest('.cart').addClass('active');
							} else {
								$('#hCartCnt').html('');
								$('#hCartCnt').closest('.cart').removeClass('active');
							}
						});
						$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
						//AceCounter + Google Analytics
						delCartFl = true;
						afterDelCart(delCartFl);
					} else {
						showLayerAlert('잘못된 요청입니다.')
						.ok(function() {
							location.reload();
						});
					}
					$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
				});
			} else {
				crtSeqs = [];
				$.each($('input[name=selCrtCb]:checked', $container), function() {
					var tmpSeq = $(this).parents('tr:first').data('crtData').prd_mng_seq;
					
					//에이스 카운트 + Google Analytics 필요 데이터 S
					var gaData = {};
					var thisCrtData = $(this).parents('tr:first').data('crtData');
					var thisOrdrQty = thisCrtData.ordrQty;
					var price = (thisCrtData.totlDcSalPrc) ? thisCrtData.totlDcSalPrc : thisCrtData.totlSalPrc;
					if(thisOrdrQty && price){
						price = Math.floor(price / thisOrdrQty);
					}
					gaData['name'] = thisCrtData.prd_ko_nm;
					gaData['id'] = String(thisCrtData.prd_mng_seq);
					gaData['price'] = String(price);
					gaData['quantity'] = thisOrdrQty;
					if(thisCrtData.hasOpt){
						gaData['variant'] = [];
						$.each($('#crtListArea').find($('.crtC'+tmpSeq)), function() {
							($(this).data('crtPrdData').prd_ko_nm) && gaData.variant.push($(this).data('crtPrdData').prd_ko_nm);
						});
					}
					productList.push(gaData);
					//에이스 카운트 + Google Analytics 필요 데이터 E
					
					$.jart.common.cart.removeStorage(tmpSeq);
					$('.crtP'+tmpSeq).remove(); 
					$('.crtC'+tmpSeq).remove();
					$('.crtR'+tmpSeq).remove();
				});
				$.jart.common.cart.getCartList().done(function(data){
					if(data && data.length > 0) {
						$('#hCartCnt').html(data.length);
						$('#hCartCnt').closest('.cart').addClass('active');
					} else {
						$('#hCartCnt').html('');
						$('#hCartCnt').closest('.cart').removeClass('active');
					}
				});
				$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
				$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
				//AceCounter + Google Analytics
				delCartFl = true;
				afterDelCart(delCartFl);
			}
			//AceCounter(에이스 카운트 장바구니 상세 - 상품삭제시) + Google Analytics 장바구니 삭제 S
			function afterDelCart(delCartFl){
				try{
					if(delCartFl){
						//AceCounter 
						$.each(productList, function() {
							AEC_F_D(this.id,'o',this.quantity);
						});
						//Google Analytics
						dataLayer.push({
							'event':'removeFromCart',
							'ecommerce':{
								'remove':{
									'products': productList
								}
							}
						});
					}
				}catch(e){}
				//AceCounter 에이스 카운트 장바구니 삭제 (선택상품삭제) +Google Analytics 장바구니 삭제 E
			}
		});
		
		//품절상품 삭제
		$container.on('click', '#soCrtDel', function() {
			if($('tr.tr_soldout').length > 0) {
				$.each($('tr.tr_soldout'), function() {
					var targetTr = this;
					var crtData = $(this).data('crtData');
					if(crtData) {
						var tmpSeq = crtData.prd_mng_seq;
						$.jart.common.cart.removeStorage(tmpSeq);
						$('.crtP'+tmpSeq).remove(); 
						$('.crtC'+tmpSeq).remove();
						$('.crtR'+tmpSeq).remove();
					} else {
						var carPrdData = $(this).data('crtPrdData');
						if(carPrdData.crt_prd_seq > 0) {
							$.dr.crt.prd.delete(JSON.stringify({crtPrdSeq : carPrdData.crt_prd_seq})).done(function(data) {
								if(data.status == '200') {
									$(targetTr).remove();
								} else {
									showLayerAlert('잘못된 요청입니다.')
									.ok(function() {
										location.reload();
									});
								}
								$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
							});
						} else {
							$(targetTr).remove();
							$.jart.ordr.noregsns.crt.setOrdrPrcInfo();
						}
					}
				});
				$.jart.ordr.noregsns.crt.setCrtDataAreaStat();
			} else {
				showLayerAlert('품절상품이 없습니다.');
			}
		});
		
		//주문하기
		$sideInfoArea.on('click', '#ordrBtn', function() {
			$.jart.ordr.noregsns.crt.selCrtsBtnPass();
			if(!$(this).hasClass('disabled')) {
				var breakFl = false;
				var ordrCrtArr = []; //발렌타인 함께구매 불가한 상품 추가 2019.02.11
				$.each($('input[name=selCrtCb]:checked', $container), function() {
					var ordrReqCrt = {};
					ordrReqCrt.ordrReq = {};
					ordrReqCrt.ordrReqPrdList = [];
					ordrReqCrt.ordrReqRwrdprcList = [];
					
					var crtTr = $(this).parents('tr:first');
					var ordrData = crtTr.data('prdMngData');
					var crtData = crtTr.data('crtData');					
					if($('.crtC'+crtData.crt_seq).hasClass('tr_soldout')) {
						showLayerAlert('품절상품이 포합되어있습니다.')
						breakFl = true;
						return false;
					}
					if(crtData.ordrQty == 0) {
						showLayerAlert('옵션을 선택해 주세요.')
						breakFl = true;
						return false;
					}
					ordrReqCrt.ordrReq = {prd_mng_seq : ordrData.prd_mng_seq};
					ordrCrt = crtData.prd_mng_seq;
					
					// 발렌타인 함께구매 불가한 상품 추가 2019.02.11
					ordrCrtArr.push(ordrData.prd_mng_seq);
					// 패밀리 세일 장바구니 구매 불가 상품 추가
					var ordrBallanSeq = [21277, 21276, 21275, 21266, 21273, 21272, 21271, 21270, 21269, 21268, 21266, 21265, 21264, 21263, 21262, 21261, 21260, 21259, 21258, 21257, 21256, 21254, 21253, 21252, 21251, 21250, 21249, 21247, 21246, 21245, 21244, 21243, 21242, 21241, 21240, 21239, 21238, 21237, 21236, 21255, 21278, 21279, 21280];
					// 패밀리 세일 장바구니 구매 불가 상품 추가
					var result = ordrCrtArr.filter(function (a) {
						return ordrBallanSeq.indexOf(a) > -1; 
					 });
					var result2 = ordrCrtArr.filter(function (a) {
						return ordrBallanSeq.indexOf(a) === -1; 
					 });
					
					if(result.length > 0 && result2.length > 0){
						showLayerAlert('장바구니에 함께 결제가 불가한 상품<br>이 포함되어 있습니다.');
						breakFl = true;
						return false;						
					}
					//발렌타인 함께구매 불가한 상품 추가 2019.02.11

					if($('.crtC'+ordrCrt).not('.tr_soldout').length > 0) {
						$.each($('.crtC'+ordrCrt).not('.tr_soldout'), function() {
							var ordrPrdData = $(this).data('crtPrdData');
							ordrReqCrt.ordrReqPrdList.push({
								prd_seq : ordrPrdData.prd_seq
								, ordr_qty : ordrPrdData.ordr_qty
								, event_prd_qty : ordrPrdData.event_prd_qty
							});
						});
					} else {
						var ordrPrdData = crtTr.data('crtPrdData');
						ordrReqCrt.ordrReqPrdList.push({
							prd_seq : ordrPrdData.prd_seq
							, ordr_qty : ordrPrdData.ordr_qty
							, event_prd_qty : ordrPrdData.event_prd_qty
						});
					}
					$.each($('.liR'+crtData.prd_mng_seq, $('#crtListArea')), function() {
						var ordrRwrdprcData = $(this).data('rwrdprcData');
						ordrReqCrt.ordrReqRwrdprcList.push({
							rwrdprc_mng_seq : ordrRwrdprcData.rwrdprc_mng_seq
							, prd_seq : ordrRwrdprcData.prd_seq
						});
					});
					crtParams.ordrReqInfoList.push(ordrReqCrt);
				});
				if(breakFl) {
					crtParams.ordrReqInfoList = [];
					return false;
				}
				$('#ordrInfos', $('#ordrChkForm')).val(JSON.stringify(crtParams));
				$('#ordrChkForm').attr('action', '/ko/ordr/agree');
				$('#ordrChkForm').submit();
			} else {
				showLayerAlert('주문할 상품을 선택해 주세요.');
			}
		});
	};
	//이벤트 공통 E
	
})(jQuery);