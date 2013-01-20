define [
  'app'
  'backbone.marionette'
  './search'
  'layout'
], (app, Marionette, SearchView) ->
  Marionette.Layout.extend
    template: 'domain/page'

    className: 'page-domain'

    regions:
      'mainRegion': '.main-container'

    onRender: ->
      @searchView = new SearchView

    onShow: ->
      @mainRegion.show @searchView
      @searchView.resize()



