define [
  'backbone'
  'backbone.marionette'
  './views/search'
  './search-controller'
  './views/tabs'
  'modules/util/radio-view'
], (Backbone, Marionette, SearchView, SearchController, TabsView, RadioView) ->

  Marionette.ItemView.extend
    template: 'domain/editors'

    initialize: (options) ->
      @tabsCollection = new Backbone.Collection
      @tabsView = new TabsView
        collection: @tabsCollection

      @bodyView = new RadioView

      @listenTo @tabsView, 'new', => @addNewTab()

      @listenTo @tabsView, 'select', (tab) =>
        view = tab.view
        @bodyView.show view

      @addSubview '.tabs', @tabsView
      @addSubview '.body', @bodyView

    onShow: ->
      @addNewTab()


    addNewTab: ->
      title = 'Untitled' + (@tabsCollection.length + 1)
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
