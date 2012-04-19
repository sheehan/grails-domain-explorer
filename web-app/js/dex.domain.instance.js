Dex.Domain.Instance = (function (Dex, Backbone) {
    var Instance = {};

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        className: 'form-horizontal view-instance',

        initialize: function(options) {
            this.domainType = options.domainType;
        },

        renderHtml: function () {
            var properties = this.domainType.get('properties');
            var html = _.collect(properties,
            function (property) {
                var valueHtml = '',
                value = this.model.get(property.name);
                if (property.oneToMany) {
                    if (value == 0) {
                        valueHtml = '<span class="instanceValue oneToMany">0</span>';
                    } else {
                        valueHtml = '<span class="instanceValue oneToMany"><a href="#" data-append-path="'+property.name+'">' + value + '</a></span>';
                    }
                } else if(value === null) {
                    valueHtml = '<span class="instanceValue null">' + value + '</span>';
                } else {
                    valueHtml = value;
                }
                return '<div class="control-group"><label class="control-label">' + property.name + ':</label><div class="controls">' + valueHtml + '</div></div>';
            }, this).join('');
            return html;
        },

        onRender: function() {
            this.$('a').click(function(event) {
                event.preventDefault();
                var fragment = Backbone.history.getFragment();
                var path = $(this).data('appendPath');
                Backbone.history.navigate(fragment + '/' + path, {trigger: true});
            });
        }
    });

    Instance.showDomainInstance = function (model) {
        console.log('showDomainInstance: %o', model);
        Dex.layout.main.show(new Instance.ShowSectionView({model: model}));
    };

    Dex.vent.on("domainInstance:show", Instance.showDomainInstance);

    return Instance;
})(Dex, Backbone);


