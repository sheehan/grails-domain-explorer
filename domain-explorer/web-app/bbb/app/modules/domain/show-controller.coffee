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
      showSectionView = new ShowSectionView
        breadcrumbCollection: @breadcrumbs
        domainModel: domainModel
        clazz: clazz

      @view = showSectionView
      @region = showSectionView.showRegion

      @listenTo showSectionView, 'breadcrumb:back', => @region.pop()

      @listenTo showSectionView, 'breadcrumb:select', (index) =>
        showSectionView.showRegion.showIndex index
        @breadcrumbs.pop() while @breadcrumbs.length > index + 2

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