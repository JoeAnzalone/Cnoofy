# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
    $(".follow")
      .bind "ajax:success", (event, data) ->
        $(this).siblings('.unfollow').show();
        $(this).hide();

    $(".unfollow")
      .bind "ajax:success", (event, data) ->
        $(this).siblings('.follow').show();
        $(this).hide();
