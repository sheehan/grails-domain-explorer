define [
  'app'
  'backbone.marionette'
  './breadcrumbs'
  'modules/util/stack-view'
], (app, Marionette, BreadcrumbsView, StackView) ->

  Marionette.Layout.extend
    template: 'domain/view-section'

    regions:
      'breadcrumbsRegion':'.breadcrumbs-section'
      'showRegion': ".show-section"

    initialize: (options) ->
      @breadcrumbs = options.breadcrumbCollection

      @breadcrumbsView = new BreadcrumbsView
        collection: @breadcrumbs

      @listenTo @breadcrumbsView, 'back', => @trigger 'back'
      @listenTo @breadcrumbsView, 'select', (index) =>
        @breadcrumbs.pop() while @breadcrumbs.length > index + 2
        @stackView.pop() while @stackView.views.length > index + 1

      @stackView = new StackView

    onShow: ->
      @showRegion.show @stackView
      @breadcrumbsRegion.show @breadcrumbsView

    push: (view) ->
      @stackView.push view