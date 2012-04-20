Dex.Domain = (function (Dex, Backbone) {
    var Domain = {};

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

    Domain.DomainModel = Backbone.Model.extend({});

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
            var headerView = new Domain.DomainHeaderView({model: this.model});
            this.header.show(headerView);

            var toolbarView = new Domain.InstanceToolbarView();
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
        className: 'btn-toolbar'
    });

    Domain.DomainListItemView = Backbone.Marionette.ItemView.extend({
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

        renderHtml: function (data) {
            var properties = this.domainType.get('properties');
            return _.collect(properties,
            function (property) {
                var valueHtml = '',
                value = this.model.get(property.name);
                if (value === null) {
                    valueHtml = '<span class="instanceValue null">' + value + '</span>';
                } else if (property.oneToOne || property.manyToOne) {
                    var className = _.last(property.type.split('.'));
                    valueHtml = '<span class="nowrap">' + className + ': ' + value + '</span>'; // TODO ??
                } else {
                    valueHtml = value;
                }
                return '<td>' + valueHtml + '</td>';
            }, this).join('');
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

    Domain.DomainInstanceModel = Backbone.Model.extend({});

    Domain.DomainInstanceCollection = Backbone.Collection.extend({
        model: Domain.DomainInstanceModel
    });

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
        }
    });

    Dex.addInitializer(function () {
        Domain.router = new Router({
            controller: Domain
        });
    });

    return Domain;
})(Dex, Backbone);


