define [
  'backbone.marionette'
], (Marionette) ->

  Marionette.ItemView.extend
    template: 'domain/pagination'

    className: 'view-pagination'

    initialize: ->
      @listenTo @collection, "reset", @update

    events:
      'click .next:not(.disabled)': 'onNext'
      'click .prev:not(.disabled)': 'onPrev'

    update: ->
      @$('.showing').html "Showing #{@collection.getStart()} - #{@collection.getEnd()}"

      @$('.next').toggleClass 'disabled', (not @collection.hasNext())
      @$('.prev').toggleClass 'disabled', (not @collection.hasPrev())

    onRender: ->
      @update()

    onNext: (event) ->
      event.preventDefault()
      @collection.next()

    onPrev: (event) ->
      event.preventDefault()
      @collection.prev()