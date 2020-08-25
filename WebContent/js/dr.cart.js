(function($) {

	$.dr = $.dr || {};
	$.dr.crt = $.dr.crt || {};
	$.dr.crt.noregsns = $.dr.crt.noregsns || {} ;
	/*
	 * 선택사항을 장바구니에 담는다.
	 * 
	 */
	$.dr.crt.insert = function(param) {
		var url =  $.context + '/api/crt/insert';
		var requestType = 'POST';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.crt.multiInsert = function(param) {
		var url =  $.context + '/api/crt/multiInsert';
		var requestType = 'POST';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	$.dr.crt.multiInsertSync = function(param) {
		var url =  $.context + '/api/crt/multiInsert';
		var requestType = 'POST';
		var params = param;
		return $.ib.jsonSync(url, params, requestType);
	};	
	
	/*
	 * 장바구니 리스트 호출.
	 * 
	 */
	$.dr.crt.list = function(param) {
		var url =  $.context + '/api/crt/list';
		var requestType = 'GET';
		var params = {};
		return $.ib.json(url, params, requestType);
	};
	
	/*
	 * 장바구니 선택상품 삭제.
	 * 
	 */
	$.dr.crt.delete = function(param) {
		var url =  $.context + '/api/crt/delete';
		var requestType = 'POST';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	/*
	 * 장바구니 선택옵션상품 삭제.
	 * 
	 */
	$.dr.crt.prd = $.dr.crt.Prd || {};
	$.dr.crt.prd.delete = function(param) {
		var url =  $.context + '/api/crt/prd/delete';
		var requestType = 'POST';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	/*
	 * 장바구니 선택상품을 저장
	 * 
	 */
	$.dr.crt.savCrtInfo = function(param) {
		var url =  $.context + '/api/crt/savCrtInfo';
		var requestType = 'POST';
		var params = param;
		return $.ib.json(url, params, requestType);
	};
	
	/*
	 * 비회원 장바구니 리스트 호출.
	 * 
	 */
	$.dr.crt.noregsns.list = function(param) {
		var url =  $.context + '/api/crt/noregsns/list';
		var requestType = 'POST';
		var params = param;
		return $.ib.jsonSync(url, params, requestType);
	};	
	
})(jQuery);