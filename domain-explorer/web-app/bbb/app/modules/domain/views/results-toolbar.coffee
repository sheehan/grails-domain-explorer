define [
  'backbone.marionette'
  './pagination'
], (Marionette, PaginationView) ->

  Marionette.ItemView.extend
    template: 'domain/results-toolbar'

    className: 'view-results-toolbar btn-toolbar'

    initialize: ->
      @paginationView = new PaginationView collection: @collection

      @addSubview '.pagination-container', @paginationView