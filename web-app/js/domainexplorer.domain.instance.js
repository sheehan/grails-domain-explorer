App.Domain.Instance = (function (App, Backbone) {
    var Domain = App.Domain;
    var Instance = {};

    Instance.ShowView = Backbone.Marionette.ItemView.extend({

    });

    Instance.showDomainInstance = function(model) {
        console.log('showDomainInstance: %o', model);
    };

    App.vent.on("domainInstance:show", Instance.showDomainInstance);

//    var Router = Backbone.Marionette.AppRouter.extend({
//        appRoutes: {
//            ":fullName": "showDomainRoute"
//        }
//    });

    App.addInitializer(function(){
//        Domain.router = new Router({
//            controller: Domain
//        });
    });

    return Instance;
})(App, Backbone);


