(function($) {

	$.dr = $.dr || {};

	$.dr.common = $.dr.common || {};

    
	$.dr.common.loginCheck = function() {
		var url = '/api/check';
		var requestType = 'GET';
		var params = {};
		return $.ib.jsonSync(url, params, requestType);
	};
	
	$.dr.common.getPosCstmCnt = function(bbsSeq, param) {
		var url =  $.context + '/api/itf/pos/getCstmCnt';
		var requestType = 'GET';
		var params = {};
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.common.getPosCstm = function(bbsSeq, param) {
		var url =  $.context + '/api/itf/pos/getCstm';
		var requestType = 'GET';
		var params = {};
		return $.ib.json(url, params, requestType);
	};

})(jQuery);