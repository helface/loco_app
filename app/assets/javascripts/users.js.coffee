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
         if caption && oldcaption
            $("#displaycaption").replaceWith("<p id='displaycaption'>#{caption}</p>")
         else if caption
            $("#caption").append("<p id='displaycaption'>#{caption}</p>")
         else if oldcaption
            $("#displaycaption").detach()
         newsrc = $("#imgthumb#{num}").attr("src")
         adjust = if !caption then "width: 100%; height: 380px" else ""
         alert(adjust)
         $("#displayimg").replaceWith("<img id='displayimg' src='#{newsrc}' style='#{adjust}' />")
      
   thumbrange x for x in [1..7]
   
   
   
