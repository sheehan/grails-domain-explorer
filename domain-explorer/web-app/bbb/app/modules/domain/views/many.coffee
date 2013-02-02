define [
  'handlebars'
  'backbone.marionette'
], (Handlebars, Marionette) ->

  Handlebars.registerHelper 'property_value', ->
    property = @property
    value = @value
    valueHtml = ''
    if property.oneToMany || property.manyToMany
      valueHtml = """
        <span class="propertyMany">
          <a href="#" data-property-name="#{property.name}">[#{value}]</a>
        </span>
      """
    else if value is null
      valueHtml = """
        <span class="instanceValue null">#{value}</span>
      """
    else if property.oneToOne || property.manyToOne
      className = _.last(property.type.split('.'))
      valueHtml = """
      <span class="propertyOne">
        <a class="nowrap" href="#" data-property-name="#{property.name}">#{className}: #{value}</a>
      </span>
      """
    else if property.view == 'date'
      valueHtml = moment(value).format('DD MMM YYYY')
    else
      valueHtml = value

    new Handlebars.SafeString(valueHtml)

  Marionette.Layout.extend
    template: 'domain/many'

    events:
      'click .propertyMany a': 'onPropertyManyClick'
      'click .propertyOne a': 'onPropertyOneClick'

    initialize: (options) ->
      @clazz = options.clazz

    serializeData: ->
      for property in @clazz.properties
        do (property) =>
          property: property
          value: @model.get(property.name)

    onPropertyManyClick: (event) ->
      event.preventDefault()
      propertyName = @$(event.currentTarget).data('propertyName')
      @trigger 'select:propertyMany', @model, propertyName

    onPropertyOneClick: (event) ->
      event.preventDefault()
      propertyName = @$(event.currentTarget).data('propertyName')
      @trigger 'select:propertyOne', @model, propertyName