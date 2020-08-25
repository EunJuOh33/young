(function($) {

	// default
	$.jart = $.jart || {};

	// common
	$.jart.common = {};

	// common cart
	$.jart.common.cart = {};

	$.jart.common.cart.storage = window.sessionStorage;

	$.jart.common.cart.saveName = "_jart_cart_info";

	$.jart.common.cart.removeStorage = function(prd_mng_seq, prd_seq) {
		if (prd_mng_seq && prd_seq) {
			var cartObj = $.jart.common.cart.getStorage();
			$.each(cartObj, function(idx, crtInfo) {
				// is same product
				if (crtInfo.crt.prd_mng_seq === prd_mng_seq) {
					// set count
					$.each(crtInfo.crtPrdList, function(jdx, crtPrd) {
						if (crtPrd && crtPrd.prd_seq === prd_seq) {
							crtInfo.crtPrdList.splice(jdx, 1);
							
							// total order counts
							var totalOrderCount = 0;
							$.each(crtInfo.crtPrdList, function(idx, crtPrd) {
								totalOrderCount = parseInt(totalOrderCount) + parseInt(crtPrd.ordr_qty) - parseInt(crtPrd.event_prd_qty);
							});

							// choose last select option
							$.each(crtInfo.crtRwrdprcPrdList, function(idx, crtRwrdprcPrd) {
								crtRwrdprcPrd.qty = totalOrderCount;
							});

							
							$.jart.common.cart.setStorage(cartObj);
							return false;
						}
					});
				}
			});
		} else if (prd_mng_seq) {
			var cartObj = $.jart.common.cart.getStorage();
			$.each(cartObj, function(idx, crtInfo) {
				if (crtInfo.crt.prd_mng_seq === prd_mng_seq) {
					cartObj.splice(idx, 1);
					$.jart.common.cart.setStorage(cartObj);
					return false;
				}
			});
		} else {
			$.jart.common.cart.storage.removeItem($.jart.common.cart.saveName);
		}
	};

	$.jart.common.cart.setStorage = function(obj) {
		$.jart.common.cart.storage.setItem($.jart.common.cart.saveName, JSON.stringify(obj));
	};

	$.jart.common.cart.getStorage = function() {
		var item = $.parseJSON($.jart.common.cart.storage.getItem($.jart.common.cart.saveName));
		if(item){
			var params = {};
			var seqs = [];
			$.each(item, function() {
				seqs.push(this.crt.prd_mng_seq);
			});
			params.prdMngSeqs = seqs;
			$.dr.crt.noregsns.list(JSON.stringify(params)).done(function(data) {
				if (data && data.status == 200) {
					if(data.crtInfoList){
						var cnt = 0 ;
						$.each(data.crtInfoList, function() {
							const prdMngSeq = this;
							const idx = item.findIndex(function(t) {
								return t.crt.prd_mng_seq == prdMngSeq
								})
							if (idx > -1)
								item.splice(idx, 1);
						});
					}
				}
			});		
		}
		return item;
	};

	$.jart.common.cart.getCartList = function() {
		var dfd = $.Deferred();
		$.dr.crt.list().done(function(data) {
			// cart info update
			if (data && data.status == 200) {
				dfd.resolve(data.crtInfoList);
			} else {
				dfd.resolve($.jart.common.cart.getStorage());
			}
		});
		return dfd.promise();
	};

	$.jart.common.cart.addCart = function(obj) {
		var dfd = $.Deferred();
		if (!obj || !obj.crt || obj.crt.crt_seq || !obj.crtPrdList) {
			showLayerAlert('장바구니에 등록할수 없습니다.<br>관리자에게 문의 하여 주십시요.');
			return;
		}
		$.dr.crt.insert(JSON.stringify(obj)).done(function(data) {
			if (data && data.status == 200) {
				dfd.resolve({
					status : 200
				});
			} else {
				var crtObj = $.jart.common.cart.getStorage();
				if (!crtObj || crtObj == null) {
					crtObj = [];
					crtObj.push(obj);
				} else {
					var founded = false;
					$.each(crtObj, function(idx, crtInfo) {
						// is same product
						if (crtInfo.crt.prd_mng_seq === obj.crt.prd_mng_seq) {
							founded = true;
							// set count
							$.each(crtInfo.crtPrdList, function(idx, crtPrd) {
								// add count
								$.each(obj.crtPrdList,function(idx, newPrd) {
									if (!newPrd.founded && crtPrd.prd_seq == newPrd.prd_seq) {
										crtPrd.ordr_qty = parseInt(crtPrd.ordr_qty) + parseInt(newPrd.ordr_qty);
										crtPrd.event_prd_qty = parseInt(crtPrd.event_prd_qty) + parseInt(newPrd.event_prd_qty);
										newPrd.founded = true;
									}
								});
							});
	
							// add not duplicated
							$.each(obj.crtPrdList, function(idx, newPrd) {
								if (!newPrd.founded) {
									crtInfo.crtPrdList.push(newPrd);
								}
							});
	
							// total order counts
							var totalOrderCount = 0;
							$.each(crtInfo.crtPrdList, function(idx, crtPrd) {
								totalOrderCount = parseInt(totalOrderCount) + parseInt(crtPrd.ordr_qty) - parseInt(crtPrd.event_prd_qty);
							});
	
							// set crtRwrdprcPrdList
							crtInfo.crtRwrdprcPrdList = obj.crtRwrdprcPrdList;
	
							// choose last select option
							$.each(crtInfo.crtRwrdprcPrdList, function(idx, crtRwrdprcPrd) {
								crtRwrdprcPrd.qty = totalOrderCount;
							});
						}// :~if (crtInfo.crt.prd_mng_seq ===
					});// :~$.each(crtObj, function(idx, crtInfo) {
					
					// not exists in list
					if(!founded) {
						crtObj.push(obj);						
					}
				}// :~if (!crtObj || crtObj == null) {
				$.jart.common.cart.setStorage(crtObj);
				dfd.resolve({
					status : 200
				});
			}// :~if (!data || data.status != 200) {
		});// :~$.dr.crt.insert(obj).done(function(data) {

		return dfd.promise();
	};// ~$.jart.common.cart.addCart = function(obj) {

	// common recent
	$.jart.common.recent = {};

	$.jart.common.recent.storage = window.localStorage;

	$.jart.common.recent.maxCount = 2;

	$.jart.common.recent.saveName = "_jart_recent_info";

	$.jart.common.recent.removeStorage = function() {
		$.jart.common.recent.storage.removeItem($.jart.common.recent.saveName);
	};

	$.jart.common.recent.setStorage = function(obj) {
		$.jart.common.recent.storage.setItem($.jart.common.recent.saveName, JSON.stringify(obj));
	};

	$.jart.common.recent.getStorage = function() {
		return $.parseJSON($.jart.common.recent.storage.getItem($.jart.common.recent.saveName));
	};

	$.jart.common.recent.addRecent = function(prd_mng_seq) {
		var recentModel = {
			'prd_mng_seq' : prd_mng_seq
		};

		var recentObj = $.jart.common.recent.getStorage();
		if (!recentObj || recentObj == null) {
			recentObj = [];
			recentObj.push(recentModel);
			$.jart.common.recent.setStorage(recentObj);
		} else {
			
			// duplicate remove add return;
			$.each(recentObj, function(idx, recent) {
				if(recent && recent.prd_mng_seq === prd_mng_seq) {
					recentObj.splice(idx, 1);
				}
			});
			
			// non duplicate remove add;
			recentObj.push(recentModel);
			
			// limit max count history
			if(recentObj.length > $.jart.common.recent.maxCount){
				recentObj.splice(0, recentObj.length - $.jart.common.recent.maxCount);
			}
			
			$.jart.common.recent.setStorage(recentObj);
			return;
		}
	};
	
	$.jart.common.merge = {};
	
	$.jart.common.merge.checkMbr = function(){
	
		$.ib.loginCheck().done(function(data){
			
			if(data.status == "200"){
				if( data.apiLogin.authorities[0].authority == "ROLE_USER"){
					
					$.dr.common.getPosCstmCnt().done(function(data){
						if(data.status == "200"){
							switch(data.cnt) {
							    case 0:
							    	showLayerConfirm("고객님은 오프라인 회원정보가 없습니다. <br/>통합회원으로 전환 하시겠습니까?")
									.ok(function() {
										location.href = $.context + "/ko/cstm/merge02";
									});
							        break;
							    case 1:
							    	location.href = $.context + "/ko/cstm/merge01";
							        break;
							    default:
							    	showLayerAlert("중복된 오프라인회원이 존재합니다. <br/>CS Center로 문의해주시기 바랍니다.");
						        	break;
							}
						}else{
							showLayerAlert("통합회원 정보 조회 중 오류가 발생하였습니다. 관리자 문의바랍니다.");
						}
					});
					
				}else{
					showLayerConfirm("통합회원으로 전환은 온라인 회원만 가능합니다.<br/>회원가입하시겠습니까?")
					.ok(function() {
						location.href = $.context + "/ko/cstm/joinus01";
					});
				}

			}else{
				showLayerConfirm("통합회원으로 전환하시려면 로그인이 필요 합니다. 로그인하시겠습니까?")
				.ok(function() {
					location.href = $.context + "/ko/login";
				});
			}
		});
	};
	
	
})(jQuery);
