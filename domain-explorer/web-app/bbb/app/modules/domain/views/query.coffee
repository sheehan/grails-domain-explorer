define ['app', 'backbone.marionette'], (app, Marionette) ->
  Marionette.ItemView.extend
    template: 'domain/query'

    className: 'view-query'

    events:
      'click button.execute': 'execute'

    execute: ->
      @trigger 'execute', @$('textarea[name=query]').val()