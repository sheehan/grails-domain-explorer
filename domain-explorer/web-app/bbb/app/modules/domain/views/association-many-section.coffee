define [
  'backbone.marionette'
  './results'
  './association-many-toolbar'
], (Marionette, ResultsView, ToolbarView) ->

  Marionette.ItemView.extend
    template: 'domain/association-many-section'

    className: 'view-association-many-section'

    initialize: (options) ->
      @clazz = options.clazz

      @toolbarView = new ToolbarView
        collection: @collection

      @resultsView = new ResultsView
        clazz: @clazz
        collection: @collection

      @addSubview '.toolbar-container', @toolbarView
      @addSubview '.results-container', @resultsView

    showItems: ->
      @resultsView.showItems()