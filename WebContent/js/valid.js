(function($) {
    
	// Global
	$.ib = $.ib || {};
	
    // Validator
    $.ib.validator = {};
    
    // Not Null Check
    $.ib.validator._is_not_null = function( str ) {
        return ( str && str != '' && str != null );
    };
    
    // Not Null Check    
    $.ib.validator.isNull = function( str ) {
        return !$.ib.validator._is_not_null(str);       
    };
    
    // IS URL
    $.ib.validator.isUrl = function( str ) {
        if($.ib.validator.isNull( str )) 
            return null;
        var regExp = /(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/; 
        return regExp.test(str);
    };
    
    // to lower case
    $.ib.validator._to_lower_case = function( str ) {
        return ( str + '' ).toLowerCase();
    };    
    
    // Char length
    $.ib.validator._get_byte_length = function( str ) {
    	str = String(str);
        var byteLength = 0;
        for ( var i=0 ; i<str.length ; i++ ){
            var ch = escape( str.charAt( i ) );
            if( ch.length == 1 ){ 
                byteLength++;
            } else if ( ch.indexOf( "%u" ) != -1 ) {
                byteLength += 2;
            } else if ( ch.indexOf( "%" ) != -1 ) {
                byteLength += ch.length / 3;
            }
        }
        return byteLength;
    };
    
    $.ib.validator.checkStr = function(maxlen, str) {
    	var byteLength = 0;
    	for (var i=0; i<str.length; i++) {
    		byteLength += (str.charCodeAt(i) > 128) ? 2 : 1;
    	       if (byteLength > maxlen) return str.substring(0,i);
    	}
    	return str;
    }
    
    // Is Number
    $.ib.validator._is_number = function( str ) {
        str = (str += '').replace( /^\s*|\s*$/g, '' ); // trim
        
        if( str == '' ) return false;
        var re = /^[0-9]*$/;
        return re.test( str );
    };
    
    // Is Number
    $.ib.validator._checkObj_numberOnly = function( obj ) {
        return $.ib.validator._is_number( $(obj).validator() );
    };
    
    // 숫자만 추출
    $.ib.validator._output_number = function( str){
    	var s = "";
    	var value = "";
    	if($.trim(str) != ""){
        	for(i=0;i<str.length;i++){
        		s = str.charAt(i);
        		if( $.ib.validator._is_number(s)){
        			value += s;
        		}
        	}
    	}
    	return value;
    };  
    // Is Date
    $.ib.validator._is_date = function( str ) {
        while(str.indexOf('-')>=0){ str = str.replace('-', ''); }
        while(str.indexOf('.')>=0){ str = str.replace('.', ''); }
        return $.ib.validator._is_date8(str);
    };
    
    // Is Date8
    $.ib.validator._is_date8 = function( str ) {
        if(str.length != 8) return false;

        var yyyy = str.substring(0, 4);
        
        /* 12월일 경우 날짜 생성해서 보면 getMonth()로 보면 0으로 리턴되므로 1을 빼준다. */
        var mm = str.substring(4, 6) - 1;
        var dd = str.substring(6);
        var checkDate = new Date( yyyy, mm, dd );

        if ( checkDate.getFullYear() != yyyy ||    checkDate.getMonth() != mm || checkDate.getDate() != dd ){
            return false;
        }
        
        return true;   
    };
    
    $.ib.validator._checkObj_notNull = function( obj ) {
        
        var val = ($(obj).validator()+'').replace( /^\s*|\s*$/g, '' ); // trim
        if ($.ib.validator._is_notNull(val)) {

            //alert('tag='+$(obj).get(0).tagName+', size='+$(obj).attr('size')+', name='+$(obj).attr('name')+', id='+$(obj).attr('id')+', title='+$(obj).attr('title')+', type='+$(obj).attr('type')+', val='+$(obj).validator()+', notNull='+$(obj).attr('notNull'));
            if ( $(obj).get(0).tagName.toLowerCase() == 'select' && $(obj).attr( 'size' ) > 0 ) {
                return ( val == 'null' ? false : true );
            } else {
                return true;
            }
        } else {
            return false;
        }
    };
        
    // Is Email
    $.ib.validator._is_email = function( str ){
        var re = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
        return re.test(str);
    };
        
    // Is Email2
    $.ib.validator._is_email2 = function( str ){
        var re = /^((\w|[\-\.])+)\.([A-Za-z]+)$/;
        return re.test(str);
    };
    
    // Check Byte
    $.ib.validator._check_byte = function( str, size, isMax ){
        var checkLength = parseInt(size);
        var byteLength = $.ib.validator._get_byte_length(str);
        if( isMax ) {
            return (byteLength <= checkLength ? false : true);
        } else {
            return (byteLength >= checkLength ? false : true);
        }
    };
    
    // str > size
    $.ib.validator.checkByteEqualGreater = function( str, size ) {
        return $.ib.validator._check_byte( str, size, true);
    };
    
    // str < size
    $.ib.validator.checkByteEqualLower = function( str, size) {
        return $.ib.validator._check_byte( str, size, false);
    };
    
    // str1 <= str <= str2
    $.ib.validator.checkByteBetween = function( str, size1, size2 ) {
        return !$.ib.validator._check_byte( str, size1, false ) && !$.ib.validator._check_byte( str, size2, true );
    };
    
 // Check Type
    $.ib.validator.checkType = function( str, methodType ){
        var userchar = '';
        var chartypeReg = "";
        
        switch(methodType) {
            case "num":
                chartypeReg = "^([0-9]" + userchar + ")+$";
                break;
            case "eng":
                chartypeReg = "^([a-zA-Z]" + userchar + ")+$" ;
                break;
            case "englower":
                chartypeReg = "^([a-z]" + userchar + ")+$" ;
                break; 
            case "engupper":
                chartypeReg = "^([A-Z]" + userchar + ")+$" ;
                break;        
            case "kor":
                chartypeReg = "^([\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]" + userchar + ")+$";
                break;
            case "special":
                chartypeReg = "^([!@#$%^*+=-]" + userchar + ")+$";
                break;     
            case "engnum":
                chartypeReg = "^([a-zA-Z0-9]" + userchar + ")+$";
                break;
            case "kornum":
                chartypeReg = "^([\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]|\\d" + userchar + ")+$";
                break;
            case "koreng":
                chartypeReg = "^([\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]|[a-zA-Z]" + userchar + ")+$";
                break;  
            case "korengnum":
                chartypeReg = "^([\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]|[a-zA-Z]|\\d" + userchar + ")+$";
                break; 
            case "engnumspecial":
                chartypeReg = "^([a-zA-Z0-9]|[!@#$%^*+=-]" + userchar + ")+$";
                break;  
            case "englowernum":
                chartypeReg = "^([a-z0-9]" + userchar + ")+$";
                break; 
            case "email1":
                chartypeReg = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])+$";
                break;  
            case "email2":
                chartypeReg = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*[\.]([a-zA-Z]{2,9})+$";
                break;
            case "email":
                return $.ib.validator._is_email(str);  
            case "date":
                return $.ib.validator._is_date(str);
            default:
                break;
        }       
        
        var chkReg = new RegExp(chartypeReg);
        if(str.length > 0 && !chkReg.test(str)) {
            return false;
        }
        return true;
    };
    
    // Check String in type
    $.ib.validator.checkStringInType = function( str, methodType ){
    	var s = "";
    	if($.trim(str) != "" && $.trim(methodType) != "" ){
        	for(i=0;i<str.length;i++){
        		s = str.charAt(i);
        		if($.ib.validator.checkType(s,methodType)){
        			return true;
        		}
        	}
    	}
    	return false;
    };
    
    $.ib.validator.chkLen = function(target, maxLength) {
    	var str = $(target).val();
    	var thisLength = str.length;
    	if(str.length > maxLength) {
    		str = str.substring(0, maxLength);
    		$(target).val(str);
    		thisLength = maxLength;
    	}
    	$(target).parents('div:first').find('.inptLngth').html(thisLength);
    };
    
})(jQuery);