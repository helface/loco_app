# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
   update_crop = (coords) ->    
      ratio = $('#cropbox').data('ratio')
      $('#crop_x').val(Math.floor(coords.x * ratio))
      $('#crop_y').val(Math.floor(coords.y * ratio))
      $('#crop_w').val(Math.floor(coords.w * ratio))
      $('#crop_h').val(Math.floor(coords.h * ratio))

   $('#cropbox').Jcrop
      onChange: update_crop
      onSelect: update_crop
      setSelect: [0, 0, 540, 385]
      aspectRatio: 0