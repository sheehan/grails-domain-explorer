App.Domain = (function (App, Backbone) {
    var Domain = {};

    Domain.DomainModel = Backbone.Model.extend({
        url: function () {
            return '/domexample/domain/item?fullName=' + this.get('fullName');
        }
    });

    Domain.DomainView = Backbone.Marionette.ItemView.extend({
        template: '#domain-template',

        events: {
        }

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
            // TODO update hash
            App.layout.main.show(view);
        });
    };

    Domain.showDomainList = function(fullName) {
        var collection = new Domain.DomainListItemCollection([], {
            fullName: fullName
        });

        collection.fetch().done(function(){
            var view = new Domain.DomainListCollectionView({
                collection: collection
            });
            // TODO update hash
            App.layout.main.show(view);
        });
    };


//    App.vent.on("domain:show", Domain.showDomain);
    App.vent.on("domain:show", Domain.showDomain);

    App.addInitializer(function (options) {
    });

    return Domain;
})(App, Backbone);


(function (App, Backbone, $) {
//    var Router = Backbone.Marionette.AppRouter.extend({
//        appRoutes: {
//            "": "showDomain"
//        }
//    });
//
//    App.addInitializer(function(){
//        App.router = new Router({
//            controller: App.Domain
//        });
//    });
})(App, Backbone, $);


