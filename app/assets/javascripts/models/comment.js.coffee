class Model.Comment extends Backbone.Model
  view: null
  initialize: (attributes) =>
    console.log attributes


class Collection.Comments extends Backbone.Collection
  model: Model.Comment
  localStorage: new Store("comments"),
  comparator: (model) => @get("created_at")