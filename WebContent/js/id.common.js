(function($) {

    // Context
    $.context = '/';
    
    // Global
    $.ib = {};
    
    // log
    $.ib.log = function(jsonData, descStr) {
        if (descStr && descStr != undefined) {
            alert("[" + descStr + "] : " + JSON.stringify(jsonData));
        } else {
            alert(JSON.stringify(jsonData));
        }
    };
        
    // Common Json Function
    $.ib.json = function(url, params, type) {
        var requestType = 'GET';
        if (typeof type != 'undefined')
            requestType = type;
        var dfd = $.Deferred();
        $.ajax({
            type: requestType,
            url: url,
            data: params,
            dataType: 'json',
            cache:false,
            contentType: "application/json; charset=utf-8"
        }).done(function(data) {
            dfd.resolve( data );
        }).fail( function ( request, status, error ) {
        	dfd.fail( false );
        });
        return dfd.promise();
    };
    
    // Common Json Function
    $.ib.jsonSync = function(url, params, type) {
        var requestType = 'GET';
        if (typeof type != 'undefined')
            requestType = type;
        var dfd = $.Deferred();
        $.ajax({
            type: requestType,
            url: url,
            data: params,
            async: false,
            dataType: 'json',
            contentType: "application/json; charset=utf-8"
        }).done(function(data) {
            dfd.resolve( data );
        }).fail( function ( request, status, error ) {
        	dfd.fail( false );
        });
        return dfd.promise();
    };
    
    // jsonp
    $.ib.jsonp = function(url, params, type) {
        var requestType = 'GET';
        if (typeof type != 'undefined')
            requestType = type;
        var dfd = $.Deferred();
        $.ajax({
            type : requestType,
            url : url,
            data : params,
            dataType : 'jsonp',
            contentType : 'application/json; charset=utf-8',
            timeout: 3000
        }).done(function(data) {
            dfd.resolve(data);
        }).fail(function(request, status, error) {
            dfd.fail(false);
        });
        return dfd.promise();
    };
    
    // cut String
    $.ib.substring = function( src, cutLength, replaceStr ) {
        if(!src || src == undefined || src == "null") return "";
        var cur = 0;
        for (var i=0; i < src.length; i++) {
            cur += (src.charCodeAt(i) > 128) ? 2 : 1;
            if (cur > cutLength) 
                return src.substring(0, i) + replaceStr;
        }
        return src;
    };
        
    // \n --> <BR/>
    $.ib.carriageReturnHtml = function( src ){
        if( src && src != undefined && src != null) {            
			var replaceStr = src.replace(/\n/g, "<br />");
			
            replaceStr = replaceStr.replace(/&amp;/g, "&")
									.replace(/&#35;/g, "#")
									.replace(/&lt;/g, "<")
									.replace(/&gt;/g, ">")
									.replace(/&quot;/g, '"')
									.replace(/&#39;/g, "'")
									.replace(/&#37;/g, '%')
									.replace(/&#40;/g, '(')
									.replace(/&#41;/g, ')')
									.replace(/&#43;/g, '+')
									.replace(/&#47;/g, '/')
									.replace(/&#46;/g, '.')
									.replace(/&amp;/g, "&");
									
            // find url
            replaceStr = replaceStr.replace(/((http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/g, "<a href='$1' target='_blank'>$1</a>");    
            
            return replaceStr;
        }
        return '';
    };
    
    $.ib.getInteger = function( str ){
    	if(str != null && str != ''){
    		return parseInt(str);
    	}else{
    		return 0;
    	}
    };
    
    $.ib.addComma = function(src) {
    	if(src){
    		src = String(src);
    		return src.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    	}
    	return '0';
    };
    
    $.ib.unComma = function(src) {
    	if(src) {
    		src = String(src);
    		return src.replace(/[^\d]+/g, '');
    	}
    	return '0';
    }
    
    
	/**
     * 화면 중앙에 팝업 생성
     * 
     * @param url 팝업 URL
     * @param name 팝업명
     * @param width 가로크기
     * @param height 세로크기
     * @param scroll yes/no
     * @param resizable yes/no
     */    
    $.ib.popup = function(url, name, width, height, scrollbars, resizable) {
        if(!scrollbars) scrollbars = "no";
        if(!resizable) resizable = "no";
        
        var openParamStr = "";
        if(width && height) {
        	openParamStr = "width=" + width + ", height=" + height; 
        }
        openParamStr += ", left=" + (screen.width/2-parseInt(width)/2) + ", top=" + (screen.height/2-parseInt(height)/2) + ", scrollbars=" + scrollbars + ", resizable=" + resizable + ", toolbar=no, directories=no, status=no, menubar=no";
        window.open(url, name, openParamStr);
    };
    
    /**
     * 공유 기능 
     */
    $.ib.share = function(type, title, url) {
        var curUrl
        if (url && url.length > 0) {
            curUrl = url;
        } else {
            curUrl = window.location.href;
        }

        // remove hashtag
        if (curUrl && curUrl.indexOf('#') > -1) {
            curUrl = curUrl.substring(0, curUrl.indexOf('#'));
        }
        curUrl = encodeURIComponent(curUrl);

        // kakao
        if (type == 'kakao') {
            var href = 'https://story.kakao.com/share?url=' + curUrl;
            $.ib.popup(href, 'kakao', 600, 600, 'yes','no');
            // facebook
        } else {
            var href = 'https://www.facebook.com/sharer/sharer.php?u=' + curUrl;
            $.ib.popup(href, 'facebook', 600, 600, 'yes','no');
        }
    };
    
    /**
     * 해피톡
     */
    $.ib.happytalk = function(talk, type, param) {
    	var isTalkTypeChecked = true;
		var hptUrl = '';
		var params = '';

		if(talk == 'happy'){
			hptUrl = happytalkUrl;
			params = '?site_id=' + happytalkSiteId;
			params = params + '&title=문의드립니다.';
			params = params + '&uid=' +  '';
			params = params + '&go=C';
			params = params + '&usergb=W';
			params = params + '&is_login=N';
			params = params + '&parameter1=' +  'none';
			params = params + '&parameter2=' +  'none';
			
			if(type === 'product'){
				params = params + '&parameter3=' + 'none';
				params = params + '&category_id=' + happytalkProductCategoryId;//대분류 상품 문의
				params = params + '&division_id=' + happytalProductDivisionId;//중분류 일반 상담
			}else if(type === 'cs'){
				params = params + '&parameter3=none';	
				params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
				params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
				
			}else{
				params = params + '&parameter3=none';	
				params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
				params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
			}
			
		} else if(talk == 'kakao'){
			hptUrl = kakaotalkUrl;
			params = '?site_id=' + happytalkSiteId;
			params = params + '&parameter1=' +  '';
			params = params + '&parameter2=' +  '';
			params = params + '&yid=' + encodeURI(kakaotalkYid);
			if(type === 'product'){
				params = params + '&parameter3=' + param.prd_ko_nm;
				params = params + '&category_id=' + happytalkProductCategoryId;//대분류 상품 문의
				params = params + '&division_id=' + happytalProductDivisionId;//중분류 일반 상담
			}else if(type === 'cs'){
				params = params + '&parameter3=none';	
				params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
				params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
				
			}else{
				params = params + '&parameter3=none';	
				params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
				params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
			}
			
		} else if(talk == 'naver'){
			hptUrl = navertalkkUrl;
			params = 'site_id|' + happytalkSiteId;
			params = params + '|parameter1|' +  '';
			params = params + '|parameter2|' +  '';
			if(type === 'product'){
				params = params + '|parameter3|' + param.prd_ko_nm;
				params = params + '|category_id|' + happytalkProductCategoryId;//대분류 상품 문의
				params = params + '|division_id|' + happytalProductDivisionId;//중분류 일반 상담
			}else if(type === 'cs'){
				params = params + '|parameter3|none';	
				params = params + '|category_id|' + happytalkCsCategoryId;//대분류 상품 문의
				params = params + '|division_id|' + happytalkCsDivisionId;//중분류 일반 상담
				
			}else{
				params = params + '|parameter3|none';	
				params = params + '|category_id|' + happytalkCsCategoryId;//대분류 상품 문의
				params = params + '|division_id|' + happytalkCsDivisionId;//중분류 일반 상담
			}
			params = encodeURI(params);
		} else {
			isTalkTypeChecked = false;
		}
		
		if( isTalkTypeChecked ){
			hptUrl = hptUrl + params;
			window.open(hptUrl);
		} else {
			showLayerAlert('확인 할수 없는 talk type입니다.</br>관리자에게 문의부탁드립니다.');
		}
    	/*$.jart.login.layer.show(function(){
			var loginCheckData = $.ib.loginCheck();
			loginCheckData.done(function(cstm){
				var cstmInfo = cstm.apiLogin;
				if(cstmInfo){
					var isTalkTypeChecked = true;
					var hptUrl = '';
					var params = '';

					if(talk == 'happy'){
						hptUrl = happytalkUrl;
						params = '?site_id=' + happytalkSiteId;
						params = params + '&title=문의드립니다.';
						params = params + '&uid=' +  cstmInfo.cstmSeq;
						params = params + '&go=C';
						params = params + '&usergb=W';
						params = params + '&is_login=Y';
						params = params + '&parameter1=' +  cstmInfo.cstmId;
						params = params + '&parameter2=' +  cstmInfo.cstmNm;
						
						if(type === 'product'){
							params = params + '&parameter3=' + param.prd_ko_nm;
							params = params + '&category_id=' + happytalkProductCategoryId;//대분류 상품 문의
							params = params + '&division_id=' + happytalProductDivisionId;//중분류 일반 상담
						}else if(type === 'cs'){
							params = params + '&parameter3=none';	
							params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
							params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
							
						}else{
							params = params + '&parameter3=none';	
							params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
							params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
						}
						
					} else if(talk == 'kakao'){
						hptUrl = kakaotalkUrl;
						params = '?site_id=' + happytalkSiteId;
						params = params + '&parameter1=' +  cstmInfo.cstmId;
						params = params + '&parameter2=' +  cstmInfo.cstmNm;
						params = params + '&yid=' + encodeURI(kakaotalkYid);
						if(type === 'product'){
							params = params + '&parameter3=' + param.prd_ko_nm;
							params = params + '&category_id=' + happytalkProductCategoryId;//대분류 상품 문의
							params = params + '&division_id=' + happytalProductDivisionId;//중분류 일반 상담
						}else if(type === 'cs'){
							params = params + '&parameter3=none';	
							params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
							params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
							
						}else{
							params = params + '&parameter3=none';	
							params = params + '&category_id=' + happytalkCsCategoryId;//대분류 상품 문의
							params = params + '&division_id=' + happytalkCsDivisionId;//중분류 일반 상담
						}
						
					} else if(talk == 'naver'){
						hptUrl = navertalkkUrl;
						params = 'site_id|' + happytalkSiteId;
						params = params + '|parameter1|' +  cstmInfo.cstmId;
						params = params + '|parameter2|' +  cstmInfo.cstmNm;
						if(type === 'product'){
							params = params + '|parameter3|' + param.prd_ko_nm;
							params = params + '|category_id|' + happytalkProductCategoryId;//대분류 상품 문의
							params = params + '|division_id|' + happytalProductDivisionId;//중분류 일반 상담
						}else if(type === 'cs'){
							params = params + '|parameter3|none';	
							params = params + '|category_id|' + happytalkCsCategoryId;//대분류 상품 문의
							params = params + '|division_id|' + happytalkCsDivisionId;//중분류 일반 상담
							
						}else{
							params = params + '|parameter3|none';	
							params = params + '|category_id|' + happytalkCsCategoryId;//대분류 상품 문의
							params = params + '|division_id|' + happytalkCsDivisionId;//중분류 일반 상담
						}
						params = encodeURI(params);
					} else {
						isTalkTypeChecked = false;
					}
					
					if( isTalkTypeChecked ){
						hptUrl = hptUrl + params;
						window.open(hptUrl);
					} else {
						showLayerAlert('확인 할수 없는 talk type입니다.</br>관리자에게 문의부탁드립니다.');
					}
				}
			});
		});*/
    	
    };
    
	$.ib.logout = function() {
    	var url = '/api/logout';
		var requestType = 'GET';
		var params = {};
		
		loading();
		
		$.when($.ib.jsonSync(url, params, requestType)).done(function(data) {
			loadComplete();
			if(data.status == "200"){
				location.href = "/ko/main/index";
			}
		});
    };
    
	$.ib.loginCheck = function() {
		var url = '/api/check';
		var requestType = 'GET';
		var params = {};
		return $.ib.jsonSync(url, params, requestType);
	};

	
	//cd_dtl 정렬
	 $.ib.dataSort = function(data){
		var dataSort = {};
		var arr = Object.keys(data).sort(function(a,b){return a - b;});
		for(i=0;i<arr.length;i++){
			dataSort[arr[i]] = data[arr[i]];
		}
		return dataSort;
	 };
	
})(jQuery);