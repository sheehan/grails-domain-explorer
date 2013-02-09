define [
  'backbone.marionette'
  './search'
  'modules/util/stack-view'
  '../show-controller'
], (Marionette, SearchView, StackView, ShowController) ->

  StackView.extend

    initialize: (options) ->
      searchView = new SearchView

      @push searchView

      @listenTo searchView, 'row:click', (model) =>
        showController = new ShowController
          domainModel: model
          clazz: model.clazz
        @push showController.view
        @listenTo showController, 'back', =>
          @pop()
          searchView.resize()