define [
  'backbone.marionette'
  'modules/util/dom-utils'
  'modules/util/radio-view'
], (Marionette, DomUtils, RadioView) ->
  Marionette.Layout.extend
    template: 'domain/tabs-section'

    className: 'view-tabs-section'

    triggers:
      'click .tabs-header a.new': 'new'

    events:
      'click .tabs-header a:not(.new)': 'onTabClick'
      'click i.icon-remove': 'onDeleteClick'

    regions:
      'tabsHeaderRegion': '.tabs-header'
      'tabsBodyRegion': '.tabs-body'

    initialize: (options) ->
      @listenTo @tabsBodyRegion, 'show', => @resize()
      @tabsBodyView = new RadioView
        className: 'full-height'

    onShow: ->
      @tabsBodyRegion.show @tabsBodyView
      @resize()

    resize: ->
      DomUtils.sizeToFitVertical @$('.tabs-body'), @$el

    onTabClick: (event) ->
      event.preventDefault()
      @$('.tabs-header li').removeClass 'active'
      $li = $(event.currentTarget).closest 'li'
      $li.addClass 'active'
      @tabsBodyView.show $li.data 'view'

    addView: (title, view) ->
      console.log view
      @resize()
      @addTab title
      @$('.tabs-header li.active').data 'view', view
      @tabsBodyView.add view

    addTab: (title) ->
      $lis = @$('.tabs-header li:not(.new)')
      $lis.removeClass 'active'
      html = """
             <li class="active">
             <a href="#">
      #{title}
             <i class="icon-remove"></i>
             </a>
             </li>
             """
      $(html).insertBefore(@$('.tabs-header li.new'))

    onDeleteClick: (event) ->
      event.preventDefault()
      event.stopPropagation()
      $li = $(event.currentTarget).closest 'li'
      @tabsBodyView.remove $li.data 'view'
      $li.remove()

      $lastLi = @$('.tabs-header li:not(.new)').last()
      $lastLi.addClass 'active'
      @tabsBodyView.show $lastLi.data 'view'