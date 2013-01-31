define [
  'backbone.marionette'
  'moment'
  '../../util/dom-utils'
  'dataTables'
], (Marionette, moment, DomUtils) ->
  Marionette.Layout.extend
    template: 'domain/results'

    className: 'view-results'

    initialize: ->
      @listenTo @collection, "reset", @showItems

    triggers:
      'click .next': 'next'
      'click .prev': 'prev'

    showItems: ->
      if @collection.clazz
        @initTable()
        @dataTable.fnAddData @collection.toJSON()

        start = @collection.offset + 1
        end = start + @collection.size() - 1
        @$('.showing').html "Showing #{start} - #{end}"
      else
        @$('table').html ''
        @$('.showing').html ''

    initTable: ->
      clazz = @collection.clazz
      @dataTable.fnDestroy() if @dataTable
      @$('table').html ''

      aoColumns = []
      aoColumns.push
        mData: -> ''
        mRender: (data, type, full) -> '<input type="checkbox" />'
        sWidth: 15
        sClass: 'check'

      for prop in clazz.properties
        do (prop) =>
          aoColumns.push
            "sTitle": prop.name
            "mData": (data, type, full) =>
              @renderCell prop, data[prop.name]

      @dataTable = @$('table').dataTable
        aoColumns: aoColumns
        bPaginate: false
        sDom: 't'
        sScrollY: "100%"
        sScrollX: "100%"
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) =>
          $(nRow).click (event) =>
            if not $(event.target).closest('td').is('.check')
              model = @collection.find (m) => m.id is aData.id
              @trigger 'row:click', model

      @resize()

    onClose: ->
      @dataTable.fnDestroy() if @dataTable

    resize: ->
      DomUtils.sizeToFitVertical @$('.dataTables_scrollBody')

    renderCell: (property, value) ->
      if property.oneToMany or property.manyToMany
        valueHtml = "<span class=\"instanceValue oneToMany\">[#{value}]</span>"
      else if value is null
        valueHtml = "<span class=\"instanceValue null\">#{value}</span>"
      else if property.oneToOne or property.manyToOne
        className = _.last(property.type.split("."))
        valueHtml = "<span class=\"nowrap\">#{className}: #{value}</span>"
      else if property.view is "date"
        valueHtml = moment(value).format("YYYY-MM-DD")
      else
        valueHtml = value
      valueHtml

