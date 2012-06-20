class UI.Stream extends Backbone.View
  model: null

  events:
    "click a.close": "confirmTrash"

  initialize: (options) =>
    @model = options.model
    @model.on "remove", @remove
    #@model.on "sync", alert("removed")
    @render()

  confirmTrash: (event) =>
    event.preventDefault()
    if confirm("Czy na pewno chcesz usunąć ten wpis?")
      @model.destroy()
  
  remove: =>
    $(@el).slideUp 500, => $(@el).remove()

  render: =>
    $(@el).html(@model.get("html"))
    @$("time").timeago()
    @$(".have_tooltip").tooltip()