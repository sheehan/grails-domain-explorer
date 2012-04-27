(function (Dex, Backbone, $) {

    var Layout = Backbone.Marionette.Layout.extend({

        template: "#layout-template",

        className: 'layout',

        initialize: function() {
            _.bindAll(this, 'resize');
        },

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
                center__paneSelector: '#main-wrapper',
                onresize: _.bind(this.resize, this)
            });
            _.each(this.regionManagers, function (manager, name) {
                manager.on('view:show', function (view) {
                    that.$el.layout().resizeAll();
                    view && view.resize && view.resize();

                });
            });
        },

        resize: _.debounce(function() {
            _.each(this.regionManagers, function(manager, name) {
                var view = manager.currentView;
                view && view.resize && view.resize();
            });
        }, 100)
    });

    Dex.addInitializer(function () {
        Dex.layout = new Layout();
        Dex.layout.render().done(function () {
            $("body").prepend(Dex.layout.el);
        });
        Dex.content.show(Dex.layout);
    });
})(Dex, Backbone, $);
