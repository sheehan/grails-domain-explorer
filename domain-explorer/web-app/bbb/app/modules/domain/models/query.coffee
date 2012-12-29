define [
  'app'
  'backbone'
  './results'
], (app, Backbone, ResultsModel) ->
  Backbone.Model.extend

    defaults:
      query: 'from Book order by id'
      max: 50
      offset: 0

    execute: ->
      url = app.createLink('domain', 'executeQuery')
      dfd = $.post url, @toJSON()
#      dfd.done (resp) ->
#        items = resp.value
#        clazz = resp.clazz
      dfd