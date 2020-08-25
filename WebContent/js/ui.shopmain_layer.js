function setCookie(name, value, expiredays) {
	var today = new Date();
	today.setDate(today.getDate() + expiredays);
	document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
} 

function getCookie(name) { 
    var cName = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) { 
        var y = (x+cName.length); 
        if ( document.cookie.substring( x, y ) == cName ) { 
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
} 

function closePopupNotToday(){	             
	setCookie('notToday23','Y', 1);
	$("#layer_solar").hide('fade');
	$('.solarmask').hide('fade');
} 

function closePopup(){
	$("#layer_solar").hide('fade');
	$('.solarmask').hide('fade');
} 

/* 20200317 솔라바이옴 레이어팝업 */
$(window).ready(function(){
    if(getCookie("notToday23")!="Y") {
		$("#layer_solar").show('fade');
		$('.solarmask').show('fade');
	} 
});