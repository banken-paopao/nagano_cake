/*global $*/
$(document).on('turbolinks:load', function() {
 $('.slider').slick({
  dots: true,
  arrows: true,
  fade: true,
  speed: 2000,
  autoplay: true,
  autoplaySpeed: 5000,
  pauseOnFocus: false,
  pauseOnHover: false,
  pauseOnDotsHover: false
 });
});

// ブラウザバックしても動作させる
document.addEventListener("turbolinks:before-cache", function(){
	$('.slider.slick-initialized').slick('unslick');
});