define [
  'app'
  'backbone.marionette'
], (app, Marionette) ->

  Marionette.ItemView.extend

    constructor: () ->
      @subviews = []
      Marionette.ItemView::constructor.apply @, arguments

    render: ->
      @isClosed = false
      @triggerMethod "before:render", @
      @triggerMethod "item:before:render", @
      data = @serializeData()
      data = @mixinTemplateHelpers data
      html = @renderHtml data
      @$el.html html
      @bindUIElements()
      @triggerMethod "render", @
      @triggerMethod "item:rendered", @

    renderHtml: (data) ->
      template = @getTemplate()
      Marionette.Renderer.render template, data

    addSubview: (selector, view) ->
      @listenTo @, 'render', =>
        view.render()
        @$(selector).append view.el

      @listenTo @, 'close', -> view.close()
      @listenTo @, 'show', ->
        @triggerMethod.call(view, 'show')

      @subviews.push view

    recurseMethod: (method) ->
      @triggerMethod.call @, method
      view.recurseMethod method for view in @subviews

