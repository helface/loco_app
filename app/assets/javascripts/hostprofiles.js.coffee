# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
   $('#hostprofile_language_tokens').tokenInput '/languages.json'
      theme:'facebook'

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

   $('#hostprofile_other_exchange').change ->
      method = $('#hostprofile_other_exchange :selected').text()
      if method == "language practice"
         $('#exchange_option').append("<label>language</label> <input size='30' type='text' />")
      else if method == "money"
         alert(method)
      else
         $('#exchange_option').hide()
      
      