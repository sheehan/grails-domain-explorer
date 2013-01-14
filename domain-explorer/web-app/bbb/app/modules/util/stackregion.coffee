define [
  'backbone.marionette'
], (Marionette) ->

  Marionette.Region.extend

    initialize: (options) ->
      @views = []

    show: (view) ->
      while @views.length
        topView = @peek()
        if (topView is view)
          @_displayView view
          return
        else
          @pop()

      @push view

    peek: ->
      @views[@views.length - 1] if @views.length

    push: (view) ->
      @ensureEl()

      currentView = @peek()
      currentView?.$el?.hide()

      view.render()

      @open view
      @_displayView view
      @views.push view

    _displayView: (view) ->
      @currentView = view
      view.$el.show()
      Marionette.triggerMethod.call view, "show"
      Marionette.triggerMethod.call this, "show", view


    open: (view) ->
      @$el.append view.el

    pop: ->
      poppedView = @views.pop()
      @closeView poppedView

      @currentView = @peek()
      @_displayView @currentView if @currentView

    close: ->
      @pop() while @views.length


    attachView: (view) ->
      @pop() while @views.length
      @views.push view

    closeView: (view) ->
      return  if not view or view.isClosed
      view.close()  if view.close
      Marionette.triggerMethod.call this, "close"


