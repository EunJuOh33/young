(function($) {

	$.dr = $.dr || {};
	$.dr.prd = $.dr.prd || {};
	$.dr.prd.cncr = $.dr.prd.cncr || {};
	$.dr.prd.mng = $.dr.prd.mng || {};
	$.dr.prd.revw = $.dr.prd.revw || {};
	$.dr.prd.mng.mpng = $.dr.prd.mng.mpng || {};
	$.dr.prd.mng.skinTypeOrdrPrdMngList = $.dr.prd.mng.skinTypeOrdrPrdMngList || {};
//	$.dr.prd.mng.recopickList = $.dr.prd.mng.recopickList || {};
	
	$.dr.prd.mng.inwr = $.dr.prd.inwr || {};
	$.dr.prd.mng.inwr.apnt = $.dr.prd.mng.inwr.apnt || {};
	
	
	/*
	 * paging용 기본 params
	 * 
	 */
	$.dr.prd.subList = function(prdMngSeq) {
		var url = '/api/prd/' + prdMngSeq;
		var requestType = 'GET';
		var params = null;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.mng.list = function(param) {
		var url = '/api/prd/mng/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
		
	$.dr.prd.mng.bestList = function(param) {
		var url = '/api/prd/mng/best/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.mng.searchList = function(param) {
		var url = '/api/prd/mng/search/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};	
	
	$.dr.prd.mng.view = function(prdMngSeq,catSeq) {
		var url = '/api/prd/mng/'+prdMngSeq;
		var requestType = 'GET';
		var params = {};
		if(catSeq && catSeq != '' && catSeq.length > 0){
			params['catSeq'] = catSeq;
		}
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.mng.popupView = function(prdMngSeq) {
		var url = '/api/prd/mng/popup/'+prdMngSeq;
		var requestType = 'GET';
		var params = {};
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.mng.crtPrdInfoList = function(parma) {
		var url = '/api/prd/mng/list/crtPrdInfo';
		var requestType = 'POST';
		var params = parma;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.mng.mpng.list = function(param) {
		var url = '/api/prd/mng/mpng/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.mng.inwr.apnt.count = function(param) {
		var url = '/api/prd/inwr/apnt/count';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.cncr.count = function(param) {
		var url = '/api/prd/cncr/count';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.prd.cncr.getList = function(param) {
		var url = '/api/prd/cncr/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	
	//개인화  동일 피부type을 가진 고객의 구매수량 높은 순위리스트를 가져온다.
	$.dr.prd.mng.skinTypeOrdrPrdMngLis = function(param) {
		var url = '/api/prd/mng/skinTypeOrdrPrdMngList';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
//	$.dr.prd.mng.recopickList = function(param) {
//		var url = '/api/prd/mng/recopickList';
//		var requestType = 'GET';
//		var params = param;
//		return $.ib.json(url, params, requestType);
//	};
	
	$.dr.prd.mng.recentList = function(param) {
		var url = '/api/prd/mng/recent/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};

	$.dr.prd.mng.gift = function(giftSeq) {
		var url = '/api/prd/mng/gift/'+giftSeq;
		var requestType = 'GET';
		var params = {chnl_cd : '001'};
		return $.ib.json(url, params, requestType);
	};	
})(jQuery);