class UI.Stream extends Backbone.View
  model: null

  events:
    "click a.close": "confirmTrash"
    "click a.comments_button": "showCommentForm"

  initialize: (options) =>
    @model = options.model
    @model.on "remove", @remove
    #@model.on "sync", alert("removed")
    @render()

  confirmTrash: (event) =>
    event.preventDefault()
    if confirm("Czy na pewno chcesz usunąć ten wpis?")
      @model.destroy()
      $.post @$('a.close').attr("href"), { _method: "delete" }, -> console.log "test"
  
  remove: =>
    $(@el).slideUp 500, => $(@el).remove()

  render: =>
    $(@el).html(@model.get("html"))
    @$("time").timeago()
    @$(".have_tooltip").tooltip()
    @$('.body').truncate()

    @comments     = @$(".comments")
    @commentsForm = @comments.find("form")
    @commentsForm.find("textarea").autogrow(min_height: 64)

  showCommentForm: (event) =>
    event.preventDefault()
    @commentsForm.show()
    @commentsForm.find("textarea").focus()

