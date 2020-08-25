(function($) {

	$.dr = $.dr || {};

	$.dr.main = {};

	$.dr.main.index = function() {
		var url = '/api/main/index';
		var requestType = 'GET';
        var params = {};
		return $.ib.json(url, params, requestType);
	};
		
})(jQuery);