define ['app', 'backbone.marionette'], (app, Marionette) ->
  Marionette.ItemView.extend
    template: 'domain/query'

    className: 'view-query'

    triggers:
      'click button.execute': 'execute'