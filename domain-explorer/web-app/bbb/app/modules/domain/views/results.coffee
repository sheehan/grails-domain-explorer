define [
  'backbone.marionette'
  'dataTables'
], (Marionette) ->
  Marionette.Layout.extend
    template: 'domain/results'

    className: 'view-results'

    serializeData: ->
      items: @items

#    regions:

    showItems: (items, clazz) ->
      @items = items
      @clazz = clazz
      @render()

    onRender: ->
      if (@items)

        aoColumns = []
        for prop in @clazz.properties
          aoColumns.push
            "sTitle": prop.name
            "mData": prop.name

        @dataTable = @$('table').dataTable
          aoColumns: aoColumns
          bPaginate: false
          sDom: 't'

        @dataTable.fnAddData @items
