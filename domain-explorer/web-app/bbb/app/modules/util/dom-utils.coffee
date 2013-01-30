define [
  'underscore'
  'jquery'
], (_, $) ->

  sizeToFitVertical = (el, container) ->
    $target = $(el)

    if not container
      container = _.find $target.parents(), (el) -> $(el).css('position') is 'absolute'

    if container
      $container = $ container

      for ancestor in $target.parentsUntil(container).get().reverse()
        sizeToFitVertical ancestor, container


      childrenHeight = _.reduce(
        $container.children()
        (memo, el) -> memo + $(el).outerHeight true
        0
      )

      difference = $container.height() - childrenHeight
      $target.height $target.height() + difference

  sizeToFitVertical: sizeToFitVertical