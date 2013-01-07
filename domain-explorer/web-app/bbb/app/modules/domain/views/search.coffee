define [
  'app'
  'backbone.marionette'
  './query'
  './results'
  '../models/query'
  '../models/results'
  'layout'
], (app, Marionette, QueryView, ResultsView, QueryModel, ResultsModel) ->
  Marionette.Layout.extend
    template: 'domain/search'

    className: 'view-search'

    onDomRefresh: ->
#      @resize()
      console.log 'ref'
#      console.log @$el.is(':visible')

    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    onRender: ->
      queryModel = new QueryModel
      resultsModel = new ResultsModel

      queryView = new QueryView model: queryModel
      resultsView = new ResultsView model: resultsModel

      @resultsView = resultsView

      queryView.on 'execute', =>
        @execute queryModel, resultsModel

      resultsView.on 'next', =>
        queryModel.nextPage()
        @execute queryModel, resultsModel

      resultsView.on 'prev', =>
        queryModel.prevPage()
        @execute queryModel, resultsModel

      @queryRegion.show queryView
      @resultsRegion.show resultsView

    execute: (queryModel, resultsModel) ->
      queryModel.execute().done (resp) ->
        resultsModel.set
          items: resp.value
          clazz: resp.clazz

    resize: ->
      console.log 'hi'
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

