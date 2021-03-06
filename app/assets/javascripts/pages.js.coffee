###global $:false, ClientSideValidations:false###
'use strict'

# Prevent disabled links from being clicked
# Bind to document, so this is compatible with turbolinks
$(document).on 'click', 'a.disabled', (e) ->
  e.preventDefault()

$(document).on 'click', '.btn-learn-more', (e) ->
  e.preventDefault()
  $('html, body').animate
    scrollTop: $('#learn-more').offset().top
  , 'slow'

if ClientSideValidations?
  ClientSideValidations.callbacks.element.fail = (element, message, callback, eventData) ->
    unless element.data('valid')
      element.closest('div.control-group').addClass 'error'

      if element.closest('form').hasClass 'form-inline'
        error_message = "<label for='#{element.attr("id")}' class='message'>#{message}</label>"
        $error_container = element.parent().find 'label.message'
      else
        error_message = "<span class='help-inline'>#{message}</span>"
        if element.parent().hasClass('input-prepend') or element.parent().hasClass('input-append')
          $error_container = element.parent().parent().find 'span.help-inline'
        else
          $error_container = element.parent().find 'span.help-inline'

      if $error_container[0]
        $error_container.text(message).show()
      else
        if element.parent().hasClass('input-prepend') or element.parent().hasClass('input-append')
          element.parent().after error_message
        else
          element.parent().find("#{element[0].tagName}:last").after error_message
    callback

  ClientSideValidations.callbacks.element.pass = (element, callback, eventData) ->
    element.closest('div.control-group').removeClass 'error'
    element.parent().find('label.message').hide()
    if element.parent().hasClass('input-prepend') or element.parent().hasClass('input-append')
      element.parent().parent().find('span.help-inline').hide()
    else
      element.parent().find('span.help-inline').hide()
    return
