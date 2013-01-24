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

    initialize: (options) ->
      console.log options
      @showController = options.showController

    onRender: ->
      @searchView = new SearchView
        showController: @showController

    onShow: ->
      @mainRegion.show @searchView
      @searchView.resize()



