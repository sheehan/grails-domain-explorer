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

      queryView.on 'execute', () ->
        queryModel.execute().done (resp) ->
          items = resp.value
          clazz = resp.clazz
          resultsView.showItems items, clazz

      @queryRegion.show queryView
      @resultsRegion.show resultsView

    onShow: ->
      console.log 'onShow'

    resize: ->
      console.log @$el.is(':visible')
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

