define [
  'backbone'
  './views/item-view'
  './views/search-section'
  './views/tabs'
  'modules/util/radio-view'
], (Backbone,  ItemView, SearchSectionView, TabsView, RadioView) ->

  ItemView.extend
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
