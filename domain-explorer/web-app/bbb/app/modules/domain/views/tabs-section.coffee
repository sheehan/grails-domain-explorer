define [
  'backbone.marionette'
], (Marionette) ->
  Marionette.Layout.extend

    className: 'view-tabs-section'

    regions:
      'tabsHeaderRegion': '.tabs-header'
      'tabsBodyRegion': '.body-header'

    initialize: (options) ->

      console.log 'hi matt'

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.tabs-header'
        center__paneSelector: '.body-header'
        resizable: true
      @resultsView.resize()
