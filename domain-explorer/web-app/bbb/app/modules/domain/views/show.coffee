define [

], () ->
  Marionette.Layout.extend
    template: 'domain/show'

    serializeData: ->
      for property in @model.clazz.toJSON().properties
        do (property) =>
          property: property
          value: @model.get(property.name)