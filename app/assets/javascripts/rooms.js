$(function() {
  $(document).on('turbolinks:load', function() {
    $(window).scrollTop($('#message-wrapper').height());
  });
});
