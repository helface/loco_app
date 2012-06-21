# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#alert("newsrc")

jQuery ->
   $('.best_in_place').best_in_place()
   
   thumbrange = (num) -> 
      $("#imgthumb#{num}").click ->
         caption = $("#imgthumb#{num}").attr("caption")
         oldcaption = $('#displaycaption').html()
         if caption
            $("#displaycaption").replaceWith("<p id='displaycaption'>#{caption}</p>")
         else if oldcaption
            $("#displaycaption").replaceWith("<p id='displaycaption' style='height: 18px'></p>")   
         newsrc = $("#imgthumb#{num}").attr("src")
         $("#displayimg").replaceWith("<img id='displayimg' src='#{newsrc}' />")
      
   thumbrange x for x in [1..7]
   
   
   
