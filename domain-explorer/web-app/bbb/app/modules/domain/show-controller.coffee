define [
  'backbone.marionette'
  './collections/breadcrumbs'
  './collections/instances'
  './views/search'
  './views/show'
  './views/results'
  './views/show-section'
], (Marionette, BreadcrumbCollection, InstancesCollection, SearchView, ShowView, ResultsView, ShowSectionView) ->
  Marionette.Controller.extend
    initialize: (options) ->
      domainModel = options.domainModel
      clazz = options.clazz

      @breadcrumbs = new BreadcrumbCollection
      @view = new ShowSectionView
        breadcrumbCollection: @breadcrumbs
        domainModel: domainModel
        clazz: clazz

      @listenTo @view, 'back', => @trigger 'back'

      @pushNewShowView domainModel, clazz, "#{clazz.name} : #{domainModel.id}"

    onSelectPropertyOne: (model, property) ->
      model.fetchPropertyOne(property).done (instance) =>
        @pushNewShowView instance, instance.clazz, property

    onSelectPropertyMany: (model, property) ->
      instances = new InstancesCollection()
      instances.fetchPropertyMany(model, property).done =>
        @pushNewManyView instances, instances.clazz, property

    pushNewShowView: (model, clazz, label) ->
      @breadcrumbs.add
        label: label

      showView = new ShowView
        model: model
        clazz: clazz

      @view.push showView

      @listenTo showView, 'select:propertyOne', @onSelectPropertyOne, @
      @listenTo showView, 'select:propertyMany', @onSelectPropertyMany, @

    pushNewManyView: (collection, clazz, label) ->
      @breadcrumbs.add
        label: label

      resultsView = new ResultsView
        collection: collection
        clazz: clazz

      @listenTo resultsView, 'next', =>
        collection.next()

      @listenTo resultsView, 'prev', =>
        collection.prev()

      @view.push resultsView
      resultsView.showItems()

    onClose: ->
      @view.close()