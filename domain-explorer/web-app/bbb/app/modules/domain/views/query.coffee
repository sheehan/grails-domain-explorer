define ['backbone.marionette'], (Marionette) ->
  Marionette.ItemView.extend
    template: 'domain/query'

    className: 'view-query'

    events:
      'click button.execute': 'execute'

    execute: ->
      console.log 'execute'
