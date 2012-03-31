(function (App, Backbone, $) {

    var Layout = Backbone.Marionette.Layout.extend({

        template: "#layout-template",

        className: 'layout',

        regions: {
            list: "#list",
            main: "#main"
        },

        initialize: function(){
        }
    });

    App.addInitializer(function(){
        App.layout = new Layout();

        App.layout.render().done(function() {
            $("body").prepend(App.layout.el);
            App.layout.$el.layout({
                west__paneSelector: '#list',
                west__size: 400,
                center__paneSelector: '#main'
            });
        });
    });
})(App, Backbone, $);

App.bind("initialize:after", function(options){
    if (Backbone.history){
        Backbone.history.start();
    }
});

App.start({});