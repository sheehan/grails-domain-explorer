define [
  "handlebars",
  "./modules/util/dom-utils"
  "backbone"
  "backbone.marionette"
  "mousetrap"
], (Handlebars, DomUtils, Backbone, Marionette, Mousetrap) ->

  # Provide a global location to place configuration settings and module
  # creation.
  app = new Backbone.Marionette.Application

    # The root path to run the application.
    root: "/bookstore/plugins/domain-explorer-0.1/bbb/" # TODO,
    start: (options) ->
      @options = options
      @baseUrl = @options.serverUrl
      Backbone.Marionette.Application::start.apply this, arguments

    createLink: (controller, action, params) ->
      url = @baseUrl + "/" + controller
      url += "/" + action  if action
      if params isnt `undefined`
        if params.id
          url += "/" + params.id
          delete params.id
        queryString = jQuery.param(params, true)
        url += "?" + queryString  if queryString.length > 0
      url

  app.addRegions
    content: "#main-content"

  # TODO move
  do (Mousetrap) ->
    _global_callbacks = {}
    _original_stop_callback = Mousetrap.stopCallback
    Mousetrap.stopCallback = (e, element, combo) ->
      return false  if _global_callbacks[combo]
      _original_stop_callback e, element, combo

    Mousetrap.bindGlobal = (keys, callback, action) ->
      Mousetrap.bind keys, callback, action
      if keys instanceof Array
        i = 0

        while i < keys.length
          _global_callbacks[keys[i]] = true
          i++
        return
      _global_callbacks[keys] = true


  Mousetrap.bindGlobal ['command+enter', 'ctrl+enter'], => app.trigger 'execute'

  DomUtils.sizeToFitVertical $('#main-content'), $('body')

  Marionette.Renderer.render = (template, data) -> JST[template] data

  _ensureElementOld = Backbone.View::_ensureElement

  Backbone.View::_ensureElement = ->
    _ensureElementOld.apply @, arguments
    @$el.data 'view', @
    @$el.attr 'data-view-cid', @cid

  # TODO hack!!
  Marionette.ItemView::render = ->
    @isClosed = false
    @triggerMethod "before:render", @
    @triggerMethod "item:before:render", @
    data = @serializeData()
    data = @mixinTemplateHelpers(data)
    html = @renderHtml(data)
    @$el.html html
    @bindUIElements()
    @triggerMethod "render", @
    @triggerMethod "item:rendered", @

  Marionette.ItemView::renderHtml = (data) ->
    template = @getTemplate()
    Marionette.Renderer.render(template, data)

  Marionette.View::addSubview = (selector, view) ->
    @listenTo @, 'render', =>
      view.render()
      @$(selector).append view.el

    @listenTo @, 'close', -> view.close()
    @listenTo @, 'show', ->
      Marionette.triggerMethod.call(view, 'show')

    @subviews ?= []
    @subviews.push view

  window.app = app
  app
