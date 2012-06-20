class UI.Wall extends Backbone.View
  el: ".stream"

  events:
    "submit #new_post_form form": "send"
    "click .items .more"        : "nextPage"
  initialize: =>
    @form_container     = @$('#new_post_form')
    @form               = @form_container.find("form")
    @items              = @$(".items")
    @more_button        = @items.find(".more")
    @streamsCollection  = new Collection.Streams(Data.streams)
    @streamsCollection.on "add", @appendOne
    @addAll()

  handle_post_form: (response) =>
    @form.loader(false)
    @form_container.empty().html(response.form) if response.form
    @form               = @$('#new_post_form form')
    @form_container     = @$('#new_post_form')
    if response.stream
      @form_container.find('.help-inline').remove()
      @form_container.find('.error').removeClass("error")
      @form[0].reset()
      model = new Model.Stream(response.stream)
      @streamsCollection.add(model, at_index: 0, silent: true)
      @prependOne(model)
    @updateUI()

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
    @updateUI()
  appendOne:  (model) => @items.append(model.view.el)
  prependOne: (model) => 
    @items.prepend(model.view.el)
    $(model.view.el).slideDown(500)

  nextPage: (event) =>
    event.preventDefault()
    Data.pagination.page += 1
    @more_button.button("loading")
    $.getJSON @more_button.attr("href"), { page: Data.pagination.page }, (response) =>
      @streamsCollection.add(response)
      @updateUI()

  updateUI: =>
    @more_button.button("reset")
    if Data.pagination.page_count > Data.pagination.page
      @more_button.show()
    else
      @more_button.hide()


$.for "#new_post_form", ->
  Interface.Wall = new UI.Wall()