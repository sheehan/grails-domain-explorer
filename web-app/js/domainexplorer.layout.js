(function (App, Backbone, $) {

    var Layout = Backbone.Marionette.Layout.extend({

        template: "#layout-template",

        className: 'layout',

        regions: {
            list: "#list-wrapper",
            main: "#main-wrapper #main .content"
        },

        initialize: function(){
        }
    });

    App.addInitializer(function(){
        App.layout = new Layout();

        App.layout.render().done(function() {
            $("body").prepend(App.layout.el);
            App.layout.$el.layout({
                west__paneSelector: '#list-wrapper',
                west__size: 400,
                center__paneSelector: '#main-wrapper'
            });
        });
        App.layout.list.on('view:show', function(view) {
            _.delay(function() { // TODO LESS
                App.layout.$el.layout().resizeAll();
                $(window).resize();
            }, 1000);
        });
    });
})(App, Backbone, $);

App.bind("initialize:after", function(options){
    if (Backbone.history){
        Backbone.history.start();
    }
});

App.start({});