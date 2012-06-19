class UI.Wall extends Backbone.View
  el: ".stream"

  events:
    "submit #new_post_form form": "send"

  initailize: =>
    @form_container     = @$('#new_post_form')
    @form               = @$('#new_post_form')
    @items              = @$(".items")
    @streamsCollection  = new Collection.Streams()

    @streamsCollection.on "reset", @addAll

  handle_post_form: (response) =>
    @form.loader(false)
    form_container.empty().html(response.form)
    if response.stream
      model = new Model.Stream(response.stream)
      @streamsCollection.add(model, at_index: 0, silent: true)
      @prependOne(model)

  send: (event) =>
    event.preventDefault()
    @form.loader(true)
    data = @form.serialize()

    $.ajax
      type:     "POST"
      url:      @form.attr("action")
      data:     data
      statusCode:
        200: (rsp) => @handle_post_form(rsp)
        422: (rsp) => @handle_post_form({ form: rsp.responseText })

  addAll: =>
    @items.empty()
    @streamsCollection.sort()
    @streamsCollection.each(@appendOne)
  appendOne:  (model) => @items.append(model.view)
  prependOne: (model) => @items.prepend(model.view)


$.for "#new_post_form", ->
  Interface.Wall = new UI.Wall()