App.Domain.Instance = (function (App, Backbone) {
    var Instance = {};

    Instance.ShowSectionView = Backbone.Marionette.Layout.extend({
        template: '#domain-instance-show-section-template',
        className: 'showView',

        regions: {
            content: '.content'
        },

        resize: function() {
            console.log('h');
            this.$el.find('.content').sizeToFit();
        },

        onRender: function() {
            this.$el.find('.header .name').html(this.model.domainType.get('name') + ': ');
            var view = new Instance.ShowView({
                model: this.model
            });
            this.content.show(view);
        }

    });

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        className: 'form-horizontal',
        renderHtml: function() {
            var properties = this.model.domainType.get('properties');
            var html =  _.collect(properties, function(property) {
                return '<div class="control-group"><label class="control-label">'+property.name + ':</label><div class="controls">' + this.model.get(property.name)+'</div></div>';
            }, this).join('');
            return html;
        }
    });

    Instance.showDomainInstance = function(model) {
        console.log('showDomainInstance: %o', model);
        App.layout.main.show(new Instance.ShowSectionView({model: model}));
    };

    App.vent.on("domainInstance:show", Instance.showDomainInstance);

    return Instance;
})(App, Backbone);


