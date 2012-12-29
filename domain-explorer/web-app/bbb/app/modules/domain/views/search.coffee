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

    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    onRender: ->
      queryModel = new QueryModel
      resultsModel = new ResultsModel

      queryView = new QueryView model: queryModel
      resultsView = new ResultsView model: resultsModel

      @resultsView = resultsView

      queryView.on 'execute', ->
        queryModel.execute().done (resp) ->
          resultsModel.set
            items: resp.value
            clazz: resp.clazz

      @queryRegion.show queryView
      @resultsRegion.show resultsView

    resize: ->
      console.log @$el.is(':visible')
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

