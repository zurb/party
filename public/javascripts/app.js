$(function ($) {
	$(document).foundation();
	/* Top Bar */
  $(window).scroll(function() {
    var scroll = Math.max($('body').scrollTop(), $('html,body').scrollTop());
    if (scroll > 100 && scroll < 3100) {
      $(".fixed").addClass("push-down");
  	} else {
  		$(".fixed").removeClass("push-down");
    }
    if (scroll > 155) {
      $("#1998").addClass("fade");
    } 
    if (scroll > 420) {
      $("#1999").addClass("fade");
    } 
    if (scroll > 650) {
      $("#2000").addClass("fade");
    }
    if (scroll > 860) {
      $("#2001").addClass("fade");
    } 
    if (scroll > 1060) {
      $("#2003").addClass("fade");
    } 
    if (scroll > 1320) {
      $("#2004").addClass("fade");
    } 
    if (scroll > 1530) {
      $("#2005").addClass("fade");
    } 
    if (scroll > 1780) {
      $("#2006").addClass("fade");
    } 
    if (scroll > 2010) {
      $("#2008").addClass("fade");
    } 
    if (scroll > 2300) {
      $("#2009").addClass("fade");
    } 
    if (scroll > 2550) {
      $("#2010").addClass("fade");
    } 
    if (scroll > 2750) {
      $("#2011").addClass("fade");
    } 
    if (scroll > 3000) {
      $("#2012").addClass("fade");
    } 
    if (scroll > 3050) {
      $("#2013").addClass("fade");
    } 
	}).trigger('scroll');

  $("#submit").click(function(e) {
    e.preventDefault();

    $.ajax({
      type: "POST",
      url: '/',
      data: $("#RSVP form").serialize(), // serializes the form's elements.
      success: function(data) {
        var rsvp = JSON.parse(data);
        window.rsvp = rsvp;
        if (rsvp.attending) {
          $('#thanks p').text('See you at the party, ' + rsvp.name.split(' ')[0] + '!');
          $('#thanks').foundation('reveal', 'open');
        } else {
          $('#thanks p').text('Sorry we won\'t be seeing you!');
          $('#thanks').foundation('reveal', 'open');
        }
      }
     });

  });
	
}( Foundation.zj ));