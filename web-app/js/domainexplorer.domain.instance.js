App.Domain.Instance = (function (App, Backbone) {
    var Domain = App.Domain;
    var Instance = {};

    Instance.ShowSectionView = Backbone.Marionette.Layout.extend({
        template: '#domain-instance-show-section-template',

        regions: {
            content: '.content'
        },

        resize: function() {
            this.$el.find('.content').sizeToFit();
        },

        onRender: function() {
            var view = new Instance.ShowView({
                model: this.model
            });
            this.content.show(view);
        }

    });

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        renderHtml: function() {
            var properties = this.model.domainType.get('properties');
            var html =  _.collect(properties, function(property) {
                return '<li>'+property.name + ': ' + this.model.get(property.name)+'</li>';
            }, this).join('');
            return '<ul>' + html + '</ul>';
        }
    });

    Instance.showDomainInstance = function(model) {
        console.log('showDomainInstance: %o', model);
        App.layout.main.show(new Instance.ShowSectionView({model: model}));
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


