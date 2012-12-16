define([
    "backbone.layoutmanager",
    "backbone.marionette"
], function () {

    // Provide a global location to place configuration settings and module
    // creation.
    var app = new Backbone.Marionette.Application({

        // The root path to run the application.
        root: "/bookstore/plugins/domain-explorer-0.1/bbb/", // TODO,

        start: function (options) {
            this.options = options;
            Backbone.Marionette.Application.prototype.start.apply(this, arguments);
        },

        createLink: function (controller, action, params) {
            var url = this.options.serverURL + '/' + controller;
            if (action) {
                url += '/' + action;
            }
            if (params !== undefined) {
                if (params.id) {
                    url += '/' + params.id;
                    delete params.id;
                }
                var queryString = jQuery.param(params, true);
                if (queryString.length > 0) {
                    url += '?' + queryString;
                }
            }
            return url;
        }
    });

    // Localize or create a new JavaScript Template object.
    var JST = window.JST = window.JST || {};

    // Configure LayoutManager with Backbone Boilerplate defaults.
    Backbone.LayoutManager.configure({
        // Allow LayoutManager to augment Backbone.View.prototype.
        manage: true,

        prefix: "app/templates/",

        fetch: function (path) {
            // Concatenate the file extension.
            path = path + ".html";

            // If cached, use the compiled template.
            if (JST[path]) {
                return JST[path];
            }

            // Put fetch into `async-mode`.
            var done = this.async();

            // Seek out the template asynchronously.
            $.get(app.root + path, function (contents) {
                done(JST[path] = _.template(contents));
            });
        }
    });

    // Mix Backbone.Events, modules, and layout management into the app object.
    return _.extend(app, {
        // Create a custom object with a nested Views object.
        module: function (additionalProps) {
            return _.extend({ Views: {} }, additionalProps);
        },

        // Helper for using layouts.
        useLayout: function (name, options) {
            // Enable variable arity by allowing the first argument to be the options
            // object and omitting the name argument.
            if (_.isObject(name)) {
                options = name;
            }

            // Ensure options is an object.
            options = options || {};

            // If a name property was specified use that as the template.
            if (_.isString(name)) {
                options.template = name;
            }

            // Create a new Layout with options.
            var layout = new Backbone.Layout(_.extend({
                el: "#main"
            }, options));

            // Cache the refererence.
            return this.layout = layout;
        }
    }, Backbone.Events);

});
