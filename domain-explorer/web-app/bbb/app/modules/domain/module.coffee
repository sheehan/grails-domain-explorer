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
#      console.log app.content
      app.content.show pageView

  Router: Router

