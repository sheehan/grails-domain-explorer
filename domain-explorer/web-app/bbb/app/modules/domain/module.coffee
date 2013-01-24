define [
  'app'
  './show-controller'
], (app, ShowController) ->

  Router = Backbone.Router.extend
    routes:
      '': 'index'

    index: ->
      new ShowController
        region: app.content

  Router: Router

