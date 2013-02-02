define [
  'app'
  'backbone'
  '../models/instance'
], (app, Backbone, InstanceModel) ->
  Backbone.Collection.extend
    model: InstanceModel

    search: (query, max, offset) ->
      url = app.createLink('domain', 'executeQuery')
      dfd = $.post url,
        query: query
        max: max
        offset: offset

      dfd.done (resp) =>
        @clazz = resp.clazz
        @offset = offset
        @max = max
        @query = query
        @reset resp.value

      dfd

    fetchPropertyMany: (model, propertyName) ->
      url = app.createLink('domain', 'findPropertyMany')
      dfd = $.post url,
        className: model.get 'className'
        id: model.id
        property: propertyName

      dfd.then (resp) =>
        @reset resp.values
        @clazz = resp.clazz