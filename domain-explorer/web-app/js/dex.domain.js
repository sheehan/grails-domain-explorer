Dex.Domain = (function (Dex, Backbone) {
    var Domain = {};

    Domain.DomainModel = Backbone.Model.extend({});

    Domain.DomainInstanceModel = Backbone.Model.extend({
        urlRoot: function() {
            return Dex.createLink('domain', 'rest');
        }
    });

    Domain.DomainInstanceCollection = Backbone.Collection.extend({
        model: Domain.DomainInstanceModel
    });

    Domain.DomainSectionView = Backbone.Model.extend({
        className: 'domainView'
    });

    Domain.DomainHeaderView = Backbone.Marionette.ItemView.extend({
        renderHtml: function (data) {
            var tokens = Backbone.history.getFragment().split('/'),
            html = '',
            path = '';
            _.each(tokens, function (token, index) {
                path += token;
                var isFirst = index === 0,
                isLast = index === tokens.length - 1;
                if (isFirst) {
                    token = _.last(token.split('.'));
                }
                var itemHtml = '<a href="#" data-path="' + path + '">' + token + '</a>';
                if (!isLast) {
                    itemHtml += ' <span class="divider">/</span>';
                    path += '/';
                }
                html += '<li class="' + (isLast ? 'active' : '') + '">' + itemHtml + '</li>';
            });
            return '<ul class="breadcrumb">' + html + '</ul>';
        },

        onRender: function () {
            this.$('a').click(function (event) {
                event.preventDefault();
                var path = $(this).data('path');
                Domain.router.navigate(path, {trigger: true});
            });
        }
    });

    Domain.DomainView = Backbone.Marionette.Layout.extend({
        template: '#domain-template',

        className: 'domainView',

        events: {},

        regions: {
            header: '.header',
            toolbar: '.toolbar',
            content: '.content'
        },

        initialize: function (options) {
            this.domainType = options.domainType;
            this.isCollection = options.isCollection;
        },

        resize: function () {
            Dex.DomUtil.sizeHeightToFillParent(this.$el.children('.content'));
        },

        onRender: function () {
            if (this.isCollection) {
                this.showList();
            } else {
                this.showInstance();
            }
        },

        showList: function () {
            var headerView = new Domain.DomainHeaderView({model: this.model});
            this.header.show(headerView);

            var toolbarView = new Domain.ListToolbarView();
            this.toolbar.show(toolbarView);

            var view = new Domain.ListView({
                model: this.model,
                domainType: this.domainType
            });
            this.content.show(view);
        },

        showInstance: function () {
            var that = this;
            var headerView = new Domain.DomainHeaderView({model: this.model});
            this.header.show(headerView);

            var toolbarView = new Domain.InstanceToolbarView();
            toolbarView.on('delete', function() {
                var confirmDeleteView = new Domain.ConfirmDeleteView();
                confirmDeleteView.render();
                Dex.modal.show(confirmDeleteView);
//                that.model.destroy();
            });
            this.toolbar.show(toolbarView);

            var view = new Domain.Instance.ShowView({
                model: this.model,
                domainType: this.domainType
            });
            this.content.show(view);
        }
    });

    Domain.ListToolbarView = Backbone.Marionette.ItemView.extend({
        template: '#domain-list-toolbar',
        className: 'btn-toolbar'
    });

    Domain.InstanceToolbarView = Backbone.Marionette.ItemView.extend({
        template: '#domain-instance-toolbar',
        className: 'btn-toolbar',

        events: {
            'click .delete': '_handleDeleteClick'
        },

        _handleDeleteClick: function(event) {
            event.preventDefault();
            this.trigger('delete');
        }
    });

    Domain.DomainListItemView = Backbone.Marionette.ItemView.extend({
        template: '#domain-list-item-view-template',
        tagName: 'tr',

        events: {
            'click': '_handleRowClick'
        },

        initialize: function (options) {
            this.domainType = options.domainType;
        },

        _handleRowClick: function () {
            Domain.router.appendRoute(this.model.id);
        },

        serializeData: function(){
            return _.map(this.domainType.toJSON().properties, function(property) {
                return {
                    property: property,
                    value: this.model.get(property.name)
                }
            }, this);
        }

    });


    Domain.ListView = Backbone.Marionette.CompositeView.extend({
        itemView: Domain.DomainListItemView,
        tagName: 'table',
        className: 'table table-striped',

        initialize: function (options) {
            this.domainType = options.domainType;
            this.collection = this.model;
        },

        buildItemView: function (item, ItemView) {
            var view = new ItemView({
                model: item,
                domainType: this.domainType
            });
            return view;
        },

        renderModel: function () {
            var properties = this.domainType.get('properties');
            var html = _.collect(properties,
            function (property) {
                return '<th>' + property.name + '</th>';
            }, this).join('');
            return '<thead><tr>' + html + '</tr></thead><tbody></tbody>';
        },

        appendHtml: function (collectionView, itemView) {
            collectionView.$('tbody').append(itemView.el);
        }
    });

    Domain.EmptyView = Backbone.Marionette.ItemView.extend({
        renderHtml: function (data) {
            return 'select some shit';
        }
    });

    Domain.ConfirmDeleteView = Backbone.Marionette.ItemView.extend({
        template: '#confirm-delete-template'
    });


    Domain.show = function (fragment) {
        var link = Dex.createLink('domain', 'fromPath', { path: fragment });
        $.getJSON(link).done(function (resp) {
            var model, view, domainType;
            if (resp.isCollection) {
                model = new Domain.DomainInstanceCollection(resp.value);
            } else {
                model = new Domain.DomainInstanceModel(resp.value);
            }
            domainType = new Domain.DomainModel(resp.clazz);
            view = new Domain.DomainView({
                model: model,
                domainType: domainType,
                isCollection: resp.isCollection
            });
            Dex.layout.main.show(view);
        });
    };

    var Router = Backbone.Router.extend({
        routes: {
            "*fragment": "showDomainRoute"
        },

        showDomainRoute: function (fragment) {
            var fullName;
            if (fragment) {
                Domain.show(fragment);
                fullName = fragment.split('/')[0];
            } else {
                var view = new Domain.EmptyView();
                Dex.layout.main.show(view);
            }
            Dex.vent.trigger("domain:show", fullName);
        },

        appendRoute: function(token) {
            var fragment = Backbone.history.getFragment();
            Domain.router.navigate(fragment + '/' + token, {trigger: true});
        },

        back: function() {
            window.history.back();
        }
    });

    Dex.addInitializer(function () {
        Domain.router = new Router({});
    });


    Handlebars.registerHelper('property_value_cell', function() {
        var property = this.property,
            value = this.value,
            valueHtml;
        if (property.oneToMany || property.manyToMany) {
            valueHtml = '<span class="instanceValue oneToMany">[' + value + ']</span>';
        } else if (value === null) {
            valueHtml = '<span class="instanceValue null">' + value + '</span>';
        } else if (property.oneToOne || property.manyToOne) {
            var className = _.last(property.type.split('.'));
            valueHtml = '<span class="nowrap">' + className + ': ' + value + '</span>';
        } else {
            valueHtml = value;
        }
        return new Handlebars.SafeString(valueHtml);
    });

    return Domain;
})(Dex, Backbone);

