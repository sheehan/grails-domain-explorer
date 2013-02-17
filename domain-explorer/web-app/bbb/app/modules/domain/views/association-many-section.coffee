define [
  './item-view'
  './results'
  './association-many-toolbar'
], (ItemView, ResultsView, ToolbarView) ->

  ItemView.extend
    template: 'domain/association-many-section'

    className: 'view-association-many-section'

    initialize: (options) ->
      @clazz = options.clazz

      @toolbarView = new ToolbarView
        collection: @collection

      @resultsView = new ResultsView
        clazz: @clazz
        collection: @collection


      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model

      @addSubview '.toolbar-container', @toolbarView
      @addSubview '.results-container', @resultsView

    showItems: ->
      @resultsView.showItems()