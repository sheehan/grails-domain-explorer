define [
  'app'
  'backbone'
], (app, Backbone) ->
  Instance = Backbone.Model.extend

    fetchPropertyOne: (propertyName) ->
      url = app.createLink('domain', 'findPropertyOne')
      dfd = $.post url,
        className: @get 'className'
        id: @id
        property: propertyName

      dfd.then (resp) ->
        instance = new Instance(resp.value)
        instance.clazz = resp.clazz
        instance


