# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
   $("input.datepicker").each (i) ->
      $(this).datepicker
         altFormat: "yy-mm-dd"
         dateFormat: 'DD, d MM, yy'
         altField: $(this).next()
         minDate: +2