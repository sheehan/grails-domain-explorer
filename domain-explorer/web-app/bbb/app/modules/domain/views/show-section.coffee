define [
  'app'
  'backbone.marionette'
  "../../util/stackregion"
  './breadcrumbs'
  'modules/util/stack-view'
], (app, Marionette, StackRegion, BreadcrumbsView, StackView) ->

  Marionette.Layout.extend
    template: 'domain/view-section'

    regions:
      'breadcrumbsRegion':'.breadcrumbs-section'
      'showRegion': ".show-section"

    initialize: (options) ->
      breadcrumbCollection = options.breadcrumbCollection

      @breadcrumbsView = new BreadcrumbsView
        collection: breadcrumbCollection

      @listenTo @breadcrumbsView, 'back', => @trigger 'breadcrumb:back'
      @listenTo @breadcrumbsView, 'select', (index) => @trigger 'breadcrumb:select', index

      @stackView = new StackView
        className: 'full-height'

    onRender: ->
      @showRegion.show @stackView

    onShow: ->
      @breadcrumbsRegion.show @breadcrumbsView

    push: (view) ->
      console.log 'yo'
      @stackView.push view