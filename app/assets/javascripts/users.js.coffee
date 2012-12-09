# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#alert("newsrc")

jQuery ->   
   thumbrange = (num) -> 
      $("#imgthumb#{num}").click ->  
         newsrc = $("#imgthumb#{num}").attr("src").replace('thumb', 'large')
         id = $(this).data('id')
         $("#displayimg").replaceWith("<img id='displayimg' src='#{newsrc}' data-id='#{id}' />")
         img_path = "<a href='/images/#{id}'>"
         $("#displayimg").wrap(img_path)
         
   thumbrange x for x in [1..7]