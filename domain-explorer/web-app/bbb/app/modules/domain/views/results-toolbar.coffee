define [
  './item-view'
  './pagination'
], (ItemView, PaginationView) ->

  ItemView.extend
    template: 'domain/results-toolbar'

    className: 'view-results-toolbar btn-toolbar'

    initialize: ->
      @paginationView = new PaginationView collection: @collection

      @addSubview '.pagination-container', @paginationView