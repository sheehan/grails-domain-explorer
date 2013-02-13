define [
  'backbone.marionette'
  './results'
  './results-toolbar'
], (Marionette, ResultsView, ResultsToolbarView) ->

  Marionette.ItemView.extend
    template: 'domain/results-section'

    initialize: ->
      @resultsToolbarView = new ResultsToolbarView collection: @collection
      @resultsView = new ResultsView collection: @collection

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model

      @addSubview '.toolbar-container', @resultsToolbarView
      @addSubview '.results-container', @resultsView

    resize: ->
      @resultsView.resize()