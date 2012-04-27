Dex.DomainList = (function (Dex, Backbone) {
    var DomainList = {};

    DomainList.DomainCount = Backbone.Model.extend({});

    DomainList.DomainCountCollection = Backbone.Collection.extend({
        url: function() { return Dex.createLink('domain', 'list') },
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
            Backbone.history.navigate(this.model.get('fullName'), {trigger: true});
        }
    });

    DomainList.DomainCountSectionView = Backbone.Marionette.CompositeView.extend({
        template: '#domain-count-section-template',
        tagName: 'section',
        attributes: { id: 'list', 'class': 'ui-layout-content'},
        itemView: DomainList.DomainCountItemView,

        appendHtml: function (collectionView, itemView) {
            this.$('ul').append(itemView.el);
        },

        onRender: function () {
            this.highlightActiveView();
        },

        resize: function() {
            Dex.DomUtil.sizeHeightToFillParent(this.$el.children('.content'));
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
        }
    });

    DomainList.showDomain = function (fullName) {
        DomainList.domainCountSectionView.setActiveView(fullName);
    };

    Dex.addInitializer(function (options) {
        DomainList.domainCountList = new DomainList.DomainCountCollection();
        DomainList.domainCountList.fetch();
        DomainList.domainCountSectionView = new DomainList.DomainCountSectionView({
            collection: DomainList.domainCountList
        });
    });


    Dex.vent.bind("domain:show", DomainList.showDomain);

    Dex.bind("initialize:after", function (options) {
        Dex.layout.list.show(DomainList.domainCountSectionView);
    });

    return DomainList;
})(Dex, Backbone);


