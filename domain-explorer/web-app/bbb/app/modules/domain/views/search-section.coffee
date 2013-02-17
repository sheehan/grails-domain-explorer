define [
  './search'
  './show-section'
  'modules/util/stack-view'
], (SearchView, ShowSectionView, StackView) ->

  StackView.extend

    initialize: (options) ->
      searchView = new SearchView

      @push searchView

      @listenTo searchView, 'row:click', (model) =>
        showView = new ShowSectionView
          model: model
          clazz: model.clazz
        @push showView
        @listenTo showView, 'back', =>
          @pop()
          searchView.resize()