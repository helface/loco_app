# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

JQuery ->
	cities = $('#hostprofile_city_name').html()
	console.log(cities)
	$('#person_country_name').change ->
		country = $('#hostprofile_country_name :select').text()
		escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1') 	
		options = $(cities).filter("optgroup[lable=#{escaped_country}]").html()
		console.log(options)
		if options
			$('#person_city_name').html(options)
		else
			$('#person_city_name').empty()
			$('#person_city_name').parent().hide()
