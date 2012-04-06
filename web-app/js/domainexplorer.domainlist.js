App.DomainList = (function (App, Backbone) {
    var DomainList = {};

    DomainList.DomainCount = Backbone.Model.extend({
    });

    DomainList.DomainCountCollection = Backbone.Collection.extend({
        url: '/domexample/domain/list',
        model: DomainList.DomainCount
    });

    DomainList.DomainCountItemView = Backbone.Marionette.ItemView.extend({
        template: '#domain-count-item-template',
        tagName: 'li',

        events: {
            'click': '_handleClick'
        },

        _handleClick: function(event) {
            event.preventDefault();
            App.vent.trigger("domain:show", this.model.get('fullName'));
        }
    });

    DomainList.DomainCountCollectionView = Backbone.Marionette.CollectionView.extend({

        itemView: DomainList.DomainCountItemView,
        tagName: 'ul'
    });

    DomainList.showDomainCountList = function() {
        App.layout.list.show(DomainList.domainCountCollectionView);
    };

    DomainList.showDomain = function(fullName) {
        console.log('TODO highlight '  + fullName);
    };

    App.addInitializer(function (options) {
        DomainList.domainCountList = new DomainList.DomainCountCollection();
        DomainList.domainCountList.fetch();
        DomainList.domainCountCollectionView = new DomainList.DomainCountCollectionView({
            collection: DomainList.domainCountList
        });
//        DomainList.domainCountCollectionView.render();
    });


    App.vent.bind("domain:show", DomainList.showDomain);

    App.bind("initialize:after", function(options){
        DomainList.showDomainCountList();
    });

    return DomainList;
})(App, Backbone);


(function (App, Backbone, $) {
    var Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
//            "": "showDomainCountList",
//            "domain/:fullName": "showDomain"
        }
    });

    App.addInitializer(function(){
        App.router = new Router({
            controller: App.DomainList
        });
    });
})(App, Backbone, $);


