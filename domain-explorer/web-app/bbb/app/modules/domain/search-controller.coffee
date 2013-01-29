define [
  'backbone.marionette'
  './views/search'
  'modules/util/stack-view'
  './show-controller'
], (Marionette, SearchView, StackView, ShowController) ->
  Marionette.Controller.extend
    initialize: (options) ->
      searchView = new SearchView
        className: 'full-height'

      @view = new StackView
      @view.push searchView

      @listenTo searchView, 'row:click', (model, clazz) =>
        showController = new ShowController
          domainModel: model
          clazz: clazz
        @view.push showController.view
