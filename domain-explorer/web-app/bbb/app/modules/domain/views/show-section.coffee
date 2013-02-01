define [
  'app'
  'backbone.marionette'
  './breadcrumbs'
  'modules/util/stack-view'
], (app, Marionette, BreadcrumbsView, StackView) ->

  Marionette.Layout.extend
    template: 'domain/show-section'

    regions:
      'breadcrumbsRegion':'.breadcrumbs-section'
      'showRegion': ".show-section"

    triggers:
      'click .back': 'back'

    initialize: (options) ->
      @breadcrumbs = options.breadcrumbCollection

      @breadcrumbsView = new BreadcrumbsView
        collection: @breadcrumbs

      @listenTo @breadcrumbsView, 'select', (index) =>
        @breadcrumbs.pop() while @breadcrumbs.length > index + 2
        @stackView.pop() while @stackView.views.length > index + 1

      @stackView = new StackView

    onShow: ->
      @showRegion.show @stackView
      @breadcrumbsRegion.show @breadcrumbsView

    push: (view) ->
      @stackView.push view