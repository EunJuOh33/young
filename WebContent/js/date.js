(function($) {

	// Global
	$.ib = $.ib || {};
	
    // date
    $.ib.date = {};
    
    // date splitter
    $.ib.date.dateSplitter = '.';
    $.ib.date.timeSplitter = ':';
    
    // Week Array
    $.ib.date.week = new Array('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT');
    // Get DayOfWeek
    $.ib.date.getDayOfWeek = function(dateObj) {
        return $.ib.week[dateObj.getDay()];
    };
    
    // GMT offset
    $.ib.date.offsetTime = '9';
    $.ib.date.convertGmtDate = function( dateObj ) {
        var tempObj = new Date();
        // Convert To GMT0
        if($.ib.date.offsetTime != '') {
            return new Date(dateObj + tempObj.getTimezoneOffset() * 60000 + parseInt($.ib.date.offsetTime));            
        }
        return new Date(dateObj + tempObj.getTimezoneOffset() * 60000);
    };
    
    // Get Today
    $.ib.date.getToday = function() {
        return $.ib.date.convertGmtDate(new Date());
    };
    
    // get date    
    $.ib.date.getDate = function(dateObj, offsetType, offsetNum){
        // result
        var result = {
            first : dateObj,
            last : dateObj
        };
        
        // currObj
        var currObj = dateObj;
        if(!currObj || currObj == undefined) {
            result.first = $.ib.date.today();
            result.last = $.ib.date.today();
        }
            
        // week start date, week end date. ex) 2014.01.05 ~ 2014.01.11 
        if(offsetType == 'W') {
            result.first.setDate(result.first.getDate() + (parseInt(offsetNum) * 7) - result.first.getDay());
            result.last.setDate(result.last.getDate() + (parseInt(offsetNum) * 7) - result.last.getDay() + 6);
        // month start date, month end date. ex) 2014.01.01 ~ 2014.01.31
        } else if(offsetType == 'M') {
            result.first.setDate(1);
            result.first.setMonth(result.first.getMonth() + parseInt(offsetNum));
            
            result.last.setDate(1);
            result.last.setMonth(result.last.getMonth() + parseInt(offsetNum) + 1);
            result.last.setHours(-1);
        // month start week date, month end week date. ex) 2013.12.29 ~ 2014.02.01
        } else if(offsetType == 'MW') {
            result.first.setDate(1);
            result.first.setMonth(result.first.getMonth() + parseInt(offsetNum));
            result.first.setDate(result.first.getDate() - result.first.getDay());
    
            result.last.setDate(1);
            result.last.setMonth(result.last.getMonth() + parseInt(offsetNum) + 1);
            result.last.setHours(-1);
            result.last.setDate(result.last.getDate() - result.last.getDay() + 6);
        } else {
        // add date
            result.first.setDate(result.first.getDate() + parseInt(offsetNum));
            result.last.setDate(result.last.getDate() + parseInt(offsetNum));
        }
        
        return result;
    };

    // convert string to date 
    $.ib.date.stringToDate = function(dateStr) {
        var replaceStr = dateStr.replace(/./gi, '');
        var yearMonthStr = (parseInt(replaceStr.substring(0, 6)) - 1) + '';
        var year = yearMonthStr.substring(0, 4);
        var month = yearMonthStr.substring(4, 6);
        var day = replaceStr.substring(6, 8);
        return new Date(year, month, day);
    };
    
    // String To DateTime
    $.ib.date.stringToDateTime = function(dateStr) {
        var replaceStr = dateStr.replace(/./gi, '');
        var yearMonthStr = (parseInt(replaceStr.substring(0, 6)) - 1) + '';
        var year = yearMonthStr.substring(0, 4);
        var month = yearMonthStr.substring(4, 6);
        var day = replaceStr.substring(6, 8);
        var hour = replaceStr.substring(8, 10);
        var min = replaceStr.substring(10, 12);
        var sec = replaceStr.substring(12, 14);
        var parseDate = new Date(year, month, day);
        parseDate.setHours(hour, min, sec);
        return parseDate;
    };
    
    // convert date to string 
    $.ib.date.dateToString = function(dateObj) {
        return date == null ? '' : dateObj.getFullYear() + $.ib.date.dateSplitter
                + ('0' + (dateObj.getMonth() + 1)).substr(-2, 2) + $.ib.date.dateSplitter
                + ('0' + dateObj.getDate()).substr(-2, 2);
    };
    
    // convert date to timestamp string
    $.ib.date.dateToTimeString = function() {
        return date == null ? '' : date.getFullYear() + $.ib.date.dateSplitter
                + ('0' + (date.getMonth() + 1)).substr(-2, 2) + $.ib.date.dateSplitter
                + ('0' + date.getDate()).substr(-2, 2) + ' '
                + ('0' + (date.getHours())).substr(-2, 2) + $.ib.date.timeSplitter
                + ('0' + (date.getMinutes())).substr(-2, 2) + $.ib.date.timeSplitter
                + ('0' + (date.getSeconds())).substr(-2, 2);
    };
        
    // is Same Date
    $.ib.date.isToday = function(dateStr) {
        try {
            var replaceStr = dateStr.replace(/./gi, '').substring(0,8); 
            var curDate = $.ib.date.dateToString($.ib.date.getToday()).replace(/./gi, '').substring(0,8);
            if (replaceStr == curDate) {
                return true;
            }
        } catch(e) {}
        return false;
    };
    
    // get time ago
    $.ib.date.getTimeago = function(dateObj) {
        var msPerMinute = 60 * 1000;
        var msPerHour = msPerMinute * 60;
        var msPerDay = msPerHour * 24;
        var msPerMonth = msPerDay * 30;
        var msPerYear = msPerDay * 365;
        var elapsed =  $.ib.date.getToday().getTime() - dateObj.getTime();
        if (elapsed < msPerMinute) {
             return Math.round(elapsed/1000) + ' 초전';   
        } else if (elapsed < msPerHour) {
             return Math.round(elapsed/msPerMinute) + ' 분전';   
        } else if (elapsed < msPerDay ) {
             return Math.round(elapsed/msPerHour ) + ' 시간전';   
        } else if (elapsed < msPerMonth) {
            return Math.round(elapsed/msPerDay) + ' 일전';   
        } else if (elapsed < msPerYear) {
            return Math.round(elapsed/msPerMonth) + ' 월전';   
        } else {
            return Math.round(elapsed/msPerYear ) + ' 년전';   
        }
    };
    
    
    $.ib.date.convertDate = function( time ) {
        return new Date(time);
    };
    
    $.ib.date.toDate = function( time ) {
        if (time == null)
            return '';
        var date = $.ib.date.convertDate( time ); 
        return date == null ? '' : date.getFullYear() + $.ib.date.dateSplitter
                + ('0' + (date.getMonth() + 1)).substr(-2, 2) + $.ib.date.dateSplitter
                + ('0' + date.getDate()).substr(-2, 2);
    };
    
    $.ib.date.toDateWithTime = function( time ) {
        if (time == null)
            return '';
        var date = $.ib.date.convertDate( time ); 
        return date == null ? '' : date.getFullYear() + '-'
                + ('0' + (date.getMonth() + 1)).substr(-2, 2) + '-'
                + ('0' + date.getDate()).substr(-2, 2) + ' '
                + ('0' + date.getHours()).substr(-2, 2) + ':'
                + ('0' + date.getMinutes()).substr(-2, 2);
    };
    
    $.ib.date.toDateWithTimeSec = function( time ) {
        if (time == null)
            return '';
        var date = $.ib.date.convertDate( time ); 
        return date == null ? '' : date.getFullYear() + '-'
                + ('0' + (date.getMonth() + 1)).substr(-2, 2) + '-'
                + ('0' + date.getDate()).substr(-2, 2) + ' '
                + ('0' + date.getHours()).substr(-2, 2) + ':'
                + ('0' + date.getMinutes()).substr(-2, 2) + ':'
                + ('0' + date.getSeconds()).substr(-2, 2);
    };
    
    $.ib.date.getDate = function(term, type){
    	
    	var rtnDate = new Date();
    	
    	switch(type) {
    		case 'D' :
    			rtnDate.setDate(rtnDate.getDate()+term);
    			break;
    		
    		case 'M' :
    			rtnDate.setMonth(rtnDate.getMonth()+term);
        		break;
        		
    		case 'Y' :
    			rtnDate.setYear(rtnDate.getFullYear()+term);
        		break;
        		
        	default :
        		rtnDate.setDate(rtnDate.getDate()+term);
        		break;
    	
    	}
    	
    	return rtnDate.getFullYear() + $.ib.date.dateSplitter
                + ('0' + (rtnDate.getMonth() + 1)).substr(-2, 2) + $.ib.date.dateSplitter
                + ('0' + rtnDate.getDate()).substr(-2, 2);
    	
    };
    
})(jQuery);