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
$(document).ready(function() {
  // Trigger for modal 
  var triggers = $(".modalInput").overlay({

    // some mask tweaks suitable for modal dialogs
    mask: {
      color: '#ebecff',
      loadSpeed: 200,
      opacity: 0.9
    },
    closeOnClick: false,
    left: 135,
    top: 0,
  });

  // Submit handler for modal form 
  $("#signup form").submit(function(e) {

    // close the overlay
    triggers.eq(1).overlay().close();

    // get user input
    var input = $("input", this).val();

    // do something with the answer
    triggers.eq(1).html(input);
  });

  // Submit handler for modal form 
  $("#login form").submit(function(e) {

    // close the overlay
    triggers.eq(1).overlay().close();

    // get user input
    var input = $("input", this).val();

    // do something with the answer
    triggers.eq(1).html(input);                                                                                                                                                                           
  });
});
