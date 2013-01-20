define [
  'app'
  'backbone.marionette'
  './breadcrumbs'
  './show'
], (app, Marionette, BreadcrumbsView, ShowView) ->
  Marionette.Layout.extend
    template: 'domain/view-section'

    regions:
      'breadcrumbsRegion':'.breadcrumbs-section'
      'showRegion':'.show-section'

    initialize: (options) ->
      domainModel = options.domainModel
      clazz = options.clazz

      @breadcrumbsView = new BreadcrumbsView
      @showView = new ShowView
        model: domainModel
        clazz: clazz

    onShow: ->
      console.log 'show-section onShow'
      @breadcrumbsRegion.show @breadcrumbsView
      @showRegion.show @showView
      console.log 'show-section onShow done'
