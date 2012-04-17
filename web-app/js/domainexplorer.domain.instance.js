App.Domain.Instance = (function (App, Backbone) {
    var Instance = {};

    Instance.ShowSectionView = Backbone.Marionette.Layout.extend({
        template: '#domain-instance-show-section-template',
        className: 'showView',

        regions: {
            content: '.content'
        },

        resize: function () {
            this.$el.find('.content').sizeToFit();
        },

        onRender: function () {
            this.$el.find('.header .name').html(this.model.domainType.get('name') + ': ');
            var view = new Instance.ShowView({
                model: this.model
            });
            this.content.show(view);
        }

    });

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        className: 'form-horizontal',
        renderHtml: function () {
            var properties = this.model.domainType.get('properties');
            var html = _.collect(properties,
            function (property) {
                var valueHtml = '',
                value = this.model.get(property.name);
                if (property.oneToMany) {
                    if (value == 0) {
                        valueHtml = '<span class="instanceValue oneToMany">0</span>';
                    } else {
                        valueHtml = '<span class="instanceValue oneToMany"><a href="#">' + value + '</a></span>';
                    }
                } else if(value === null) {
                    valueHtml = '<span class="instanceValue null">' + value + '</span>';
                } else {
                    valueHtml = value;
                }
                return '<div class="control-group"><label class="control-label">' + property.name + ':</label><div class="controls">' + valueHtml + '</div></div>';
            }, this).join('');
            return html;
        }
    });

    Instance.showDomainInstance = function (model) {
        console.log('showDomainInstance: %o', model);
        App.layout.main.show(new Instance.ShowSectionView({model: model}));
    };

    App.vent.on("domainInstance:show", Instance.showDomainInstance);

    return Instance;
})(App, Backbone);


