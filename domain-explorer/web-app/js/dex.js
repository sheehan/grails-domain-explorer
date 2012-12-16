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

Dex.ItemView = Backbone.Marionette.ItemView.extend({
    render: function(){
        if (this.beforeRender){ this.beforeRender(); }
        this.trigger("before:render", this);
        this.trigger("item:before:render", this);

        var data = this.serializeData();
        var html = this.renderHtml(data);
        this.$el.html(html);

        if (this.onRender){ this.onRender(); }
        this.trigger("render", this);
        this.trigger("item:rendered", this);
    },

    renderHtml: function(data) {
        var template = this.getTemplate();
        return Backbone.Marionette.Renderer.render(template, data);
    }
});


Dex.bind("initialize:before", function (options) {
    Dex.addRegions({
        content: "#main-content",
        modal: Dex.Modal.ModalRegion
    });
});

Dex.bind("initialize:after", function (options) {
    Backbone.history && Backbone.history.start();
});

Backbone.Marionette.Renderer.render = function(template, data){
    return Handlebars.templates[template](data);
};














