$(document).ready(function(){
    setTimeout(function(){
      $("#notice_wrapper").slideToggle('slow', function(){
        $(this).remove();
      });
    }, 6000);
});
