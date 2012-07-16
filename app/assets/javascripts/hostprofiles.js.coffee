# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

# TODO: this might need to be refactored to be more dynamic
   $('#hostprofile_service').change ->
      type = $('#hostprofile_service :selected').text()
      switch type
         when "local know-it-all" then $('#service_desc').replaceWith("<p id='service_desc'> take visitor around the city </p>")
         when "meal companion" then $('#service_desc').replaceWith("<p id='service_desc'> share a meal, cook a meal, love a meal</p>")
         when "shopping buddy" then $('#service_desc').replaceWith("<p id='service_desc'> go shopping together, show them the hard to find boutiques and the best sales. </p>")
         when "translator" then $('#service_desc').replaceWith("<p id='service_desc'> help your guests by translating </p>")
         when "schoefer" then $('#service_desc').replaceWith("<p id='service_desc'> drive your guests around </p>")
         when "advanture guide" then $('#service_desc').replaceWith("<p id='service_desc'> you know the best spots, give them your expert advise </p>")
         when "nightlife expert" then $('#service_desc').replaceWith("<p id='service_desc'> show them the best bars and hot spots to hang out </p>")
         else
            $('#service_desc').replaceWith("<p>asdfasdfasdfsadf</p>")

   $('#hostprofile_language_tokens').tokenInput '/languages.json'
      theme:'facebook'
      preventDuplicates: true
      hintText: 'input your languages'
      prePopulate: $('#hostprofile_language_tokens').data('load')

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
         $('#exchange_option').show()
      else
         $('#exchange_option').hide()
      
