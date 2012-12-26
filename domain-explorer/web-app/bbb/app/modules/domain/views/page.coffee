define [
  'backbone.marionette'
  './query'
], (Marionette, QueryView) ->
  Marionette.Layout.extend
    template: 'domain/page'

    className: 'page-domain'

    regions:
      'queryRegion': '.query-container'

    onRender: ->
      queryView = new QueryView
      @queryRegion.show queryView

