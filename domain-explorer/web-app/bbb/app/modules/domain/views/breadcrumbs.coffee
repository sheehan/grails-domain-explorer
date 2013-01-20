define [
  'app'
  'backbone.marionette'
], (app, Marionette) ->
  Marionette.Layout.extend
    template: 'domain/breadcrumbs'

    onRender: ->
      $ul = @$('ul')
      $ul.append '<li><a href="#">Query</a> <span class="divider">/</span></li>'
      console.log 'f'