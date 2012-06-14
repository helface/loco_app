# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#hostprofile_languages').chosen()

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
