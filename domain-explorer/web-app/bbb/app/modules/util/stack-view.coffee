define [
  'backbone.marionette'
], (Marionette) ->

  Marionette.View.extend

    constructor: ->
      @views = []
      @isShown = false
      Marionette.View::constructor.apply this, arguments

    pop: ->
      if @views.length
        view = @views.pop()
        @stopListening view
        view.close()

        if @views.length
          nextView = @views[@views.length - 1]
          nextView.$el.show()
          nextView.recurseMethod 'resize'

    push: (view) ->
      @views.push view
      @$el.children().hide()
      view.render()
      @$el.append view.$el
      Marionette.triggerMethod.call view, 'show' if @isShown

    onShow: ->
      @isShown = true
      Marionette.triggerMethod.call view, 'show' for view in @views

    onClose: ->
      _.invoke @views, 'close'
