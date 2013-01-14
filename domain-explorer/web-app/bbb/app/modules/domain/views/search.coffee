define [
  'app'
  'backbone.marionette'
  './query'
  './results'
  './show'
  '../models/query'
  '../collections/instances'
  'layout'
], (app, Marionette, QueryView, ResultsView, ShowView, QueryModel, InstanceCollection) ->
  Marionette.Layout.extend
    template: 'domain/search'

    className: 'view-search'

    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    onRender: ->
      queryModel = new QueryModel
      instances = new InstanceCollection

      queryView = new QueryView model: queryModel
      resultsView = new ResultsView collection: instances

      @resultsView = resultsView

      queryView.on 'execute', =>
        @execute queryModel, instances

      resultsView.on 'next', =>
        queryModel.nextPage()
        @execute queryModel, instances

      resultsView.on 'prev', =>
        queryModel.prevPage()
        @execute queryModel, instances

      resultsView.on 'row:click', (model) =>
        showView = new ShowView
          model: model
          clazz: instances.clazz

        app.content.push showView

      @queryRegion.show queryView
      @resultsRegion.show resultsView

    execute: (queryModel, instances) ->
      instances.search queryModel.get('query'), queryModel.get('max'), queryModel.get('offset')

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

