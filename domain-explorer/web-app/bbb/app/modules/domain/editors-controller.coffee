define [
  'backbone.marionette'
  './views/search'
  './tabs-controller'
  './search-controller'
], (Marionette, SearchView, TabsController, SearchController) ->
  Marionette.Controller.extend
    initialize: (options) ->
      @region = options.region

      @tabsController = new TabsController
        region: options.region

      @listenTo @tabsController, 'tab:new', =>
        @addNewTab 'Untitled'

      @addNewTab 'Untitled'

    addNewTab: (title) ->
      searchController = new SearchController

      searchView = searchController.view
      @tabsController.addView title, searchView