define [
  'app'
  'backbone.marionette'
  './query'
  './results'
  './show-section'
  '../models/query'
  '../collections/instances'
  'layout'
], (app, Marionette, QueryView, ResultsView, ShowSectionView, QueryModel, InstanceCollection) ->
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
        showView = new ShowSectionView
          domainModel: model
          clazz: @instances.clazz

        app.content.push showView

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
      Mousetrap.unbind ['command+enter', 'ctrl+enter']

