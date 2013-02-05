define [
  'backbone.marionette'
  './views/search'
  'modules/util/stack-view'
  './show-controller'
], (Marionette, SearchView, StackView, ShowController) ->

  Marionette.Controller.extend
    initialize: (options) ->
      searchView = new SearchView

      console.log 'push onto stacjz'
      @view = new StackView
      @view.push searchView

      @listenTo searchView, 'row:click', (model, clazz) =>
        showController = new ShowController
          domainModel: model
          clazz: clazz
        @view.push showController.view
        @listenTo showController, 'back', => @view.pop()

    onClose: ->
      @view.close()
