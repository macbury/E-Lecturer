form_submit = (event) ->
  event.preventDefault()
  form_container  = $('#new_post_form')
  form            = $('#new_post_form form')

  data = form.serialize()
  $(form).loader(true)

  handle_post_form = (html) ->
    $(form).loader(false)
    form_container.empty().append(html)
    bind_form()

  $.ajax
    type:     "POST"
    url:      form.attr("action")
    data:     data
    statusCode:
      200: (rsp) ->
        handle_post_form(rsp)
      422: (rsp) -> handle_post_form(rsp.responseText)

  return false



bind_form = ->
  $('.new_post').on "submit", form_submit

$.for "#new_post_form", ->
  bind_form()