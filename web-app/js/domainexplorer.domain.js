App.Domain = (function (App, Backbone) {
    var Domain = {};

    Domain.DomainModel = Backbone.Model.extend({
        url: function () {
            return '/domexample/domain/item?fullName=' + this.get('fullName');
        }
    });

    Domain.DomainItemView = Backbone.Marionette.ItemView.extend({
        template: '#domain-template',

        events: {
        }

    });

    Domain.showDomain = function(fullName) {
        var model = new Domain.DomainModel({
            fullName: fullName
        });

        model.fetch().done(function(){
            var view = new Domain.DomainItemView({
                model: model
            });
            // TODO update hash
            App.layout.main.show(view);
        });
    };


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


