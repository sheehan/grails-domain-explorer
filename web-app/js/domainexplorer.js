_.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
};

App = new Backbone.Marionette.Application({
    start: function(options) {
        this.options = options;
        Backbone.Marionette.Application.prototype.start.apply(this, arguments);
    },

    createLink: function(controller, action, params) {
        var url = this.options.serverURL + '/' + controller;
        if (action) {
            url += '/' + action;
        }
        if (params != undefined) {
            if (params.id) {
                url += '/' + params.id;
                delete params.id;
            }
            var queryString = $.param(params, true);
            if (queryString.length > 0) {
                url += '?' + queryString;
            }
        }
        return url;
    }
});