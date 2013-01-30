define [
  'app'
  'modules/domain/editors-controller'
], (app, EditorsController) ->

  Backbone.Router.extend

    routes:
      '': 'index'

    index: ->
      new EditorsController
        region: app.content