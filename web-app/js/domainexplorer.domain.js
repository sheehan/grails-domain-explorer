App.Domain = (function (App, Backbone) {
    var Domain = {};

    Domain.DomainModel = Backbone.Model.extend({
        url: function () {
            return '/refine/domain/domainType?fullName=' + this.get('fullName');
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
            content: '.content'
        },

        resize: function() {
            this.$el.find('.content').sizeToFit();
        },

        showOverview: function() {
            this.$('.overview').button('toggle');
            var view = new Domain.OverviewView({
                model: this.model
            });
            this.content.show(view);
        },

        showList: function() {
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

        _handleRowClick: function() {
            App.vent.trigger("domainInstance:show", this.model);
        },

        renderHtml: function(data) {
            var properties = this.domainType.get('properties');
            return _.collect(properties, function(property) {
                return '<td>'+this.model.get(property.name)+'</td>';
            }, this).join('');
        }

    });

    Domain.ListView = Backbone.Marionette.CompositeView.extend({
        itemView: Domain.DomainListItemView,
        tagName: 'table',
        className: 'table table-striped',

        initialize: function(options) {
            this.bind('item:added', function(view) {
                view.domainType = this.model
            });
            this.collection = new Domain.DomainListItemCollection();
            this.collection.fetchByDomainType(this.model);
        },

        renderModel: function() {
            var properties = this.model.get('properties');
            var html = _.collect(properties, function(property) {
                return '<th>'+property.name+'</th>';
            }, this).join('');
            return '<thead><tr>' + html + '</tr></thead><tbody></tbody>';
        },

        appendHtml: function(collectionView, itemView){
            collectionView.$('tbody').append(itemView.el);
        }
    });

    Domain.DomainListItemModel = Backbone.Model.extend({});

    Domain.DomainListItemCollection = Backbone.Collection.extend({
        url: function () {
            return '/refine/domain/listEntities?fullName=' + this.domainTypeModel.get('fullName');
        },

        initialize: function(options) {
            var that = this;
            this.on('reset', function(collection) {
                that.each(function(model) {
                    model.domainType = that.domainTypeModel;
                });
            });
        },

        model: Domain.DomainListItemModel,

        fetchByDomainType: function(domainTypeModel) {
            this.domainTypeModel = domainTypeModel;
            return this.fetch();
        }
    });

    Domain.showDomain = function(fullName) {
        var model = new Domain.DomainModel({
            fullName: fullName
        });

        model.fetch().done(function(){
            var view = new Domain.DomainView({
                model: model
            });
            App.layout.main.show(view);

            view.showList();
        });

        Backbone.history.navigate(fullName);
    };

    Domain.showDomainRoute = function(fullName) {
        App.vent.trigger("domain:show", fullName);
    };

    App.vent.on("domain:show", Domain.showDomain);

    var Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
            ":fullName": "showDomainRoute"
        }
    });

    App.addInitializer(function(){
        Domain.router = new Router({
            controller: Domain
        });
    });

    return Domain;
})(App, Backbone);


