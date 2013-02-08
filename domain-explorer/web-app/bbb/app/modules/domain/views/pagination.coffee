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

      if not @collection.hasNext()
        @$('.next').addClass 'disabled'
      else
        @$('.next').removeClass 'disabled'

      if not @collection.hasPrev()
        @$('.prev').addClass 'disabled'
      else
        @$('.prev').removeClass 'disabled'

    onNext: (event) ->
      event.preventDefault()
      @collection.next()

    onPrev: (event) ->
      event.preventDefault()
      @collection.prev()