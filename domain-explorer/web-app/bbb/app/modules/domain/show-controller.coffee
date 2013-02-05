define [
  'backbone.marionette'
  './collections/breadcrumbs'
  './collections/instances'
  './views/search'
  './views/show'
  './views/results'
  './views/show-section'
  './views/edit'
], (Marionette, BreadcrumbCollection, InstancesCollection, SearchView, ShowView, ResultsView, ShowSectionView, EditView) ->
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

    onEdit: (model) ->
      editView = new EditView
        model: model
        clazz: model.clazz

      @listenTo editView, 'cancel', => @view.pop()
      @listenTo editView, 'save', =>
        editView.setSaving true
        data = editView.serialize()
        dfd = model.updateWithData data
        dfd.done => @view.pop()

        dfd.fail (data) =>
          editView.setSaving false
          editView.showErrors data.errors

      @view.push editView

    pushNewShowView: (model, clazz, label) ->
      @breadcrumbs.add
        label: label

      showView = new ShowView
        model: model
        clazz: clazz

      @view.push showView

      @listenTo showView, 'select:propertyOne', @onSelectPropertyOne, @
      @listenTo showView, 'select:propertyMany', @onSelectPropertyMany, @
      @listenTo showView, 'edit', @onEdit, @

    pushNewManyView: (collection, clazz, label) ->
      @breadcrumbs.add
        label: label

      resultsView = new ResultsView
        collection: collection
        clazz: clazz

      @view.push resultsView
      resultsView.showItems()

    onClose: ->
      @view.close()