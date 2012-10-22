# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
   $('#hostprofile_language_tokens').tokenInput '/languages.json'
      theme:'facebook'
      preventDuplicates: true
      hintText: 'input your languages'
      prePopulate: $('#hostprofile_language_tokens').data('load')

   $('#user_language_tokens').tokenInput '/languages.json'
      theme:'facebook'
      preventDuplicates: true
      hintText: 'input your languages'
      prePopulate: $('#user_language_tokens').data('load')