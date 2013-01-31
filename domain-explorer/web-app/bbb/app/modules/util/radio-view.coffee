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

    showByCid: (cid) ->
      view = _.find @views, (v) -> v.cid is cid
      @show view if view

    remove: (view) ->
      view.close()
      @views = _.without @views, view

    onClose: ->
      _.invoke @views, 'close'