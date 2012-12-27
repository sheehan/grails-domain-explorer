define [
  'backbone.marionette'
], (Marionette) ->
  Marionette.Layout.extend
    template: 'domain/results'

    className: 'view-results'

    serializeData: ->
      items: @items

#    regions:

    showItems: (items) ->
      @items = items
      @render()

#    onRender: ->
#      queryView = new QueryView
#      @queryRegion.show queryView

