define [
  'backbone.marionette'
  './views/search'
  './views/show'
  './views/show-section'
  './tabs-controller'
  './show-controller'
  './search-controller'
], (Marionette, SearchView, ShowView, ShowSectionView, TabsController, ShowController, SearchController) ->
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
        region: @region

      searchView = searchController.view
      @tabsController.addView title, searchView