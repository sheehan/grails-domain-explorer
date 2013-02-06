define [
  'app'
  'backbone.marionette'
  'codemirror'
], (app, Marionette, CodeMirror) ->

  Marionette.ItemView.extend
    template: 'domain/query'

    className: 'view-query'

    triggers:
      'click .execute': 'execute'

    onShow: ->
      @editor = CodeMirror @$('.editor')[0],
        mode: 'text/x-sql'
        lineNumbers: true
      @editor.focus()

    resize: ->
      @editor.setSize null, @$('.editor').height()
      @editor.refresh()

    getQuery: ->
      @editor.getValue()