# Set the require.js configuration for your application.
require.config

# Initialize the application with the main application file and the JamJS
# generated configuration file.
  deps: ['../vendor/jam/require.config', 'main']
  paths:
    jst: '../jst.r'
    'backbone': '../vendor/backbone/backbone'
    'backbone.wreqr': '../vendor/backbone.marionette/backbone.wreqr'
    'backbone.eventbinder': '../vendor/backbone.marionette/backbone.eventbinder'
    'backbone.babysitter': '../vendor/backbone.marionette/backbone.babysitter'
    'backbone.marionette': '../vendor/backbone.marionette/backbone.marionette'
    'backbone.stickit': '../vendor/js/libs/backbone.stickit'
    mousetrap: '../vendor/js/libs/mousetrap.min'
    dataTables: '../vendor/DataTables-1.9.4/media/js/jquery.dataTables'
    codemirror: '../vendor/codemirror-3.02/mode/sql/sql'
    moment: '../vendor/js/libs/moment'
    layout: '../vendor/js/libs/jquery.layout-latest'
    'jquery.ui': '../vendor/jquery-ui-1.10.0.custom/js/jquery-ui-1.10.0.custom'

  shim:
    'backbone':
      'deps': [
        'jquery'
        'lodash'
      ]
      'exports': 'Backbone'
    'backbone.stickit':
      deps: ['backbone']
    'codemirror':
      deps: [
        '../vendor/codemirror-3.02/lib/codemirror'
      ]
      'exports': 'CodeMirror'
    'jquery.ui':
      deps: [
        'jquery'
      ]