define [
  'app'
  'backbone.marionette'
  './breadcrumbs'
  'modules/util/stack-view'
], (app, Marionette, BreadcrumbsView, StackView) ->

  Marionette.ItemView.extend
    template: 'domain/show-section'

    triggers:
      'click .back': 'back'

    initialize: (options) ->
      @breadcrumbs = options.breadcrumbCollection

      @breadcrumbsView = new BreadcrumbsView
        collection: @breadcrumbs

      @listenTo @breadcrumbsView, 'select', (index) =>
        @breadcrumbs.pop() while @breadcrumbs.length > index + 1
        @stackView.pop() while @stackView.views.length > index + 1

      @stackView = new StackView

      @addSubview '.breadcrumbs-section', @breadcrumbsView
      @addSubview '.show-section', @stackView

    push: (view) ->
      @stackView.push view

    pop: (view) ->
      @stackView.pop()