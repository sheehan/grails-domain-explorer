Dex.Domain.Instance = (function (Dex, Backbone) {
    var Instance = {};


    Instance.ToolbarView = Backbone.Marionette.ItemView.extend({
        template: '#domain-instance-toolbar',
        className: 'btn-toolbar',

        triggers: {
            'click .edit': 'edit',
            'click .delete': 'delete'
        }
    });

    Instance.EditToolbarView = Backbone.Marionette.ItemView.extend({
        template: '#domain-edit-instance-toolbar',
        className: 'btn-toolbar',

        triggers: {
            'click .save': 'save',
            'click .cancel': 'cancel'
        }
    });

    Instance.ShowView = Backbone.Marionette.ItemView.extend({
        template: '#domain-instance-view-template',
        className: 'form-horizontal view-instance',

        events: {
            'click a': '_handleLinkClick'
        },

        initialize: function (options) {
            this.domainType = options.domainType;
            this.model.bind('destroy', function () {
                var deleteSuccessView = new Instance.DeleteSuccessView();
                Dex.modal.show(deleteSuccessView);
            });
        },

        _handleLinkClick: function (event) {
            event.preventDefault();
            var fragment = Backbone.history.getFragment();
            var path = $(event.currentTarget).data('appendPath');
            Backbone.history.navigate(fragment + '/' + path, {trigger: true});
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

    Instance.EditView = Backbone.Marionette.ItemView.extend({
        template: '#domain-instance-edit-template',
        className: 'form-horizontal edit-instance',

        initialize: function (options) {
            this.domainType = options.domainType;
        },

        serializeData: function () {
            var props = this.domainType.get('properties');
            props = _.reject(props, function(property) {
                return property.view == 'associationMany'; // || _.include(['id', 'version', 'dateCreated', 'lastUpdated'], property.name) ;
            });
            return _.map(props, function (property) {
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

    Handlebars.registerHelper('property_edit', function () {
        var property = this.property,
            value = this.value,
            valueHtml = '';
        if (_.include(['id', 'version', 'dateCreated', 'lastUpdated'], property.name)) {
            valueHtml = value;
        } else {
            switch (property.view) {
                case 'string':
                case 'number':
                    (function () {
                        var stringVal = value == null ? '' : value;
                        valueHtml = '<input type="text" name="'+property.name+'" value="' + stringVal + '" />';
                    })();
                    break;
                case 'boolean':
                    (function () {
                        var stringVal = value == null ? '' : value;
                        valueHtml = '<input type="checkbox" ' + (value === 'true' ? 'checked' : '') + ' />';
                    })();
                    break;
                case 'associationOne':
                    (function () {
                        var stringVal = value == null ? '' : value;
                        // retain the id for now
                        valueHtml = '<input type="text" name="'+property.name+'.id" value="' + (value ? value : '') + '" />';
                        valueHtml += ' (id for now)';
                    })();
                    break;
                default :
                    valueHtml = 'property type not supported yet: ' + property.view;
            }
        }
        return new Handlebars.SafeString(valueHtml);
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


