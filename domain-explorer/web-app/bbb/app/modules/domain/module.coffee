define [
  'app'
  './views/page'
], (app, PageView) ->


  Router = Backbone.Router.extend
    routes:
      '': 'index'

    index: ->
      pageView = new PageView
      app.content.show pageView

  Router: Router

