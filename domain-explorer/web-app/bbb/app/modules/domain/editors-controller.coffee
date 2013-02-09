define [
  'backbone'
  'backbone.marionette'
  './views/search'
  './views/search-section'
  './views/tabs'
  'modules/util/radio-view'
], (Backbone, Marionette, SearchView, SearchSectionView, TabsView, RadioView) ->

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

      searchView = new SearchSectionView
      @bodyView.add searchView

      @tabsCollection.each (tab) ->
        tab.set selected: false

      tab = new Backbone.Model
        title: title
        selected: true
      tab.view = searchView

      @tabsCollection.add tab

    onClose: ->
