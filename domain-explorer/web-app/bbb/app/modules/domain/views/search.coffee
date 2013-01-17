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

    initialize: ->
      @queryModel = new QueryModel
      @instances = new InstanceCollection
      Mousetrap.bind ['command+enter', 'ctrl+enter'], (event) => @execute()


    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    onRender: ->
      queryView = new QueryView model: @queryModel
      resultsView = new ResultsView collection: @instances

      @resultsView = resultsView

      queryView.on 'execute', =>
        @execute()

      resultsView.on 'next', =>
        @queryModel.nextPage()
        @execute()

      resultsView.on 'prev', =>
        @queryModel.prevPage()
        @execute()

      resultsView.on 'row:click', (model) =>
        showView = new ShowView
          model: model
          clazz: @instances.clazz

        app.content.push showView

      @queryRegion.show queryView
      @resultsRegion.show resultsView

    execute: ->
      @instances.search @queryModel.get('query'), @queryModel.get('max'), @queryModel.get('offset')

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

    onClose: ->
      Mousetrap.unbind ['command+enter', 'ctrl+enter']

