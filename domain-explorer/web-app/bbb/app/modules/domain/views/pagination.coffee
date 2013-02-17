define [
  './item-view'
], (ItemView) ->

  ItemView.extend
    template: 'domain/pagination'

    className: 'view-pagination'

    initialize: ->
      @listenTo @collection, "reset", @render

    onRender: ->
      @$('.showing').html "Showing #{@collection.getStart()} - #{@collection.getEnd()}"

      @$('.next').toggleClass 'disabled', (not @collection.hasNext())
      @$('.prev').toggleClass 'disabled', (not @collection.hasPrev())

      # TODO normal events hash not working for some reason
      @$('.next:not(.disabled)').click (event) => @onNext(event)
      @$('.prev:not(.disabled)').click (event) => @onPrev(event)

    onNext: (event) ->
      event.preventDefault()
      @collection.next()

    onPrev: (event) ->
      event.preventDefault()
      @collection.prev()