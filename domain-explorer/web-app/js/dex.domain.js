Dex.module('Domain', function (Domain, Dex, Backbone, Marionette, $, _) {
    var Views = Domain.Views = {};

    Domain.DomainModel = Backbone.Model.extend({});

    Domain.ClazzCache = {
        clazzes: {},
        get: function (fullName) {
            return this.clazzes[fullName]
        },
        add: function (clazz) {
            this.clazzes[clazz.get("fullName")] = clazz;
        }
    };

    Domain.DomainInstanceModel = Backbone.Model.extend({
        urlRoot: function () {
            return Dex.createLink('domain/rest/' + this.get('className'));
        },

        getClazz: function () {
            return Domain.ClazzCache.get(this.get('className'));
        },

        updateWithData: function (data) {
            var dfd = $.Deferred();
            var that = this;
            var url = this.urlRoot() + '/' + this.id;
            $.ajax({
                url: url,
                type: 'PUT',
                data: JSON.stringify(data)
            }).done(function (data) {
                    that.set(data.data);
                    dfd.resolveWith(null, [data]);
                }).fail(function (r) {
                    var data = JSON.parse(r.responseText);
                    dfd.rejectWith(null, [data]);
                });

            return dfd;
        }
    });

    Domain.DomainInstanceCollection = Backbone.Collection.extend({
        model: Domain.DomainInstanceModel
    });

    Views.DomainHeader = Dex.ItemView.extend({
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

    Views.Hql = Dex.ItemView.extend({
        template: 'domain/hqlSection',
        className: 'hql-view'
    });

    Views.Domain = Marionette.Layout.extend({
        template: 'domain/domain',

        className: 'domainView',

        events: {},

        regions: {
            header: '.header',
            hql: '.hql',
            toolbar: '.toolbar',
            content: '.content'
        },

        initialize: function (options) {
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
            var that = this;
            var headerView = new Views.DomainHeader({model: this.model});
            this.header.show(headerView);

            var hqlView = new Views.Hql();
            this.hql.show(hqlView);

            var toolbarView = new Views.ListToolbar();
            toolbarView.on('create', function () {
                that.showCreateInstance();
            });
            this.toolbar.show(toolbarView);

            var view = new Views.List({
                collection: this.model
            });
            this.content.show(view);
        },

        showInstance: function () {
            var that = this;
            var headerView = new Views.DomainHeader({model: this.model});
            this.header.show(headerView);

            var toolbarView = new Domain.Instance.Views.Toolbar();
            toolbarView.on('delete', function () {
                var confirmDeleteView = new Views.ConfirmDelete();
                confirmDeleteView.render();
                confirmDeleteView.on('delete', function () {
                    that.model.destroy();
                });
                Dex.modal.show(confirmDeleteView);
            });
            toolbarView.on('edit', function () {
                that.showEditInstance();
            });
            this.toolbar.show(toolbarView);

            var view = new Domain.Instance.Views.Show({
                model: this.model
            });
            this.content.show(view);
        },

        showCreateInstance: function () {
            var that = this;
            var headerView = new Views.DomainHeader({model: this.model});
            this.header.show(headerView);

            var view = new Domain.Instance.Views.Edit({
                model: this.model
            });
            this.content.show(view);
        },

        showEditInstance: function () {
            var that = this;
            var headerView = new Views.DomainHeader({model: this.model});
            this.header.show(headerView);

            var toolbarView = new Domain.Instance.Views.EditToolbar();
            toolbarView.on('save', function () {
                view.setSaving(true);
                var data = view.serialize();
                var dfd = that.model.updateWithData(data);
                dfd.done(function (data) {
                    that.showInstance();
                });
                dfd.fail(function (data) {
                    view.setSaving(false);
                    view.showErrors(data.errors);
                });
            });
            toolbarView.on('cancel', function () {
                that.showInstance();
            });
            this.toolbar.show(toolbarView);

            var view = new Domain.Instance.Views.Edit({
                model: this.model
            });
            this.content.show(view);
        }
    });

    Views.ListToolbar = Dex.ItemView.extend({
        template: 'domain/listToolbar',
        className: 'btn-toolbar',

        events: {
            'click .create': '_handleCreateClick'
        },

        _handleCreateClick: function (event) {
            event.preventDefault();
            this.trigger('create');
        }
    });

    Views.DomainListItem = Dex.ItemView.extend({
        template: 'domain/listItemView',
        tagName: 'tr',

        events: {
            'click': '_handleRowClick'
        },

        _handleRowClick: function () {
            Domain.router.appendRoute(this.model.id);
        },

        serializeData: function () {
            return _.map(this.model.clazz.get('properties'), function (property) {
                return {
                    property: property,
                    value: this.model.get(property.name)
                };
            }, this);
        }

    });


    Views.List = Marionette.CompositeView.extend({
        itemView: Views.DomainListItem,
        tagName: 'table',
        className: 'table table-striped',

        renderModel: function () {
            var properties = this.collection.referencedClazz.get('properties');
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

    Views.Empty = Dex.ItemView.extend({
        template: 'domain/empty',
        className: 'emptyView'
    });

    Views.ConfirmDelete = Dex.ItemView.extend({
        template: 'domain/confirmDelete',
        events: {
            'click .cancel': '_handleCancelClick',
            'click .delete': '_handleDeleteClick'
        },
        _handleCancelClick: function (event) {
            event.preventDefault();
            this.close();
        },
        _handleDeleteClick: function (event) {
            event.preventDefault();
            this.trigger('delete');
            this.close();
        }
    });


    Domain.show = function (fragment) {
        var link = Dex.createLink('domain', 'fromPath', { path: fragment });
        $.getJSON(link).done(function (resp) {
            var clazz = new Domain.DomainModel(resp.clazz);
            var clazzView = new Dex.DomainType.Views.DomainType({ model: clazz });
            Dex.layout.clazz.show(clazzView);

            var model;
            if (resp.isCollection) {
                model = new Domain.DomainInstanceCollection(resp.value);
                model.referencedClazz = clazz;
                model.each(function (item) {item.clazz = clazz;});
            } else {
                model = new Domain.DomainInstanceModel(resp.value);
                model.clazz = clazz;
            }
            var view = new Views.Domain({
                model: model,
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
                var view = new Views.Empty();
                Dex.layout.main.show(view);
            }
            Dex.vent.trigger("domain:show", fullName);
        },

        appendRoute: function (token) {
            var fragment = Backbone.history.getFragment();
            Domain.router.navigate(fragment + '/' + token, {trigger: true});
        },

        back: function () {
            window.history.back();
        }
    });

    Dex.addInitializer(function () {
        Domain.router = new Router({});
    });


    Handlebars.registerHelper('property_value_cell', function () {
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
        } else if (property.view === 'date') {
            valueHtml = moment(value).format('YYYY-MM-DD');
        } else {
            valueHtml = value;
        }
        return new Handlebars.SafeString(valueHtml);
    });
});


