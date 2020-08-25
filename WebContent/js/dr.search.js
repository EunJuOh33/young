(function($) {
	
	$.dr = $.dr || {};
	$.dr.search = $.dr.search || {};
	$.dr.search.all = $.dr.search.all || {};
	$.dr.search.photo = $.dr.search.photo || {};
	$.dr.search.revw = $.dr.search.revw || {};
	$.dr.search.prd = $.dr.search.prd || {};
	$.dr.search.poplr = $.dr.search.poplr || {};
	$.dr.search.rcmn = $.dr.searchrcmn || {};
	
	$.dr.search.poplr.getList = function(){
		var url = $.context + '/api/poplr/srchw/poplr';
        var requestType = 'GET';
        var params = null;
        return $.ib.json(url, params, requestType);
	};
	
	$.dr.search.rcmn.getList = function(){
		var url = $.context + '/api/poplr/srchw/rcmn';
        var requestType = 'GET';
        var params = null;
        return $.ib.json(url, params, requestType);
	};
	
	$.dr.search.all.getList = function(data){
		var url = $.context + '/api/poplr/srchw/saerch/all';
        var requestType = 'GET';
        var params = data;
        return $.ib.json(url, params, requestType);
	};
	
	$.dr.search.photo.getList = function(data){
		var url = $.context + '/api/poplr/srchw/saerch/photo';
        var requestType = 'GET';
        var params = data;
        return $.ib.json(url, params, requestType);
	};

	$.dr.search.revw.getList = function(data){
		var url = $.context + '/api/poplr/srchw/saerch/revw';
        var requestType = 'GET';
        var params = data;
        return $.ib.json(url, params, requestType);
	};

	$.dr.search.prd.getList = function(data){
		var url = $.context + '/api/poplr/srchw/saerch/prdlist';
		var requestType = 'GET';
		var params = data;
		return $.ib.json(url, params, requestType);
	};
})(jQuery); 