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

        if @views.length
          @views[@views.length - 1].$el.show()

    push: (view) ->
      @views.push view
      @$el.children().hide()
      view.render()
      @$el.append view.$el
      Marionette.triggerMethod.call view, 'show'

    onClose: ->
      _.invoke @views, 'close'
