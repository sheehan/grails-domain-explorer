define [
  'underscore'
  'backbone.marionette'
], (_, Marionette) ->

  Marionette.View.extend

    initialize: (options) ->
      @views = []
      @isShown = false

    add: (view) ->
      @views.push view
      view.render()
      @$el.children().hide()
      @$el.append view.$el
      console.log 'isShown: ' +@isShown
      console.log 'isVisible: ' +@$el.is(':visible')
      Marionette.triggerMethod.call view, 'show' if @isShown

    show: (view) ->
      @$el.children().hide()
      view.$el.show()

    showByCid: (cid) ->
      view = _.find @views, (v) -> v.cid is cid
      @show view if view

    remove: (view) ->
      view.close()
      @views = _.without @views, view

    onShow: ->
      @isShown = true
      Marionette.triggerMethod.call view, 'show' for view in @views

    onClose: ->
      _.invoke @views, 'close'