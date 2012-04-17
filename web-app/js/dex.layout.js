(function (Dex, Backbone, $) {

    var Layout = Backbone.Marionette.Layout.extend({

        template: "#layout-template",

        className: 'layout',

        regions: {
            list: "#list-wrapper",
            main: "#main-wrapper #main .content"
        },

        onRender: function () {
            var that = this;
            this.$el.layout({
                north__paneSelector: '#head-wrapper',
                north__size: 40,
                north__resizable: false,
                north__closable: false,
                north__spacing_open: 0,
                west__paneSelector: '#list-wrapper',
                west__size: 350,
                center__paneSelector: '#main-wrapper'
            });
            _.each(this.regionManagers, function (manager, name) {
                // TODO $(window).resize();
                manager.on('view:show', function (view) {
                    that.$el.layout().resizeAll();
                    view.resize && view.resize();
                    view.on("render", function () {
                        view.resize && view.resize();
                    });
                });
            });
        }
    });

    Dex.addInitializer(function () {
        Dex.layout = new Layout();
        Dex.layout.render().done(function () {
            $("body").prepend(Dex.layout.el);
        });
    });
})(Dex, Backbone, $);

Dex.bind("initialize:after", function (options) {
    if (Backbone.history) {
        Backbone.history.start();
    }
});