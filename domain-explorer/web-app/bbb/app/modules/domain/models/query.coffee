define [
  'app'
  'backbone'
], (app, Backbone) ->
  Backbone.Model.extend

    defaults:
      query: 'from Book order by id'