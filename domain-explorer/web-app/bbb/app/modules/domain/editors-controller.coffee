define [
  'backbone.marionette'
  './views/search'
  './views/show'
  './views/show-section'
  './tabs-controller'
  './search-controller'
], (Marionette, SearchView, ShowView, ShowSectionView, TabsController, SearchController) ->
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