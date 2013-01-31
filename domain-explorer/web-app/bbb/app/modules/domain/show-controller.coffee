define [
  'backbone.marionette'
  './collections/breadcrumbs'
  './views/search'
  './views/show'
  './views/show-section'
], (Marionette, BreadcrumbCollection, SearchView, ShowView, ShowSectionView) ->
  Marionette.Controller.extend
    initialize: (options) ->
      domainModel = options.domainModel
      clazz = options.clazz

      @breadcrumbs = new BreadcrumbCollection
      @breadcrumbs.add [
        { label: 'Results' }
      ]
      @view = new ShowSectionView
        breadcrumbCollection: @breadcrumbs
        domainModel: domainModel
        clazz: clazz

      @listenTo @view, 'back', => @trigger 'back'

      @pushNewShowView domainModel, clazz, "#{clazz.name} : #{domainModel.id}"

    pushNewShowView: (model, clazz, label) ->
      @breadcrumbs.add
        label: label

      showView = new ShowView
        model: model
        clazz: clazz

      @view.push showView

      @listenTo showView, 'select:propertyOne', @onSelectPropertyOne, @


    onSelectPropertyOne: (model, property) ->
      model.fetchPropertyOne(property).done (instance) =>
        @pushNewShowView instance, instance.clazz, property


    onClose: ->
      @view.close()