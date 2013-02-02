define [
  'app'
  'backbone'
  '../models/instance'
], (app, Backbone, InstanceModel) ->
  Backbone.Collection.extend
    model: InstanceModel

    initialize: (options) ->
      @max = 50
      @offset = 0

    search: (query, max = 50, offset = 0) ->
      @offset = offset
      @max = max
      @query = query
      @_search()

    _search: ->
      url = app.createLink 'domain', 'executeQuery'
      dfd = $.post url,
        query: @query
        max: @max
        offset: @offset

      dfd.done (resp) =>
        @clazz = resp.clazz
        @reset resp.value

    fetchPropertyMany: (model, propertyName) ->
      @query = "select a.#{propertyName} from #{model.get 'className'} a where a.id = #{model.id} order by a.id"
      @_search()

    next: ->
      @offset = @offset + @max
      @_search()

    prev: ->
      @offset = @offset - @max
      @_search()

    getStart: ->
      @offset + 1

    getEnd: ->
      @offset + @size()