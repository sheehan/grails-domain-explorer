define [
  'app'
  'backbone.marionette'
  './query'
  './results'
], (app, Marionette, QueryView, ResultsView) ->
  Marionette.Layout.extend
    template: 'domain/page'

    className: 'page-domain'

    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    onRender: ->
      queryView = new QueryView
      resultsView = new ResultsView

      queryView.on 'execute', ->
        url = app.createLink('domain', 'executeQuery')
        dfd = $.post url,
          query: 'from Book'
        dfd.done (resp) ->
          items = resp.value
          clazz = resp.clazz
          resultsView.showItems items, clazz

      @queryRegion.show queryView
      @resultsRegion.show resultsView

