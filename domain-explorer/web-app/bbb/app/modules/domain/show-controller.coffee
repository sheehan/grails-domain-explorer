define [
  'backbone.marionette'
  './views/page'
  './collections/breadcrumbs'
  './views/show'
  './views/show-section'
  './views/tabs-section'
], (Marionette, PageView, BreadcrumbCollection, ShowView, ShowSectionView, TabsSectionView) ->
  Marionette.Controller.extend
    initialize: (options) ->
      @region = options.region

      tabsSectionView = new TabsSectionView


      pageView = new PageView
        showController: @

      @region.show pageView

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

      @listenTo @showSectionView, 'breadcrumb:select', (index) =>
        @showSectionView.showRegion.showIndex index
        @breadcrumbs.pop() while @breadcrumbs.length > index + 2

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