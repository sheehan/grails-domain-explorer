define [
  'app'
  'underscore'
  'backbone'
  'backbone.marionette'
  './query'
  './results'
  '../models/query'
  '../collections/instances'
  'layout'
], (app, _, Backbone, Marionette, QueryView, ResultsView, QueryModel, InstanceCollection) ->

  Marionette.ItemView.extend
    template: 'domain/search'

    className: 'view-search'

    initialize: (options) ->
      @queryModel = new QueryModel
      @instances = new InstanceCollection

      @queryView = new QueryView model: @queryModel
      @resultsView = new ResultsView collection: @instances

      @listenTo app, 'execute', => @execute()

      @listenTo @queryView, 'execute', => @execute()

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model, @instances.clazz

      @addSubview '.query-container', @queryView
      @addSubview '.results-container', @resultsView

    onShow: ->
      @resize()

    execute: ->
      @instances.search @queryModel.get('query')

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

