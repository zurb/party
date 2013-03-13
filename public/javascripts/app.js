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

    if ($(this).height() > 3050) {
      $('#1998, #1999, #2000, #2001, #2002, #2003, #2004, #2005, #2006, #2007, #2008, #2009, #2010, #2011, #2012, #2013')
        .addClass('fade');
    }
	}).trigger('scroll');

  $('#reserve')
    .h5Validate()
    .on('keyup', function () {
      if ($('input.ui-state-error').length < 1) {
        $("#submit").removeClass('disabled');
      } else {
        $("#submit").addClass('disabled');
      }
    });

  $("#submit").click(function(e) {
    e.preventDefault();
    if ($(this).hasClass('disabled')) return false;

    $.ajax({
      type: "POST",
      url: '/15',
      data: $("form").serialize(), // serializes the form's elements.
      success: function(data) {
        var rsvp = data;
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