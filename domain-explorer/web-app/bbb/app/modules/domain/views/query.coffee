define ['app', 'backbone.marionette'], (app, Marionette) ->
  Marionette.ItemView.extend
    template: 'domain/query'

    className: 'view-query'

    triggers:
      'click .execute': 'execute'

    bindings:
      '[name=query]': 'query'
      '[name=max]': 'max'
      '[name=offset]': 'offset'

    onRender: ->
      @stickit()