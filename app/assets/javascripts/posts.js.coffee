# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
    $(".like")
      .bind "ajax:success", (event, data) ->
        $(this).siblings('.unlike').show();
        $(this).hide();

    $(".unlike")
      .bind "ajax:success", (event, data) ->
        $(this).siblings('.like').show();
        $(this).hide();
