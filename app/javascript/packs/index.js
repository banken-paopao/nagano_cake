/*global $*/
$(document).on('turbolinks:load', function(){

  $(function() {
    $('.flash').fadeOut(3500);
  });

  $(function(){
    $('.social-link').hover(
      function(){
        $(this).children('a').animate({
          'font-size': '32px'
        }, 300);
      }, function(){
        $(this).children('a').animate({
          'font-size': '24px'
        }, 300);
      });
  });

});

