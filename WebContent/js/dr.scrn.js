 
(function($) {

	$.dr = $.dr || {};
	$.dr.scrn = $.dr.scrn || {};	
	/*
	 * 쇼핑찬스 리스트
	 * paging용 기본 params
	 * 
	 */
	$.dr.scrn.getView = function(clCd,scrnCd) {
		var url =  $.context + '/api/scrn/' + clCd + '/' + scrnCd;
		var requestType = 'GET';
		return $.ib.json(url, null, requestType);
	};
	
	$.dr.scrn.getList = function(param) {
		var url =  $.context + '/api/scrn/list';
		var requestType = 'GET';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
})(jQuery);