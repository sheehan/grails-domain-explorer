define [
  'app'
  'backbone'
], (app, Backbone) ->
  Backbone.Model.extend

    defaults:
      query: 'from Book order by id'
      max: 50
      offset: 0

    nextPage: ->
      @set 'offset', @get('offset') + @get('max')

    prevPage: ->
      @set 'offset', @get('offset') - @get('max')

    execute: ->
      url = app.createLink('domain', 'executeQuery')
      dfd = $.post url, @toJSON()
#      dfd.done (resp) ->
#        items = resp.value
#        clazz = resp.clazz
      dfd