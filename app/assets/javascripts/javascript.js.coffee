# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('html').click (event) ->
     if event.target.id != "dropdown" && $('.dropdown').is(':visible')
        $('.dropdown').hide()

  $('#dropdown').click (event) ->
     if $('.dropdown').is(':visible')
        $('.dropdown').hide()
     else
        $('.dropdown').show()
       