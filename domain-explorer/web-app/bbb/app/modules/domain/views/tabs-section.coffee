define [
  'backbone.marionette'
  'modules/util/dom-utils'
], (Marionette, DomUtils) ->
  Marionette.Layout.extend
    template: 'domain/tabs-section'

    className: 'view-tabs-section'

    events:
      'click .tabs-header a:not(.new)': 'onTabClick'
      'click .tabs-header a.new': 'onNewClick'
      'click i.icon-remove': 'onDeleteClick'

    regions:
      'tabsHeaderRegion': '.tabs-header'
      'tabsBodyRegion': '.tabs-body'

    initialize: (options) ->
      @listenTo @tabsBodyRegion, 'show', => @resize()

    onShow: ->
      @resize()

    resize: ->
      DomUtils.sizeToFitVertical @$('.tabs-body'), @$el

    onTabClick: (event) ->
      event.preventDefault()
      @$('.tabs-header li').removeClass 'active'
      $li = $(event.currentTarget).closest 'li'
      $li.addClass 'active'
      # TODO change tab body

    onNewClick: (event) ->
      event.preventDefault()
      $lis = @$('.tabs-header li')
      $lis.removeClass 'active'
      numberOfTabs = $lis.length
      html = """
         <li class="active">
         <a href="#">
         Home
         <i class="icon-remove"></i>
         </a>
         </li>
       """
      $(html).insertAfter($($lis[numberOfTabs - 2]))
      # TODO change tab body

    onDeleteClick: (event) ->
      event.preventDefault()
      $li = $(event.currentTarget).closest 'li'
      $li.remove()
      # TODO change tab body
