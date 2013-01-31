define [
  'backbone'
  'backbone.marionette'
  './views/search'
  './search-controller'
  './views/tabs'
  'modules/util/radio-view'
], (Backbone, Marionette, SearchView, SearchController, TabsView, RadioView) ->

  Marionette.Layout.extend
    template: 'domain/editors'

    regions:
      'tabsRegion': '.tabs'
      'bodyRegion': '.body'

    initialize: (options) ->
      @tabsCollection = new Backbone.Collection
      @tabsView = new TabsView
        collection: @tabsCollection

      @bodyView = new RadioView

      @listenTo @tabsView, 'new', =>
        @addNewTab 'Untitled'

      @listenTo @tabsView, 'select', (tab) =>
        view = tab.view
        @bodyView.show view

    onShow: ->
      @tabsRegion.show @tabsView
      @bodyRegion.show @bodyView

      @addNewTab 'Untitled'

    addNewTab: (title) ->
      searchController = new SearchController

      searchView = searchController.view
      @bodyView.add searchView

      @tabsCollection.each (tab) ->
        tab.set selected: false

      tab = new Backbone.Model
        title: title
        selected: true
      tab.view = searchView

      @tabsCollection.add tab

    onClose: ->
