# Set the require.js configuration for your application.
require.config

# Initialize the application with the main application file and the JamJS
# generated configuration file.
  deps: ["../vendor/jam/require.config", "main"]
  paths:
    jst: "../jst.r"
    "backbone.wreqr": "../vendor/backbone.marionette/backbone.wreqr"
    "backbone.eventbinder": "../vendor/backbone.marionette/backbone.eventbinder"
    "backbone.babysitter": "../vendor/backbone.marionette/backbone.babysitter"
    "backbone.marionette": "../vendor/backbone.marionette/backbone.marionette"
    "backbone.stickit": "../vendor/js/libs/backbone.stickit"
    mousetrap: "../vendor/js/libs/mousetrap.min"
    dataTables: "../vendor/DataTables-1.9.4/media/js/jquery.dataTables"
    moment: "../vendor/js/libs/moment"
    layout: "../vendor/js/libs/jquery.layout-latest"

  shim:
    "backbone.stickit":
      deps: ['underscore', 'backbone']


# Put shims here.