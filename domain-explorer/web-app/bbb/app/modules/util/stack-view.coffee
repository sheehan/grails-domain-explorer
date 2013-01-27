define [
  'backbone.marionette'
], (Marionette) ->

  Marionette.View.extend

    initialize: (options) ->
      @views = []

    pop: ->
      if @views.length
        view = @views.pop()
        view.close()

    push: (view) ->
      @views.push view
      view.render()
      @$el.append view.$el
