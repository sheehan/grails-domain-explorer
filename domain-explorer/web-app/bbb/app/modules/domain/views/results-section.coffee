define [
  'backbone.marionette'
  './results'
  './results-toolbar'
], (Marionette, ResultsView, ResultsToolbarView) ->

  Marionette.ItemView.extend
    template: 'domain/results-section'

    initialize: ->
      @resultsToolbarView = new ResultsToolbarView collection: @collection
      @resultsView = new ResultsView collection: @collection

      @listenTo @resultsView, 'row:click', (model) =>
        @trigger 'row:click', model

      @listenTo @collection, 'reset', @showItems
      @listenTo @collection, 'request', @onLoading

      @addSubview '.toolbar-container', @resultsToolbarView
      @addSubview '.results-container', @resultsView

    onLoading: ->
#      html = JST['loading TODO']()
      @$el.children().hide()
      html = """
             <div class="loading-animation">
               <div id="fadingBarsG">
                 <div id="fadingBarsG_1" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_2" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_3" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_4" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_5" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_6" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_7" class="fadingBarsG">
                 </div>
                 <div id="fadingBarsG_8" class="fadingBarsG">
                 </div>
               </div>
             </div>
             """
      @$el.append html

    onRender: ->
      @$('.loading-animation').remove()

    showItems: ->
      @render()
      @resultsView.showItems()

    resize: ->
      @resultsView.resize()