# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# @author Ravi

togglePassword = (inputPassword, inputPasswordImage) -> 
  passwordInput = $(inputPassword)
  if passwordInput.attr('type') is 'text'
    $(inputPasswordImage).attr('src', '/assets/rblog_password_secure')
    passwordInput.attr('type', 'password')
  else
    $(inputPasswordImage).attr('src', '/assets/rblog_password_not_secure')
    passwordInput.attr('type', 'text')
  passwordInput.focus()
  passwordInput.prop('selectionStart', passwordInput.val().length)
  

$(document).on 'click', '.toggle_password', (event) ->
  event.preventDefault()
  togglePassword('.input_password', '.input_password_image')


$(document).on 'click', '.toggle_password_old', (event) ->
  event.preventDefault()
  togglePassword('.input_password_old', '.input_password_image_old')


$(document).on 'click', '.toggle_comments', (event) -> 
  event.preventDefault()
  $('.section_comments').fadeToggle()
  $('html, body').animate({ scrollTop: $(document).height() }, 'slow')
