require [
  "app"
  "router"
  "backbone"
  "backbone.stickit"
  "mousetrap"
  "jst"
  "jquery.ui"
], (app, Router, Backbone) ->

  # Define your master router on the application namespace and trigger all
  # navigation from this instance.
  app.router = new Router()
  app.bind "initialize:before", (options) ->

  app.bind "initialize:after", (options) ->
    Backbone.history?.start(
      pushState: true
      root: window.appconf.pageContextPath
    )

  app.start window.appconf

