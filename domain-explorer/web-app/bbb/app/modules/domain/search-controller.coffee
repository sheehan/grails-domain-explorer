define [
  'backbone.marionette'
  './collections/breadcrumbs'
  './views/search'
  './views/show'
  './views/show-section'
  'modules/util/radio-view'
  'modules/util/stack-view'
], (Marionette, BreadcrumbCollection, SearchView, ShowView, ShowSectionView, RadioView, StackView) ->
  Marionette.Controller.extend
    initialize: (options) ->
      @region = options.region

      searchView = new SearchView

      @view = new StackView
      @view.push searchView

      @listenTo searchView, 'row:click', (model, clazz) =>
        @show model, clazz

    show: (domainModel, clazz) ->
      breadcrumbs = new BreadcrumbCollection
      breadcrumbs.add [
        { label: 'Results' }
      ]
      showSectionView = new ShowSectionView
        breadcrumbCollection: breadcrumbs
        domainModel: domainModel
        clazz: clazz

      @listenTo showSectionView, 'breadcrumb:back', => @view.pop()

      @listenTo showSectionView, 'breadcrumb:select', (index) =>
        showSectionView.showRegion.showIndex index
        breadcrumbs.pop() while breadcrumbs.length > index + 2

      @view.push showSectionView

      @pushNewShowView domainModel, clazz, "#{clazz.name} : #{domainModel.id}", breadcrumbs, showSectionView.showRegion

    pushNewShowView: (model, clazz, label, breadcrumbs, region) ->
      breadcrumbs.add
        label: label

      showView = new ShowView
        model: model
        clazz: clazz

      region.push showView

      @listenTo showView, 'select:propertyOne', @onSelectPropertyOne, @

    onSelectPropertyOne: (model, property) ->
      model.fetchPropertyOne(property).done (instance) =>
        @pushNewShowView instance, instance.clazz, property