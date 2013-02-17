define [
  'handlebars'
  'backbone'
  'backbone.marionette'
  './item-view'
], (Handlebars, Backbone, Marionette, ItemView) ->
  ErrorModel = Backbone.Model.extend()

  ErrorCollection = Backbone.Collection.extend
    model: ErrorModel

  ErrorsView = ItemView.extend
    template: "domain/edit/errors"
    className: "alert alert-error"
    initialize: (options) ->
      @errors = options.errors

    serializeData: ->
      @errors

  DateView = ItemView.extend
    template: "domain/edit/form/date"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      value = @model.get(@property.name)
      mnt = moment(value)
      name: @property.name
      value: @model.get(@property.name)
      date: mnt.date()
      month: mnt.month()
      year: mnt.year()

    onRender: ->
      value = @model.get(@property.name)
      mnt = moment(value)
      @$("[name=year]").val mnt.year()
      @$("[name=month]").val mnt.month()
      @$("[name=day]").val mnt.date()

    serialize: ->
      year = @$("[name=year]").val()
      month = @$("[name=month]").val()
      day = @$("[name=day]").val()
      date = new Date(year, month, day)
      data = {}
      data[@propertyName] = moment(date).format("YYYY-MM-DDTHH:mm:ss.SSSZZ")
      data

  StringView = ItemView.extend
    template: "domain/edit/form/string"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      name: @property.name
      value: (if @model then @model.get(@property.name) else null)

    serialize: ->
      data = {}
      data[@propertyName] = @$el.find("input").val()
      data

  ReadOnlyView = ItemView.extend
    template: "domain/edit/form/readOnly"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      name: @property.name
      value: (if @model then @model.get(@property.name) else null)

    serialize: ->
      {}

  BooleanView = ItemView.extend
    template: "domain/edit/form/boolean"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      name: @property.name
      value: (if @model then @model.get(@property.name) else null)

    serialize: ->
      data = {}
      data[@propertyName] = @$el.find("input").val()
      data

  AssociationOneView = ItemView.extend
    events:
      "click button.clear": "_handleClearClick"

    template: "domain/edit/form/associationOne"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      property: @property
      value: (if @model then @model.get(@property.name) else null)

    _handleClearClick: (event) ->
      @$("input").val ""

    serialize: ->
      val = @$el.find("input").val()
      val = "null"  unless val
      data = {}
      data[@propertyName + ".id"] = val
      data

  NotSupportedView = ItemView.extend
    template: "domain/edit/form/notSupported"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      property: @property
      value: (if @model then @model.get(@property.name) else null)

    serialize: ->
      {}

  EmbeddedView = ItemView.extend
    template: "domain/edit/form/embedded"
    initialize: (options) ->
      @property = options.property
      @propertyName = options.propertyName

    serializeData: ->
      property: @property
      value: @model.get(@property.name).toJSON()

    serialize: ->
      {}

  Marionette.Layout.extend
    template: 'domain/edit'

    triggers:
      'click .toolbar-section .cancel': 'cancel'
      'click .toolbar-section .save': 'save'

    regions:
      errors: '.errors'

    initialize: (options) ->
      @clazz = options.clazz
      @formViews = []
      @_addSubviews()

    serializeData: ->
      for property in @getEditProperties()
        do (property) =>
          property: property
          value: @model.get property.name

    getEditProperties: ->
      property for property in @clazz.properties when property.view isnt 'associationMany'

    serialize: ->
      data = {}
      _.each @formViews, (view) ->
        _.extend data, view.serialize()
      data

    _addSubviews: ->
      for property in @getEditProperties()
        @_createFormView property, property.name, @model

        #        if property.view is "embedded"
        ###
        $fieldset = $(Handlebars.templates["domain/edit/form/embedded"](property: property))
        $form.append $fieldset
        embeddedModel = @model.get(property.name)
        embeddedProperties = _.reject(property.clazz.properties, (prop) ->
          _.include ["id", "version"], prop.name
        )
        _.each embeddedProperties, (embeddedProp) =>
          @_createFormView embeddedProp, property.name + "." + embeddedProp.name, embeddedModel, $fieldset

###
        #        else

    _createFormView: (property, propertyName, model) ->
      View = @getView(property)
      if View
        view = new View
          property: property
          propertyName: propertyName
          model: model

        @formViews.push view

        @addSubview "[data-property-name=\"#{propertyName}\"] .controls", view

    getView: (property) ->
      # TODO switch to fields-type scheme
      return ReadOnlyView  if _.include(["id", "version", "dateCreated", "lastUpdated"], property.name)
      switch property.view
        when "string", "number"
          StringView
        when "date"
          DateView
        when "boolean"
          BooleanView
        when "embedded"
          NotSupportedView
        when "associationOne"
          AssociationOneView
        else
          NotSupportedView

    setSaving: (isSaving) ->
      @$el.toggleClass "saving", isSaving

    showErrors: (errors) ->
      @errors.show new ErrorsView(errors: errors)