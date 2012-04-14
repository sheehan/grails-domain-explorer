App.DomainList = (function (App, Backbone) {
    var DomainList = {};

    DomainList.DomainCount = Backbone.Model.extend({
    });

    DomainList.DomainCountCollection = Backbone.Collection.extend({
        url: '/refine/domain/list',
        model: DomainList.DomainCount
    });

    DomainList.DomainCountItemView = Backbone.Marionette.ItemView.extend({
        template: '#domain-count-item-template',
        tagName: 'li',

        events: {
            'click': '_handleClick'
        },

        _handleClick: function (event) {
            event.preventDefault();
            App.vent.trigger("domain:show", this.model.get('fullName'));
        }
    });

    DomainList.DomainCountSectionView = Backbone.Marionette.CompositeView.extend({
        template: '#domain-count-section-template',
        tagName: 'section',
        attributes: { id: 'list', 'class': 'ui-layout-content'},
        itemView: DomainList.DomainCountItemView,

        initialize: function () {
            _.bindAll(this, '_resizeListener');
            $(window).resize(this._resizeListener);
        },

        appendHtml: function (collectionView, itemView) {
            this.$('ul').append(itemView.el);
        },

        onRender: function () {
            this.resize();
            this.highlightActiveView();
        },

        highlightActiveView: function () {
            if (this.activeFullName) {
                var activeView = this.findItemViewByFullName(this.activeFullName);
                if (activeView) {
                    activeView.$el.addClass('active');
                }
            }
        },

        removeHighlight: function () {
            if (this.activeFullName) {
                var activeView = this.findItemViewByFullName(this.activeFullName);
                if (activeView) {
                    activeView.$el.removeClass('active');
                }
            }
        },

        setActiveView: function (fullName) {
            this.removeHighlight();
            this.activeFullName = fullName;
            this.highlightActiveView();
        },

        findItemViewByFullName: function (fullName) {
            return _.find(this.children, function (childView) { return childView.model.get('fullName') == fullName; });
        },

        resize: function () {
            var $target = this.$el.find('.content');
            var parentHeight = this.$el.height();
            var childrenHeight = 0;
            this.$el.children().each(function () {
                childrenHeight += $(this).outerHeight();
            });
            $target.height($target.height() - childrenHeight + parentHeight).css({'overflow': 'auto'});
        },

        _resizeListener: _.debounce(function () {
            this.resize();
        }, 500),

        close: function () {
            $(window).off('resize', this._resizeListener);
        }
    });

    DomainList.showDomainCountList = function () {
        App.layout.list.show(DomainList.domainCountSectionView);
    };

    DomainList.showDomain = function (fullName) {
        DomainList.domainCountSectionView.setActiveView(fullName);
    };

    App.addInitializer(function (options) {
        DomainList.domainCountList = new DomainList.DomainCountCollection();
        DomainList.domainCountList.fetch();
        DomainList.domainCountSectionView = new DomainList.DomainCountSectionView({
            collection: DomainList.domainCountList
        });
    });


    App.vent.bind("domain:show", DomainList.showDomain);

    App.bind("initialize:after", function (options) {
        DomainList.showDomainCountList();
    });

    return DomainList;
})(App, Backbone);


(function (App, Backbone, $) {
    var Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
//            "": "showDomainCountList",
//            "domain/:fullName": "showDomain"
        }
    });

    App.addInitializer(function () {
        App.router = new Router({
            controller: App.DomainList
        });
    });
})(App, Backbone, $);


