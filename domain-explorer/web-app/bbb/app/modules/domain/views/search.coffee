define [
  'app'
  'underscore'
  'backbone'
  'backbone.marionette'
  './query'
  './results'
  './show-section'
  '../models/query'
  '../collections/instances'
  '../collections/breadcrumbs'
  'layout'
], (app, _, Backbone, Marionette, QueryView, ResultsView, ShowSectionView, QueryModel, InstanceCollection, BreadcrumbCollection) ->

  ShowController = Marionette.Controller.extend
    initialize: (options) ->
      _.extend @, Backbone.Events
      @region = options.region

    show: (domainModel, clazz) ->
      breadcrumbs = new BreadcrumbCollection
      showView = new ShowSectionView
        breadcrumbCollection: breadcrumbs
        domainModel: domainModel
        clazz: clazz

      @listenTo breadcrumbs, 'xxx', =>
        console.log 'p'

      @region.push showView


  Marionette.Layout.extend
    template: 'domain/search'

    className: 'view-search'

    regions:
      'queryRegion': '.query-container'
      'resultsRegion': '.results-container'

    initialize: ->
      @queryModel = new QueryModel
      @instances = new InstanceCollection
      Mousetrap.bind ['command+enter', 'ctrl+enter'], (event) => @execute()

      @queryView = new QueryView model: @queryModel
      @resultsView = new ResultsView collection: @instances

      @queryView.on 'execute', =>
        @execute()

      @resultsView.on 'next', =>
        @queryModel.nextPage()
        @execute()

      @resultsView.on 'prev', =>
        @queryModel.prevPage()
        @execute()

      @resultsView.on 'row:click', (model) =>
        @showController.show model, @instances.clazz
        showView = new ShowSectionView
          domainModel: model
          clazz: @instances.clazz

        app.content.push showView

      @showController = new ShowController
        region: app.content

    onShow: ->
      @queryRegion.show @queryView
      @resultsRegion.show @resultsView


    execute: ->
      @instances.search @queryModel.get('query'), @queryModel.get('max'), @queryModel.get('offset')

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.query-container'
        center__paneSelector: '.results-container'
        resizable: true
      @resultsView.resize()

    onClose: ->
      @showController.close()
      Mousetrap.unbind ['command+enter', 'ctrl+enter']

