define [
  'backbone.marionette'
  './views/search'
  'modules/util/stack-view'
  './show-controller'
], (Marionette, SearchView, StackView, ShowController) ->

  Marionette.Controller.extend
    initialize: (options) ->
      searchView = new SearchView

      @view = new StackView
      @view.push searchView

      @listenTo searchView, 'row:click', (model) =>
        showController = new ShowController
          domainModel: model
          clazz: model.clazz
        @view.push showController.view
        @listenTo showController, 'back', =>
          @view.pop()
          searchView.resize()

    onClose: ->
      @view.close()
