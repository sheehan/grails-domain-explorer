Dex.DomainType = (function (Dex, Backbone) {
    var DomainType = {};

    DomainType.HeaderView = Dex.ItemView.extend({
        renderHtml: function () {
            return this.model.get('name');
        }
    });

    DomainType.ToolbarView = Dex.ItemView.extend({
        template: '#domain-type-toolbar-view-template'
    });

    DomainType.PropertyView = Dex.ItemView.extend({
        template: '#domain-type-property-view-template',
        tagName: 'tr'
    });

    DomainType.PropertiesView = Backbone.Marionette.CompositeView.extend({
        itemView: DomainType.PropertyView,
        tagName: 'table',
        className: 'table table-striped',

        initialize: function () {
            this.collection = new Backbone.Collection(this.model.get('properties'));
        },

        renderModel: function () {
            return '<thead><tr><th>Property</th><th>Type</th><th>Nullable</th></tr></thead><tbody></tbody>';
        },

        appendHtml: function (collectionView, itemView) {
            collectionView.$('tbody').append(itemView.el);
        }
    });

    DomainType.ContentView = Backbone.Marionette.Layout.extend({
        template: '#domain-type-content-view-template',

        regions: {
            toolbar: '.toolbar',
            content: '.content'
        },

        onRender: function () {
            var that = this;

            var toolbarView = new DomainType.ContentToolbarView();
            this.toolbar.show(toolbarView);

            var link = Dex.createLink('domain', 'listInstances', {fullName: this.model.get('fullName')});
            $.getJSON(link).done(function (resp) {
                var collection = new Dex.Domain.DomainInstanceCollection(resp.list);
                var view = new Dex.Domain.ListView({
                    model: collection,
                    domainType: that.model
                });
                that.content.show(view);
            });
        }
    });

    DomainType.ContentToolbarView = Dex.ItemView.extend({
        template: '#domain-type-content-toolbar-view-template',
        className: 'btn-toolbar'
    });

    DomainType.RelationsView = Dex.ItemView.extend({
        template: '#domain-type-relations-view-template'
    });

    DomainType.QueryView = Dex.ItemView.extend({
        template: '#domain-type-query-view-template'
    });

    DomainType.DomainTypeView = Backbone.Marionette.Layout.extend({
        template: '#domain-type-template',

        className: 'domainTypeView',

        events: {
            'click button.structure': 'showStructure',
            'click button.content': 'showContent',
            'click button.relations': 'showRelations',
            'click button.query': 'showQuery'
        },

        regions: {
            header: '.header',
            toolbar: '.toolbar',
            content: 'div.content'
        },

        resize: function () {
            Dex.DomUtil.sizeHeightToFillParent(this.$el.children('.content'));
        },

        onRender: function () {
            var headerView = new DomainType.HeaderView({model: this.model});
            this.header.show(headerView);

//            var toolbarView = new DomainType.ToolbarView();
//            this.toolbar.show(toolbarView);

            this.showStructure();
        },

        showStructure: function () {
            this.$('button.structure').button('toggle');
            var view = new DomainType.PropertiesView({
                model: this.model
            });
            this.content.show(view);
        },

        showContent: function () {
            var that = this;
            this.$('button.content').button('toggle');
            var view = new DomainType.ContentView({
                model: this.model
            });
            this.content.show(view);
        },

        showRelations: function () {
            this.$('button.relations').button('toggle');
            var view = new DomainType.RelationsView({
                model: this.model
            });
            this.content.show(view);

        },

        showQuery: function () {
            this.$('button.query').button('toggle');
            var view = new DomainType.QueryView({
                model: this.model
            });
            this.content.show(view);
        }

    });

    Handlebars.registerHelper('nullable', function () {
        return (this.constraints && this.constraints.nullable) ? 'true' : 'false';
    });

    return DomainType;
})(Dex, Backbone);


