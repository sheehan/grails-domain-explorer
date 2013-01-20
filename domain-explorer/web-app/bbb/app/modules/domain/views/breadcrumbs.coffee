define [
  'app'
  'backbone.marionette'
], (app, Marionette) ->
  Marionette.Layout.extend
    template: 'domain/breadcrumbs'

    onRender: ->
      console.log 'f'