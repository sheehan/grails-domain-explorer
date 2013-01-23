define [
  'app'
  'backbone.marionette'
  "../../util/stackregion"
  './breadcrumbs'
], (app, Marionette, StackRegion, BreadcrumbsView) ->

  Marionette.Layout.extend
    template: 'domain/view-section'

    regions:
      'breadcrumbsRegion':'.breadcrumbs-section'
      'showRegion':
        selector: ".show-section"
        regionType: StackRegion

    initialize: (options) ->
      breadcrumbCollection = options.breadcrumbCollection

      @breadcrumbsView = new BreadcrumbsView
        collection: breadcrumbCollection

      @listenTo @breadcrumbsView, 'back', => @trigger 'breadcrumb:back'
      @listenTo @breadcrumbsView, 'select', (index) => @trigger 'breadcrumb:select', index


    onShow: ->
      @breadcrumbsRegion.show @breadcrumbsView