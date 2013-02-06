define [
  'app'
  'underscore'
  'backbone'
  'backbone.marionette'
  './query'
  './results'
  '../collections/instances'
  'layout'
], (app, _, Backbone, Marionette, QueryView, ResultsView, InstanceCollection) ->

  Marionette.ItemView.extend
    template: 'domain/search'

    className: 'view-search'

    initialize: (options) ->
      @instances = new InstanceCollection

      @queryView = new QueryView
      @resultsView = new ResultsView collection: @instances

      @listenTo app, 'execute', =>
        @execute() if @$el.is ':visible'

      @listenTo @queryView, 'execute', => @execute()

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model, @instances.clazz

      @addSubview '.query-container', @queryView
      @addSubview '.results-container', @resultsView

      @listenTo app, 'resize', => @resize()

    onShow: ->
      @resize()

    execute: ->
      @instances.search @queryView.getQuery()

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        north__size: 200
        center__paneSelector: '.results-container'
        resizable: true
        closable: false
        findNestedContent: true
        onresize: =>
          @queryView.resize()
          @resultsView.resize()
      @queryView.resize()
      @resultsView.resize()

