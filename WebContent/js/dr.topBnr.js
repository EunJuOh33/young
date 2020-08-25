(function($) {

	$.dr = $.dr || {};
	$.dr.topBnr = {};

	$.dr.topBnr.getTopBnr = function(){
		var url = $.context + '/api/topBnr/getTopBnr'
        var requestType = 'GET';
        var params = {};        
        return $.ib.json(url, params, requestType);
	};	
			
	$.dr.topBnr.getCpnIssueCnt = function(cpn_mng_seq, chnl_cd){
		var url = $.context + '/api/topBnr/getCpnIssueCnt'
        var requestType = 'POST';
        var params = {
        		cpn_mng_seq : cpn_mng_seq
        		,chnl_cd : chnl_cd
        };        
        return $.ib.json(url, JSON.stringify(params), requestType);
	};	
	
})(jQuery);