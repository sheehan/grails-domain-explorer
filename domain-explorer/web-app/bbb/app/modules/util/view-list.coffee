define [
  'underscore'
], (_) ->
  class

    constructor: ->
      @views = []

    add: (view) ->
      @views.push view

    remove: (view) ->
      @views = _.without @views, view

    show: (view) ->
      view.$el.show()

    hide: (view) ->
      view.$el.hide()