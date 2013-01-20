define [
  'app'
  'backbone'
  '../models/breadcrumb'
], (app, Backbone, BreadcrumbModel) ->
  Backbone.Collection.extend
    model: BreadcrumbModel