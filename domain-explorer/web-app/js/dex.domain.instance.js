Dex.Domain.Instance = (function (Dex, Backbone) {
    var Instance = {};

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        template: '#domain-instance-view-template',
        className: 'form-horizontal view-instance',

        initialize: function (options) {
            this.domainType = options.domainType;
            this.model.bind('destroy', function () {
                var deleteSuccessView = new Instance.DeleteSuccessView();
                Dex.modal.show(deleteSuccessView);
            });
        },

        onRender: function () {
            this.$('a').click(function (event) {
                event.preventDefault();
                var fragment = Backbone.history.getFragment();
                var path = $(this).data('appendPath');
                Backbone.history.navigate(fragment + '/' + path, {trigger: true});
            });
        },

        serializeData: function () {
            return _.map(this.domainType.toJSON().properties, function (property) {
                return {
                    property: property,
                    value: this.model.get(property.name)
                }
            }, this);
        }
    });

    Instance.DeleteSuccessView = Backbone.Marionette.ItemView.extend({
        template: '#delete-success-template',
        events: {
            'click .ok': '_handleOkClick'
        },
        _handleOkClick: function (event) {
            event.preventDefault();
            this.close();
            window.history.back(); // TODO this wont work if coming from bookmark. need to find another way
            // TODO fire event that will get picked up by domainlist to refresh count
        }
    });

    Handlebars.registerHelper('property_value', function () {
        var property = this.property,
            value = this.value,
            valueHtml;
        if (property.oneToMany || property.manyToMany) {
            valueHtml = '<span class="instanceValue oneToMany"><a href="#" data-append-path="' + property.name + '">[' + value + ']</a></span>';
        } else if (value === null) {
            valueHtml = '<span class="instanceValue null">' + value + '</span>';
        } else if (property.oneToOne || property.manyToOne) {
            var className = _.last(property.type.split('.'));
            valueHtml = '<a href="#" data-append-path="' + property.name + '"><span class="nowrap">' + className + ': ' + value + '</span></a>';
        } else {
            valueHtml = value;
        }
        return new Handlebars.SafeString(valueHtml);
    });

    return Instance;
})(Dex, Backbone);


