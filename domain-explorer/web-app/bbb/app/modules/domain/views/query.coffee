define ['app', 'backbone.marionette'], (app, Marionette) ->
  Marionette.ItemView.extend
    template: 'domain/query'

    className: 'view-query'

    events:
      'click .execute': 'execute'

    execute: (event) ->
      event.preventDefault()
      @trigger 'execute', @$('textarea[name=query]').val()