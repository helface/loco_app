# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

# TODO: this might need to be refactored to be more dynamic
   $('#hostprofile_service').change ->
      type = $('#hostprofile_service :selected').text()
      switch type
         when "local insider" then $('#service_desc').html("You can show travelers around better than any giant tour company with ugly buses can.")
         when "meal companion" then $('#service_desc').html("Show off your cooking to travelers or share a meal with them at your favourite restaurant.")
         when "shopping buddy" then $('#service_desc').html("Take travelers shopping, because you know the best shops and how to pay 20% less than the price tag.")
         when "translator" then $('#service_desc').html("Welcome travelers by helping them communicate with the locals.")
         when "chauffeur" then $('#service_desc').html("Take travelers whereever they need to go, in your car, in your tuk tuk, in your space shuttle... ")
         when "adventure guide" then $('#service_desc').html("Guide risk taking travelers on the most amazing adventures your area has to offer. Do keep them safe though.")
         when "nightlife expert" then $('#service_desc').html("You know all the great bars, nightclubs, and parties. Show travelers how to hit the town local style.")
   
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

   $("#host_description").click ->
      url = $("#host_description").data('url')
      window.open(url, "about", "height=700, width=700")

   $("#deactivate_host").click ->
      $("#deactivate_host_block").show()

   $("#hostprofile_intro").keydown( (e) ->
       remaining = 139 - $("#hostprofile_intro").val().length
       $("#charcount").html(remaining)
    )
      

      
