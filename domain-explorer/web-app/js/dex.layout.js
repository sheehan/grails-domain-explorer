(function (Dex, Backbone, $) {

    var Layout = Backbone.Marionette.Layout.extend({

        template: "layout",

        className: 'layout',

        initialize: function() {
            _.bindAll(this, 'resize');
        },

        regions: {
            list: "#list-wrapper",
            main: "#main-wrapper",
            clazz: "#class-wrapper"
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
                west__closable: false,
                center__paneSelector: '#main-wrapper',
                east__paneSelector: '#class-wrapper ',
                east__size: 450,
                east__closable: false,
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
        Dex.layout.render();
        $("body").prepend(Dex.layout.el);
        Dex.content.show(Dex.layout);
    });
})(Dex, Backbone, $);
