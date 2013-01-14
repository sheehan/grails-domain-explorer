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