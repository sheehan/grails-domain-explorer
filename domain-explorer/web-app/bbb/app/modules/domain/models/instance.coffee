define [
  'app'
  'backbone'
  'jquery'
], (app, Backbone, $) ->
  Instance = Backbone.Model.extend

    fetchPropertyOne: (propertyName) ->
      url = app.createLink 'domain', 'findPropertyOne'
      dfd = $.post url,
        className: @get 'className'
        id: @id
        property: propertyName

      dfd.then (resp) ->
        instance = new Instance(resp.value)
        instance.clazz = resp.clazz
        instance

    updateWithData: (data) ->
      dfd = $.Deferred()
      url = "#{app.baseUrl}/domain/rest/#{@get 'className'}/#{@id}"
      postData = _.extend data,
        className: @get 'className'
        id: @id
      $.ajax(
        url: url
        type: 'PUT'
        data: JSON.stringify postData
      ).done((data) =>
        @set data.data
        dfd.resolveWith null, [data]
      ).fail (r) =>
        data = JSON.parse(r.responseText)
        dfd.rejectWith null, [data]

      dfd
