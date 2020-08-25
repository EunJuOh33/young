(function($) {

	$.dr = $.dr || {};
	$.dr.bnr = {};
	$.dr.bnr.cont = {};
	
	$.dr.bnr.cont.getList = function(bnr_seq){
		var url = $.context + '/api/bnr/cont/list/' + bnr_seq;
        var requestType = 'GET';
        var params = {};        
        return $.ib.json(url, params, requestType);
	};	
	
	$.dr.bnr.cont.getPage = function(data){
		var url = $.context + '/api/bnr/cont/list';
        var requestType = 'GET';
        var params = data;        
        return $.ib.json(url, params, requestType);
	};	
	
})(jQuery);