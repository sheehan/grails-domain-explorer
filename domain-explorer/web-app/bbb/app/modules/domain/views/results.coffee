define [
  'backbone.marionette'
  'moment'
  'dataTables'
], (Marionette, moment) ->
  Marionette.Layout.extend
    template: 'domain/results'

    className: 'view-results'

    initialize: ->
      @bindTo @model, "change", @showItems

    showItems: ->
      @initTable()
      @dataTable.fnAddData @model.get('items')

    initTable: ->
      clazz = @model.get('clazz')
      @dataTable.fnDestroy() if @dataTable
      @$('table').html ''

      aoColumns = []
      aoColumns.push
        "mData": -> ''
        "mRender": (data, type, full) -> '<input type="checkbox" />'
        "sWidth": 15
        "sClass": 'check'
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

      @resize()

    onClose: ->
      @dataTable.fnDestroy() if @dataTable

    resize: ->
      $target = @$('.dataTables_scrollBody')
      container = _.find $target.parents(), (el) -> $(el).css('position') is 'absolute'
      if container
        $container = $ container
        childrenHeight = _.reduce(
          $container.children()
          (memo, el) -> memo + $(el).outerHeight true
          0
        )

        difference = $container.height() - childrenHeight
        $target.height $target.height() + difference

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
