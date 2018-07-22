# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  displayCode = (text) ->
    $("#menu_detail")[0].value = unsanitize text

  $('#menu_code').on 'change', ->
    displayCode codes[this.selectedIndex]

unsanitize = (str) ->
  str.replace(/&lt;/g, '<')
     .replace(/&gt;/g, '>')
     .replace(/&amp;/g, '&')
     .replace(/\<br\ \/\>/g, "\n")
     .replace(/&quot;/g, '"')
     .replace(/&#39;/g, "'")

