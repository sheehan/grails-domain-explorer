define [
  'underscore'
  'backbone.marionette'
], (_, Marionette) ->

  Marionette.View.extend

    initialize: (options) ->
      @views = []

    add: (view) ->
      @views.push view
      view.render()
      @$el.children().hide()
      @$el.append view.$el
      Marionette.triggerMethod.call view, 'show'

    show: (view) ->
      @$el.children().hide()
      view.$el.show()

    remove: (view) ->
      @views = _.without @views, view

    onClose: ->
      _.invoke @views, 'close'