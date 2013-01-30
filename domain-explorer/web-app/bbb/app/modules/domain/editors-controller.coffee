define [
  'backbone.marionette'
  './views/search'
  './search-controller'
  './views/tabs-section'
], (Marionette, SearchView, SearchController, TabsSectionView) ->
  Marionette.Controller.extend
    initialize: (options) ->
      @region = options.region

      @tabsSectionView = new TabsSectionView

      @listenTo @tabsSectionView, 'new', =>
        @addNewTab 'Untitled'

      @region.show @tabsSectionView

      @addNewTab 'Untitled'

    addNewTab: (title) ->
      searchController = new SearchController

      searchView = searchController.view
      @tabsSectionView.addView title, searchView

    onClose: ->
