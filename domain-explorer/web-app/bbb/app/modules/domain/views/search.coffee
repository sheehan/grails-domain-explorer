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
  Marionette.Layout.extend
    template: 'domain/search'

    className: 'view-search'

    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    initialize: (options) ->
      @queryModel = new QueryModel
      @instances = new InstanceCollection

      @queryView = new QueryView model: @queryModel
      @resultsView = new ResultsView collection: @instances

      @listenTo app, 'execute', => @execute()

      @listenTo @queryView, 'execute', =>
        @execute()

      @listenTo @resultsView, 'next', =>
        @queryModel.nextPage()
        @execute()

      @listenTo @resultsView, 'prev', =>
        @queryModel.prevPage()
        @execute()

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model, @instances.clazz

    onShow: ->
      @queryRegion.show @queryView
      @resultsRegion.show @resultsView
      @resize()


    execute: ->
      @instances.search @queryModel.get('query'), @queryModel.get('max'), @queryModel.get('offset')

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

