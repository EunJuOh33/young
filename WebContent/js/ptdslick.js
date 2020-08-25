$(function(){
	let slickOption = {
			slidesToShow:1,
			slidesToScroll: 1,
			arrows: false,
			fade: true,
			dots: true,
			autoplay: true,
			autoplaySpeed: 5000,
			zIndex: 400
	}
	$(".topVisual").slick(slickOption);
	$(".promoBan").slick(slickOption);
	
});
