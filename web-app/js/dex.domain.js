Dex.Domain = (function (Dex, Backbone) {
    var Domain = {};

    Domain.DomainModel = Backbone.Model.extend({
        url: function () {
            return Dex.createLink('domain', 'domainType', {fullName: this.get('fullName')})
        }
    });

    Domain.DomainView = Backbone.Marionette.Layout.extend({
        template: '#domain-template',

        className: 'domainView',

        events: {
            'click .overview': 'showOverview',
            'click .list': 'showList'
        },

        regions: {
            header: '.header',
            content: '.content'
        },

        resize: function () {
            this.$el.find('.content').sizeToFit();
        },

        showOverview: function () {
            this.$('.overview').button('toggle');
            var view = new Domain.OverviewView({
                model: this.model
            });
            this.content.show(view);
        },

        showList: function () {
            this.$('.list').button('toggle');
            var view = new Domain.ListView({
                model: this.model
            });
            this.content.show(view);
        }
    });

    Domain.OverviewView = Backbone.Marionette.ItemView.extend({
        template: '#domain-overview-template'
    });

    Domain.DomainListItemView = Backbone.Marionette.ItemView.extend({
        tagName: 'tr',

        events: {
            'click': '_handleRowClick'
        },

        _handleRowClick: function () {

            Backbone.history.navigate(this.domainType.get('fullName') + '/' + this.model.id);
            Dex.vent.trigger("domainInstance:show", this.model);
        },

        renderHtml: function (data) {
            var properties = this.domainType.get('properties');
            return _.collect(properties,
            function (property) {
                var valueHtml = '',
                    value = this.model.get(property.name);
//                if (property.oneToMany) {
//                    if (value == 0) {
//                        valueHtml = '[]';
//                    } else {
//                        valueHtml = '<span class="instanceValue oneToMany">' + this.domainType.get('name') + ' (' + value + ')</span>';
//                    }
                if(value === null) {
                    valueHtml = '<span class="instanceValue null">' + value + '</span>';
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
            this.bind('item:added', function (view) {
                view.domainType = this.model
            });
            this.collection = new Domain.DomainListItemCollection();
            this.collection.fetchByDomainType(this.model);
        },

        renderModel: function () {
            var properties = this.model.get('properties');
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

    Domain.DomainListItemModel = Backbone.Model.extend({});

    Domain.DomainListItemCollection = Backbone.Collection.extend({
        url: function() {
            return Dex.createLink('domain', 'listEntities', {fullName: this.domainTypeModel.get('fullName')});
        },

        initialize: function (options) {
            var that = this;
            this.on('reset', function (collection) {
                that.each(function (model) {
                    model.domainType = that.domainTypeModel;
                });
            });
        },

        model: Domain.DomainListItemModel,

        fetchByDomainType: function (domainTypeModel) {
            this.domainTypeModel = domainTypeModel;
            return this.fetch();
        }
    });

    Domain.showDomain = function (fullName) {
        var model = new Domain.DomainModel({
            fullName: fullName
        });

        model.fetch().done(function () {
            var view = new Domain.DomainView({
                model: model
            });
            Dex.layout.main.show(view);

            view.showList();
        });

        Backbone.history.navigate(fullName);
    };

    Domain.showDomainRoute = function (fullName) {
        Dex.vent.trigger("domain:show", fullName);
    };

    Dex.vent.on("domain:show", Domain.showDomain);

    var Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
            ":fullName": "showDomainRoute"
        }
    });

    Dex.addInitializer(function () {
        Domain.router = new Router({
            controller: Domain
        });
    });

    return Domain;
})(Dex, Backbone);


