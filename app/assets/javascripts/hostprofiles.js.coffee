# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

# TODO: this might need to be refactored to be more dynamic
   $('#hostprofile_service').change ->
      type = $('#hostprofile_service :selected').text()
      switch type
         when "local insider" then $('#service_desc').replaceWith("<small id='service_desc'> take visitor around the city </small>")
         when "meal companion" then $('#service_desc').replaceWith("<small id='service_desc'> share a meal, cook a meal, love a meal</small>")
         when "shopping buddy" then $('#service_desc').replaceWith("<small id='service_desc'> go shopping together, show them the hard to find boutiques and the best sales. </small>")
         when "translator" then $('#service_desc').replaceWith("<small id='service_desc'> help your guests by translating </small>")
         when "schoefer" then $('#service_desc').replaceWith("<small id='service_desc'> drive your guests around </small>")
         when "advanture guide" then $('#service_desc').replaceWith("<small id='service_desc'> you know the best spots, give them your expert advise </small>")
         when "nightlife expert" then $('#service_desc').replaceWith("<small id='service_desc'> show them the best bars and hot spots to hang out </small>")
         else
            $('#service_desc').replaceWith("<p>asdfasdfasdfsadf</p>")

   
   cities = $('#hostprofile_city_id').html()
   console.log(cities)
   $('#hostprofile_country_id').change ->
      country = $('#hostprofile_country_id :selected').text()
      escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1') 
      options = $(cities).filter("optgroup[label=#{escaped_country}]").html()
      if options
         $('#hostprofile_city_id').html(options)
         $('#hostprofile_city_id').parent().show()
      else
         $('#hostprofile_city_id').empty()
         $('#hostprofile_city_id').parent().hide()

   $('#hostprofile_exchange_type').change ->
      method = $('#hostprofile_exchange_type :selected').text()
      if method == "money"
         $('#price_opt').show()
         $('#lang_opt').hide()
      else if method == "language practice"
         $('#price_opt').hide()
         $('#lang_opt').show()
      else
         $('#price_opt').hide()
         $('#lang_opt').hide()

   $("#deactivate_host").click ->
      $("#deactivate_host_block").show()

      
