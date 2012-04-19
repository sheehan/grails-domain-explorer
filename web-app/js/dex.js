_.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
};

Dex = new Backbone.Marionette.Application({
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

Dex.StackableRegion = Backbone.Marionette.Region.extend({

    constructor: function() {
        this.stack = [];
        Backbone.Marionette.Region.prototype.constructor.apply(this, arguments);
    },

    push: function(view) {
        this.ensureEl();
        this.stack.push(view);
        if (this.currentView) {
            this.currentView.$el.hide();
            this.currentView = view;
            this.open(view, 'append');
        }
    },

    pop: function() {
        this.stack.pop();
        this.close();
        if (this.stack.length) {
            this.currentView = this.stack[this.stack.length - 1];
            this.currentView.$el.show();
        }
    },

    show: function(view, appendMethod){
        this.ensureEl();

        this.close();
        this.open(view, appendMethod);

        this.currentView = view;
    }
});

var testing = {

    showDomain: function() {

    },

    showInstance: function(fullName, id) {

    },

    showProperty: function() {

    },

    processRoute: function() {
        var tokens = Backbone.history.getFragment().split('/');

    }

};













