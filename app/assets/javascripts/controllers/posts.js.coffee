bind_timeline = -> console.log "timeline"

form_submit = (event) ->
  event.preventDefault()
  form_container  = $('#new_post_form')
  form            = $('#new_post_form form')

  data = form.serialize()
  $(form).loader(true)

  handle_post_form = (rsp) ->
    $(form).loader(false)
    form_container.empty().append(rsp.form)
    if rsp.post
      $('.items').prepend(rsp.post)
      bind_timeline()
    bind_form()

  $.ajax
    type:     "POST"
    url:      form.attr("action")
    data:     data
    statusCode:
      200: (rsp) ->
        handle_post_form(rsp)
      422: (rsp) -> handle_post_form({ form: rsp.responseText })

  return false



refresh_timeline: ->

bind_form = ->
  $('.new_post').on "submit", form_submit

$.for "#new_post_form", ->
  bind_form()
  bind_timeline()