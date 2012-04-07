App.Domain = (function (App, Backbone) {
    var Domain = {};

    Domain.DomainModel = Backbone.Model.extend({
        url: function () {
            return '/domexample/domain/item?fullName=' + this.get('fullName');
        }
    });

    Domain.DomainView = Backbone.Marionette.Layout.extend({
        template: '#domain-template',

        className: 'domainView',

        events: {
            'click .overview': 'showOverview',
            'click .list': 'showList',
            'click .create': 'showCreate'
        },

        regions: {
            content: '.content'
        },

        onRender: function() {
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
        },

        showCreate: function() {
            this.$('.create').button('toggle');
            var view = new Domain.CreateView({
                model: this.model
            });
            this.content.show(view);
        }
    });

    Domain.OverviewView = Backbone.Marionette.ItemView.extend({
        template: '#domain-overview-template'
    });

    Domain.ListView = Backbone.Marionette.Layout.extend({
        template: '#domain-list-template',

        regions: {
            body: '.body'
        },

        onRender: function() {
            var collection = new Domain.DomainListItemCollection([], {
                fullName: this.model.get('fullName')
            });

            collection.fetch().done(_.bind(function(){
                var view = new Domain.DomainListCollectionView({
                    collection: collection
                });
                this.body.show(view);
            }, this));
        }
    });

    Domain.CreateView = Backbone.Marionette.ItemView.extend({
        template: '#domain-create-template'
    });

    Domain.DomainListItemModel = Backbone.Model.extend({

    });

    Domain.DomainListItemCollection = Backbone.Collection.extend({
        url: function () {
            return '/domexample/domain/listEntities?fullName=' + this.fullName;
        },
        model: Domain.DomainListItemModel,
        initialize: function(models, options) {
            this.fullName = options.fullName;
        }
    });

    Domain.DomainListItemView = Backbone.Marionette.ItemView.extend({
        template: '#domain-list-item-template',
        tagName: 'li',

        events: {
        }

    });

    Domain.DomainListCollectionView = Backbone.Marionette.CollectionView.extend({
        itemView: Domain.DomainListItemView,
        tagName: 'ul'
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

            view.showOverview();
        });

        Backbone.history.navigate('domain/' + fullName);
    };

    App.vent.on("domain:show", Domain.showDomain);

    var Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
            "domain/:fullName": "showDomain"
        }
    });

    App.addInitializer(function(){
        Domain.router = new Router({
            controller: Domain
        });
    });

    return Domain;
})(App, Backbone);


