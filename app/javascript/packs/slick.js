/*global $*/
$(document).on('turbolinks:load', function() {
 $('.slider').slick({
  dots: true,
  arrows: true,
  autoplay: true,
  autoplaySpeed: 3500,
  dots: true,
  pauseOnFocus: false,
  pauseOnHover: false,
  pauseOnDotsHover: false
 });
});

document.addEventListener("turbolinks:before-cache", function(){
	$('.slider.slick-initialized').slick('unslick');
});