(function($) {
	
	$.dr = $.dr || {};
	$.dr.cd = $.dr.cd || {};

	$.dr.cd = {
		dtl : {
			getList : function(cd_seq, type) {
				var url = $.context + '/api/cd/' + cd_seq + '/dtl/list';
		        var requestType = 'GET';
		        var params = {};
		        if(type) {
		        	params = {
		        		type : type	
		        	};
		        }
		        return $.ib.json(url, params, requestType);
			}
		}
	};
    
})(jQuery); 