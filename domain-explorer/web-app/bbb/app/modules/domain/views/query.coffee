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
      console.log 'show codemirror'
      @editor = CodeMirror.fromTextArea @$('textarea')[0],
        mode: 'text/x-sql'
        lineNumbers: true
      @editor.focus()

    onResize: ->
      @editor.refresh()

    getQuery: ->
      @editor.getValue()