define [
  './item-view'
  './pagination'
], (ItemView, PaginationView) ->

  ItemView.extend
    template: 'domain/association-many-toolbar'

    className: 'view-association-many-toolbar btn-toolbar'

    initialize: ->
      @paginationView = new PaginationView collection: @collection

      @addSubview '.pagination-container', @paginationView