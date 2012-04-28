Dex.Domain.Instance = (function (Dex, Backbone) {
    var Instance = {};

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        className: 'form-horizontal view-instance',

        initialize: function (options) {
            this.domainType = options.domainType;
            this.model.bind('destroy', function () {
                // TODO modal
                var deleteSuccessView = new Instance.DeleteSuccessView();
                Dex.modal.show(deleteSuccessView);
            });
        },

        renderHtml: function () {
            var properties = this.domainType.get('properties');
            var html = _.collect(properties,
            function (property) {
                var valueHtml = '',
                value = this.model.get(property.name);
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
                return '<div class="control-group"><label class="control-label">' + property.name + ':</label><div class="controls">' + valueHtml + '</div></div>';
            }, this).join('');
            return html;
        },

        onRender: function () {
            this.$('a').click(function (event) {
                event.preventDefault();
                var fragment = Backbone.history.getFragment();
                var path = $(this).data('appendPath');
                Backbone.history.navigate(fragment + '/' + path, {trigger: true});
            });
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
            window.history.back();
        }
    });

    return Instance;
})(Dex, Backbone);


