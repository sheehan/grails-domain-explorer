define [
  "handlebars",
  "./modules/util/dom-utils"
  "backbone"
  "backbone.marionette"
], (Handlebars, DomUtils, Backbone, Marionette) ->

  # Provide a global location to place configuration settings and module
  # creation.
  app = new Backbone.Marionette.Application

    # The root path to run the application.
    root: "/bookstore/plugins/domain-explorer-0.1/bbb/" # TODO,
    start: (options) ->
      @options = options
      Backbone.Marionette.Application::start.apply this, arguments

    createLink: (controller, action, params) ->
      url = @options.serverURL + "/" + controller
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

  app
