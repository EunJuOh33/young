(function($) {

	$.dr = $.dr || {};
	$.dr.rwrdprc = $.dr.rwrdprc || {};
	$.dr.rwrdprc.mng = $.dr.rwrdprc.mng || {};
	
	/*
	 * 사은품 호출
	 * paging용 기본 params
	 * 
	 */
	$.dr.rwrdprc.mng.list = function(param) {
		var url =  $.context + '/api/rwrd/mng/prc/list';
		var requestType = 'POST';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
})(jQuery);