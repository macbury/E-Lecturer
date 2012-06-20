class UI.Stream extends Backbone.View
  model: null

  events:
    "click button.close": "confirmTrash"

  initialize: (options) =>
    @model = options.model
    @model.on "remove", @remove
    @render()

  confirmTrash: (event) =>
    event.preventDefault()
    if confirm("Czy na pewno chcesz usunąć ten wpis?")
      alert("OK :P")
  
  remove: =>
    $(@el).slideUp 500, => $(@el).remove()

  render: =>
    $(@el).html(@model.get("html"))
    @$(".have_tooltip").tooltip()