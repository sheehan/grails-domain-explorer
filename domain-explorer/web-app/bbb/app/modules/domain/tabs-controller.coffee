define [
  'underscore'
  'backbone.marionette'
  './views/tabs-section'
], (_, Marionette, TabsSectionView) ->
  Marionette.Controller.extend

    initialize: (options) ->
      @views = []
      @tabsSectionView = new TabsSectionView

      @region = options.region
      @region.show @tabsSectionView
      @listenTo @tabsSectionView, 'new', =>
        @trigger 'tab:new'

    addView: (title, view) ->
      _.each @views, (view) -> view.$el.hide()
      @views.push view
      @tabsSectionView.addView title, view

    removeView: (view) ->
      'TODO'






