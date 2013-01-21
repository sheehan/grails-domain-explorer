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
  './show'
  'layout'
], (app, _, Backbone, Marionette, QueryView, ResultsView, ShowSectionView, QueryModel, InstanceCollection, BreadcrumbCollection, ShowView) ->

  ShowController = Marionette.Controller.extend
    initialize: (options) ->
      @region = options.region

    show: (domainModel, clazz) ->
      @breadcrumbs = new BreadcrumbCollection
      @breadcrumbs.add [
        { label: 'Results' }
      ]
      @showSectionView = new ShowSectionView
        breadcrumbCollection: @breadcrumbs
        domainModel: domainModel
        clazz: clazz

      @listenTo @showSectionView, 'breadcrumb:back', => @region.pop()

      @listenTo @showSectionView, 'breadcrumb:select', (breadcrumb) =>
        # then @region.pop()
        # if other clicked
        # then showSectionView.showRegion.show theView
        console.log 'p'

      @listenTo @showSectionView, 'attribute:select', (instance, attribute) =>
        # if body link click
        # then showSectionView.showRegion.push newView and add breadcrumb

      @region.push @showSectionView

      @pushNewShowView domainModel, clazz, "#{clazz.name} : #{domainModel.id}"

    pushNewShowView: (model, clazz, label) ->
      @breadcrumbs.add
        label: label

      showView = new ShowView
        model: model
        clazz: clazz

      @showSectionView.showRegion.push showView

      @listenTo showView, 'select:propertyOne', @onSelectPropertyOne, @


    onSelectPropertyOne: (model, property) ->
      model.fetchPropertyOne(property).done (instance) =>
        @pushNewShowView instance, instance.clazz, property





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

      @listenTo @queryView, 'execute', =>
        @execute()

      @listenTo @resultsView, 'next', =>
        @queryModel.nextPage()
        @execute()

      @listenTo @resultsView, 'prev', =>
        @queryModel.prevPage()
        @execute()

      @listenTo @resultsView, 'row:click', (model) =>
        @showController.show model, @instances.clazz

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

