# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

   cities = $('#forumpost_city_id').html()
   $('#forumpost_country_id').change ->
      country = $('#forumpost_country_id :selected').text()
      escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1') 
      options = $(cities).filter("optgroup[label=#{escaped_country}]").html()
      if options
         $('#forumpost_city_id').html(options)
         $('#forumpost_city_id').parent().show()
      else
         $('#forumpost_city_id').empty()
         $('#forumpost_city_id').parent().hide()
         
   $('#forumpost_date').datepicker
      dateFormat: 'yy-mm-dd'
      minDate: +1
      maxDate: +30