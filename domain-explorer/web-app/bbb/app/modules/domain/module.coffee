define [
  'app'
  './views/page'
], (app, PageView) ->


  Router = Backbone.Router.extend
    routes:
      '': 'index'

    index: ->
      console.log 'hi matt'
      pageView = new PageView
      app.content.show pageView

  Router: Router
