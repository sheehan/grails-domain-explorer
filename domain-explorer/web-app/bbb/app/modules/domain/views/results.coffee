define [
  './item-view'
  'jquery'
  'moment'
  '../../util/dom-utils'
  'dataTables'
], (ItemView, $, moment, DomUtils) ->
  ItemView.extend
    template: 'domain/results'

    className: 'view-results'

    initialize: ->
      @listenTo @collection, 'change', @onModelChange

    onModelChange: (model, options) ->
      @dataTable.fnUpdate model.toJSON(), @collection.indexOf(model)

    showItems: ->
      if @collection.clazz
        @initTable()
        @dataTable.fnAddData @collection.toJSON()

      else
        @$('table').html ''
        @$('.showing').html ''

    initTable: ->
      clazz = @collection.clazz
      @dataTable.fnDestroy() if @dataTable

      @$('table').remove()
      @wrapper = @$('.table-wrapper')
      @wrapper.append '<table class="table table-striped table-bordered"></table>'

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
          hasListener = $(nRow).data 'hasListener'
          if (not hasListener)
            $(nRow).click (event) =>
              if not $(event.target).closest('td').is('.check')
                model = @collection.find (m) => m.id is aData.id
                @trigger 'row:click', model

            $(nRow).data 'hasListener', true

      @resize()

    onClose: ->
      @dataTable.fnDestroy() if @dataTable

    onShow: ->
      DomUtils.sizeToFitVertical @$('.table-wrapper')

    resize: ->
      if @$el.is ':visible'
        DomUtils.sizeToFitVertical @$('.dataTables_scrollBody')
#        @dataTable?.fnDraw()
        @dataTable?.fnAdjustColumnSizing()

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

