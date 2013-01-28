define [
  'app'
  './show-controller'
  './editors-controller'
], (app, ShowController, EditorsController) ->

  Router = Backbone.Router.extend
    routes:
      '': 'index'

    index: ->
      new EditorsController
        region: app.content

  Router: Router

