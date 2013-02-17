define [
  'app'
  './item-view'
  './results'
  './results-toolbar'
], (app, ItemView, ResultsView, ResultsToolbarView) ->

  ItemView.extend
    template: 'domain/results-section'

    initialize: ->
      @resultsToolbarView = new ResultsToolbarView collection: @collection
      @resultsView = new ResultsView collection: @collection

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model

      @listenTo @collection, 'reset', @render
      @listenTo @collection, 'request', @onLoading

      @addSubview '.toolbar-container', @resultsToolbarView
      @addSubview '.results-container', @resultsView

    onLoading: ->
      @$el.children().hide()
      html = app.tmpl 'loading-animation'
      @$el.append html

    onRender: ->
      @$('.loading-animation').remove()
      @resultsView.resize()

    resize: ->
      @resultsView.resize()