define [
  'app'
  'backbone.marionette'
], (app, Marionette) ->
  Marionette.Layout.extend

    events:
      'click li a': 'onClick'

    initialize: (options) ->
      @listenTo @collection, 'add remove reset', @render, @

    onClick: (event) ->
      event.preventDefault()
      $li = $(event.currentTarget).closest('li')
      index = @$('li').index($li)

      if index is 0
        @trigger 'back'
      else
        @trigger 'select', index - 1


    renderHtml: ->
      items = @collection.collect (breadcrumb, index) =>
        if index < @collection.size() - 1
          """<li><a href="#">#{breadcrumb.get('label')}</a> <span class="divider">/</span></li>"""
        else
          """<li class="active">#{breadcrumb.get('label')}</li>"""
      """
      <ul class="breadcrumb">
        #{items.join('')}
      </ul>
      """