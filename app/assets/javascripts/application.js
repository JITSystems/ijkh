// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap.min
$( document ).ready(function() {

var opts = {
  lines: 13, // The number of lines to draw
  length: 20, // The length of each line
  width: 13, // The line thickness
  radius: 45, // The radius of the inner circle
  corners: 1, // Corner roundness (0..1)
  rotate: 0, // The rotation offset
  direction: 1, // 1: clockwise, -1: counterclockwise
  color: '#000', // #rgb or #rrggbb or array of colors
  speed: 1.0, // Rounds per second
  trail: 68, // Afterglow percentage
  shadow: false, // Whether to render a shadow
  hwaccel: false, // Whether to use hardware acceleration
  className: 'spinner', // The CSS class to assign to the spinner
  zIndex: 2e9, // The z-index (defaults to 2000000000)
  top: 'auto', // Top position relative to parent in px
  left: 'auto' // Left position relative to parent in px
};
var target = document.getElementById('ajax_loader_center');
var spinner = new Spinner(opts).spin(target);
       
});

function popUpRender(message)
{
    var scrolled = window.pageYOffset || document.documentElement.scrollTop;

    var scrollBottomValue = document.documentElement.scrollHeight - document.documentElement.clientHeight - scrolled;
    //alert(scrollBottomValue);
    if (scrollBottomValue >97){
        scrollBottomValue=97;
    }

    scrollBottomValue = 115 - scrollBottomValue;
    $('.for_pop_up').css('bottom',scrollBottomValue+'px');
    $('.for_pop_up').prepend('<div onclick="this.remove();" class="pop_up_div">' + '<h3>Информация</h3><p>' +  message + '</p></div>'); 
    $('.pop_up_div').fadeIn(1000);

    setTimeout('$(".for_pop_up").html("")', 10000);
    //var intervalID = setInterval(function() { $(".for_pop_up div:last-child").remove(); }, 3000);
    //setInterval(function() { if ($(".for_pop_up").html()==' ') {clearInterval(intervalID);} }, 1000);
    // $(".for_pop_up div:last-child").delay(2000).fadeOut(1000);
}