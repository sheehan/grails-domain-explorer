Dex.module('DomainType', function(DomainType, Dex, Backbone, Marionette, $, _){
    var Views = DomainType.Views = {};

    Views.Header = Dex.ItemView.extend({
        renderHtml: function () {
            return this.model.get('name');
        }
    });

    Views.Toolbar = Dex.ItemView.extend({
        template: '#domain-type-toolbar-view-template'
    });

    Views.Property = Dex.ItemView.extend({
        template: '#domain-type-property-view-template',
        tagName: 'tr'
    });

    Views.Properties = Backbone.Marionette.CompositeView.extend({
        itemView: Views.Property,
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

    Views.Content = Backbone.Marionette.Layout.extend({
        template: '#domain-type-content-view-template',

        regions: {
            toolbar: '.toolbar',
            content: '.content'
        },

        onRender: function () {
            var that = this;

            var toolbarView = new Views.ContentToolbar();
            this.toolbar.show(toolbarView);

            var link = Dex.createLink('domain', 'listInstances', {fullName: this.model.get('fullName')});
            $.getJSON(link).done(function (resp) {
                var collection = new Dex.Domain.DomainInstanceCollection(resp.list);
                var view = new Dex.Domain.Views.List({
                    model: collection,
                    domainType: that.model
                });
                that.content.show(view);
            });
        }
    });

    Views.ContentToolbar = Dex.ItemView.extend({
        template: '#domain-type-content-toolbar-view-template',
        className: 'btn-toolbar'
    });

    Views.Relations = Dex.ItemView.extend({
        template: '#domain-type-relations-view-template'
    });

    Views.Query = Dex.ItemView.extend({
        template: '#domain-type-query-view-template'
    });

    Views.DomainType = Backbone.Marionette.Layout.extend({
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
            var headerView = new Views.Header({model: this.model});
            this.header.show(headerView);

//            var toolbarView = new DomainType.ToolbarView();
//            this.toolbar.show(toolbarView);

            this.showStructure();
        },

        showStructure: function () {
            this.$('button.structure').button('toggle');
            var view = new Views.Properties({
                model: this.model
            });
            this.content.show(view);
        },

        showContent: function () {
            var that = this;
            this.$('button.content').button('toggle');
            var view = new Views.Content({
                model: this.model
            });
            this.content.show(view);
        },

        showRelations: function () {
            this.$('button.relations').button('toggle');
            var view = new Views.Relations({
                model: this.model
            });
            this.content.show(view);

        },

        showQuery: function () {
            this.$('button.query').button('toggle');
            var view = new Views.Query({
                model: this.model
            });
            this.content.show(view);
        }

    });

    Handlebars.registerHelper('nullable', function () {
        return (this.constraints && this.constraints.nullable) ? 'true' : 'false';
    });
});


