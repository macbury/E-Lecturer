class UI.Stream extends Backbone.View
  model: null

  events:
    "click a.close": "confirmTrash"
    "click a.comments_button": "showCommentForm"
    "keypress .comment_body": "enterSubmit"

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

    @updateUI()

  showCommentForm: (event) =>
    event.preventDefault() if event?
    @commentsForm.show()
    @commentsForm.find(".comment_body").autogrow().focus()

  enterSubmit: (event) =>
    charCode = event.which
    if charCode == 13
      event.preventDefault()
      $(@el).loader(true)
      data = @commentsForm.serialize()

      $.ajax
        type:     "POST"
        url:      @commentsForm.attr("action")
        data:     data
        statusCode:
          200: (rsp) => @handle_comment_form(rsp)
          422: (rsp) => @handle_comment_form({ form: rsp.responseText })
          500: (rsp) => ServerError(rsp)

  handle_comment_form: (response) =>
    $(@el).loader(false)
    @$('.commentable_form').empty().append(response.form) if response.form
    @updateUI()
    if response.comment
      @$('.commentable_form').find('.help-inline').remove()
      @$('.commentable_form').find('.error').removeClass("error")
      @commentsForm[0].reset()
      $(response.comment.html).insertBefore(@$('.commentable_form'))
    
    @commentsForm.show()

  updateUI: =>
    @comments     = @$(".comments")
    @commentsForm = @comments.find("form")
    @commentsForm.find(".comment_body").autogrow()
    @commentsForm.show() if @comments.find(".comment").size() > 0
