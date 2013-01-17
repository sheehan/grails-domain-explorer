define [
  'backbone.marionette'
], (Marionette) ->

  class extends Backbone.Marionette.Region

    constructor: ->
      super
      @views = []

    # Return the top view (currently visible)
    peek: ->
      @views[@views.length - 1] if @views.length

    # Push a view onto the stack. Previous view is hidden and the new view is shown.
    push: (view) ->
      @ensureEl()

      topView = @peek()
      @_hideView(topView) if topView

      view.render()

      @open view
      @_displayView view
      @views.push view
      @currentView = view

    # Pop a view from the stack
    pop: ->
      poppedView = @views.pop()
      @_closeView poppedView if poppedView

      @currentView = @peek()
      @_displayView @currentView if @currentView

    # Pop until the view is on top. If not found, push it onto the empty stack.
    show: (view) ->
      @pop() while @views.length and @peek() isnt view

      @push view if not @views.length

    open: (view) ->
      @$el.append view.el

    close: ->
      @pop() while @views.length
      Marionette.triggerMethod.call this, "close"

    attachView: (view) ->
      @pop() while @views.length
      @views.push view

    _displayView: (view) ->
      view.$el.show()
      Marionette.triggerMethod.call view, "show"
      Marionette.triggerMethod.call this, "show", view

    _hideView: (view) ->
      view.$el.hide()

    _closeView: (view) ->
      view.close() if view?.close and not view.isClosed
