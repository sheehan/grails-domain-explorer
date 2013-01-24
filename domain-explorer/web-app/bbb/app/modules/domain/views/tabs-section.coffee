define [
  'backbone.marionette'
  'modules/util/dom-utils'
  './tabs-header'
], (Marionette, DomUtils) ->
  Marionette.Layout.extend
    template: 'domain/tabs-section'

    className: 'view-tabs-section'

    regions:
      'tabsHeaderRegion': '.tabs-header'
      'tabsBodyRegion': '.tabs-body'

    initialize: (options) ->
      @listenTo @tabsBodyRegion, 'show', => @resize()

    onShow: ->

      @resize()

    resize: ->
      DomUtils.sizeToFitVertical @$('.tabs-body'), @$el
