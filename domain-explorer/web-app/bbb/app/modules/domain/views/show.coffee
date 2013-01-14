define [
  'handlebars'
  'backbone.marionette'
], (Handlebars, Marionette) ->

  Handlebars.registerHelper 'property_value', ->
    console.log 'property_value'
    property = @property
    value = @value
    valueHtml = ''
    if property.oneToMany || property.manyToMany
      valueHtml = """
        <span class="instanceValue oneToMany">
          <a href="#" data-append-path="#{property.name}">[#{value}]</a>
        </span>
      """
    else if value is null
      valueHtml = """
        <span class="instanceValue null">#{value}</span>
      """
    else if property.oneToOne || property.manyToOne
      className = _.last(property.type.split('.'))
      valueHtml = """
        <a href="#" data-append-path="#{property.name}">
          <span class="nowrap">#{className}: #{value}</span>
        </a>
      """
    else if property.view == 'date'
      valueHtml = moment(value).format('DD MMM YYYY')
    else
      valueHtml = value
      
    new Handlebars.SafeString(valueHtml)

  Marionette.Layout.extend
    template: 'domain/show'

    initialize: (options) ->
      @clazz = options.clazz

    serializeData: ->
      for property in @clazz.properties
        do (property) =>
          property: property
          value: @model.get(property.name)