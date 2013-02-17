define [
  'backbone.marionette'
  './item-view'
  'modules/util/dom-utils'
  'modules/util/radio-view'
], (Marionette, ItemView) ->

  TabView = ItemView.extend
    tagName: 'li'

    template: 'domain/tab'

    triggers:
      'click': 'select'

    events:
      'click i.icon-remove': 'onRemoveClick'

    onRemoveClick: (event) ->
      event.preventDefault()
      event.stopPropagation()
      @trigger 'remove'

    initialize: ->
      @listenTo @model, 'change', => @render()

    onRender: ->
      @$el.toggleClass 'active', @model.get('selected') is true

  Marionette.CompositeView.extend
    template: 'domain/tabs'

    itemView: TabView

    className: 'view-tabs-section'

    triggers:
      'click a.new': 'new'

    initialize: (options) ->
      @listenTo @, 'itemview:remove', (childView) =>
        @collection.remove childView.model
        if @collection.length && childView.model.get('selected') is true
          @collection.last().set selected: true

      @listenTo @, 'itemview:select', (childView) =>
        @collection.each (tab) -> tab.set selected: false
        childView.model.set selected: true
        @trigger 'select', childView.model

    appendHtml: (collectionView, itemView, index) ->
      itemView.$el.insertBefore @$('ul li.new')