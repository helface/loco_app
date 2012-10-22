# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#alert("newsrc")

jQuery ->   
   thumbrange = (num) -> 
      $("#imgthumb#{num}").click ->
         # caption = $("#imgthumb#{num}").attr("caption")
         # oldcaption = $('#displaycaption').html()
         caption = $(this).data("caption")
         oldcaption = $('#displaycaption').html()
         if caption
            $("#displaycaption").replaceWith("<p id='displaycaption'>#{caption}</p>")
         else if oldcaption
            $("#displaycaption").replaceWith("<p id='displaycaption' style='height: 18px'></p>")   
         newsrc = $("#imgthumb#{num}").attr("src").replace('medium', 'large')
         id = $(this).data('id')
         $("#displayimg").replaceWith("<img id='displayimg' src='#{newsrc}' data-id='#{id}' />")
         img_path = "<a href='/images/#{id}'>"
         $("#displayimg").wrap(img_path)
         
   thumbrange x for x in [1..7]