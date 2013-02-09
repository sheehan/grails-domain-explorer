define [
  'app'
  'underscore'
  'backbone'
  'backbone.marionette'
  './query'
  './results'
  './results-toolbar'
  '../collections/instances'
  'layout'
], (app, _, Backbone, Marionette, QueryView, ResultsView, ResultsToolbarView, InstanceCollection) ->

  Marionette.ItemView.extend
    template: 'domain/search'

    className: 'view-search'

    initialize: (options) ->
      @instances = new InstanceCollection

      @queryView = new QueryView
      @resultsToolbarView = new ResultsToolbarView collection: @instances
      @resultsView = new ResultsView collection: @instances

      @listenTo app, 'execute', =>
        @execute() if @$el.is ':visible'

      @listenTo @queryView, 'execute', => @execute()

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model

      @addSubview '.query-container', @queryView
      @addSubview '.toolbar-container', @resultsToolbarView
      @addSubview '.results-container', @resultsView

      @listenTo app, 'resize', => @resize()

    onShow: ->
      @layout = @$el.layout
        center__paneSelector: '.query-container'
        south__size: 500
        south__paneSelector: '.results-section'
        south__initClosed: true
        resizable: true
        closable: false
        findNestedContent: true
        onresize: => @resize()
      @resize()

    execute: ->
      @instances.search @queryView.getQuery()
      if @layout.state.south.isClosed
        @layout.sizePane 'south', @$el.height() - 200
        @layout.open 'south'

    resize: ->
      @queryView.resize()
      @resultsView.resize()

    onClose: ->
      @layout.destroy()

