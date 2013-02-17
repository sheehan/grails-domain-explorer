define [
  'app'
  './item-view'
  'modules/util/stack-view'
  './breadcrumbs'
  './show'
  './edit'
  './association-many-section'
  '../collections/breadcrumbs'
  '../collections/instances'
], (app, ItemView, StackView, BreadcrumbsView, ShowView, EditView, AssocitationManySectionView, BreadcrumbCollection, InstancesCollection) ->

  ItemView.extend
    template: 'domain/show-section'

    triggers:
      'click .back': 'back'

    initialize: (options) ->
      @breadcrumbs = new BreadcrumbCollection

      @breadcrumbsView = new BreadcrumbsView
        collection: @breadcrumbs

      @listenTo @breadcrumbsView, 'select', (index) =>
        @breadcrumbs.pop() while @breadcrumbs.length > index + 1
        @stackView.pop() while @stackView.views.length > index + 1

      @stackView = new StackView

      @addSubview '.breadcrumbs-section', @breadcrumbsView
      @addSubview '.show-section', @stackView

      @pushNewShowView @model, @model.clazz, "#{@model.clazz.name} : #{@model.id}"

    push: (view) ->
      view.push view

    pop: (view) ->
      view.pop()

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

      @listenTo editView, 'cancel', => @stackView.pop()
      @listenTo editView, 'save', =>
        editView.setSaving true
        data = editView.serialize()
        dfd = model.updateWithData data
        dfd.done => @stackView.pop()

        dfd.fail (data) =>
          editView.setSaving false
          editView.showErrors data.errors

      @stackView.push editView

    pushNewShowView: (model, clazz, label) ->
      @breadcrumbs.add
        label: label

      showView = new ShowView
        model: model
        clazz: clazz

      @stackView.push showView

      @listenTo showView, 'select:propertyOne', @onSelectPropertyOne
      @listenTo showView, 'select:propertyMany', @onSelectPropertyMany
      @listenTo showView, 'edit', @onEdit, @

    pushNewManyView: (collection, clazz, label) ->
      @breadcrumbs.add
        label: label

      resultsView = new AssocitationManySectionView
        collection: collection
        clazz: clazz

      @listenTo resultsView, 'row:click', (model) =>
        @pushNewShowView model, model.clazz, "#{model.clazz.name} : #{model.id}"

      @stackView.push resultsView
      resultsView.showItems() # TODO