define [
  'app'
  'backbone.marionette'
  './query'
  './results'
  'layout'
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

      queryView.on 'execute', (query) ->
        url = app.createLink('domain', 'executeQuery')
        dfd = $.post url,
          query: query
        dfd.done (resp) ->
          items = resp.value
          clazz = resp.clazz
          resultsView.showItems items, clazz

      @queryRegion.show queryView
      @resultsRegion.show resultsView

    onShow: ->
      @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'

