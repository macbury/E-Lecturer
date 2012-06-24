class UI.Wall extends Backbone.View
  el: ".stream"

  events:
    "submit #new_post_form form": "send"
    "click .more"        : "nextPage"
  initialize: =>
    @form_container     = @$('#new_post_form')
    @form               = @form_container.find("form")
    @items              = @$(".items")
    @more_button        = @$(".more")
    @streamsCollection  = new Collection.Streams(Data.streams)
    @streamsCollection.on "add", @appendOne
    @more_button.hide()
    @addAll()
    @updateUI()

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
        500: (rsp) => ServerError(rsp)

  addAll: =>
    @items.empty()
    @streamsCollection.sort()
    @streamsCollection.each(@appendOne)
    @updateUI()
  appendOne:  (model) => @items.append(model.view.el)
  prependOne: (model) => 
    $(model.view.el).hide()
    @items.prepend(model.view.el)
    $(model.view.el).slideDown(500)

  nextPage: (event) =>
    event.preventDefault()
    Data.pagination.page += 1
    @more_button.button("loading")
    $.getJSON @more_button.attr("href"), { page: Data.pagination.page, format: "json" }, (response) =>
      @streamsCollection.add(response)
      @updateUI()

  updateUI: =>
    @more_button.button("reset")
    @form.find("textarea").autogrow(min_height: 64)
    if Data.pagination.page_count > Data.pagination.page
      @more_button.show()
    else
      @more_button.hide()


$.for ".stream", -> Interface.Wall = new UI.Wall()