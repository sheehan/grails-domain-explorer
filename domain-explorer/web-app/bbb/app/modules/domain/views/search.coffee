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
      Mousetrap.bind ['command+enter', 'ctrl+enter'], (event) => @execute()

      @queryView = new QueryView model: @queryModel
      @resultsView = new ResultsView collection: @instances

      @listenTo @queryView, 'execute', =>
        @execute()

      @listenTo @resultsView, 'next', =>
        @queryModel.nextPage()
        @execute()

      @listenTo @resultsView, 'prev', =>
        @queryModel.prevPage()
        @execute()

      @listenTo @resultsView, 'row:click', (model) =>
        @showController.show model, @instances.clazz

      @showController = options.showController

    onShow: ->
      @queryRegion.show @queryView
      @resultsRegion.show @resultsView


    execute: ->
      @instances.search @queryModel.get('query'), @queryModel.get('max'), @queryModel.get('offset')

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

    onClose: ->
      @showController.close()
      Mousetrap.unbind ['command+enter', 'ctrl+enter']

