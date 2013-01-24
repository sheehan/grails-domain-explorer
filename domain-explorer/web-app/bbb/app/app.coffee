define [
  "handlebars",
  "./modules/util/stackregion"
  "backbone.marionette"
], (Handlebars, StackRegion, Marionette) ->

  # Provide a global location to place configuration settings and module
  # creation.
  app = new Backbone.Marionette.Application(

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
  )
  app.addRegions
    content:
      selector:"#main-content"
      regionType: StackRegion

  Marionette.Renderer.render = (template, data) -> JST[template] data

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
