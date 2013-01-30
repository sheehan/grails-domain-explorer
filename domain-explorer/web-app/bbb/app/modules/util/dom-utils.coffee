define [
  'underscore'
  'jquery'
], (_, $) ->

  setHeight = ($target) ->
    $container = $target.parent()
    childrenHeight = _.reduce(
      $container.children()
      (memo, el) -> memo + $(el).outerHeight true
      0
    )

    difference = $container.height() - childrenHeight
    $target.height $target.height() + difference


  sizeToFitVertical = (el, container) ->
    $target = $(el)

    if not container
      container = _.find $target.parents(), (el) ->
        $(el).css('position') is 'absolute' or $(el)[0].style.height
      console.log el
      console.log container

    if not container
      container = $('body')[0]

    if container
      for ancestor in $target.parentsUntil(container).get().reverse()
        setHeight $(ancestor)

      setHeight $target

  sizeToFitVertical: sizeToFitVertical