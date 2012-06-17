gid = 0

build_plugin = (element, trigger) ->
  element = $(element)
  uid = element.data("loader-uid")
  if uid == null
    uid = gid
    gid += 1
    element.data("loader-uid", uid)


  position  = element.position()
  width     = element.width()
  height    = element.height()

  loader_id = "fancy_loader_#{uid}"

  loader_bg = $("##{loader_id}}")
  if loader_bg.size() == 0
    loader_bg = $('<div class="loader-fader" />')
    loader_bg.attr "id", loader_id
    loader_bg.append "<div class='icon'/>"
    $('body').append loader_bg

  loader_bg.css 
    left:   position.left + "px"
    top:    position.top + "px"
    width:  width + "px"
    height: height + "px"

  icon = loader_bg.find(".icon")
  icon_height = icon.height()
  icon_margin = Math.round(height / 2) - icon_height

  icon.css
    "margin-top": "#{icon_height}px"

  if trigger
    loader_bg.show()
  else
    loader_bg.hide()

$.fn.loader = (trigger) ->
  $(this).each (index, element) -> build_plugin(element, trigger)