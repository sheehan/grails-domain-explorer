define [
  'backbone.marionette'
], (Marionette) ->
  Marionette.Layout.extend
    template: ''

    className: 'view-tabs-section'

    regions:
      'tabsHeaderRegion': '.tabs-header'
      'tabsBodyRegion': '.tabs-body'

    initialize: (options) ->

      console.log 'hi matt'

    resize: ->
      @layout = @$el.layout
        north__paneSelector: '.tabs-header'
        center__paneSelector: '.tabs-body'
        resizable: true
      @resultsView.resize()
