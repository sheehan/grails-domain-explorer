define [
  'app'
  'modules/domain/editors-controller'
], (app, EditorsController) ->

  Backbone.Router.extend

    routes:
      '': 'index'

    index: ->
      view = new EditorsController
      app.content.show view