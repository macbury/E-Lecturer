class UI.Stream extends Backbone.View
  model: null

  initialize: (options) =>
    @model = options.model
    @render()
    
  render: =>
    $(@el).html(model.get("html"))