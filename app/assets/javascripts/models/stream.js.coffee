class Model.Stream extends Backbone.Model
  view: null
  initialize: (attributes) =>
    @view = new UI.Stream(model: this)

class Collection.Streams extends Backbone.Collection
  model: Model.Stream

  comparator: (model) => @get("created_at")