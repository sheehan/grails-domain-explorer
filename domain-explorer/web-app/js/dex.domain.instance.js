Dex.module('Domain.Instance', function (Instance, Dex, Backbone, Marionette, $, _) {
    var Views = Instance.Views = {};

    var ErrorModel = Backbone.Model.extend();
    var ErrorCollection = Backbone.Collection.extend({
        model: ErrorModel
    });

    Views.Errors = Dex.ItemView.extend({
        template: 'instance/errors',
        className: 'alert alert-error',
        initialize: function (options) {
            this.errors = options.errors;
        },
        serializeData: function () {
            return this.errors;
        }
    });

    Views.Toolbar = Dex.ItemView.extend({
        template: 'instance/toolbar',
        className: 'btn-toolbar',

        triggers: {
            'click .edit': 'edit',
            'click .delete': 'delete'
        }
    });

    Views.EditToolbar = Dex.ItemView.extend({
        template: 'instance/editToolbar',
        className: 'btn-toolbar',

        triggers: {
            'click .save': 'save',
            'click .cancel': 'cancel'
        }
    });

    Views.Show = Dex.ItemView.extend({
        template: 'instance/view',
        className: 'view-instance',

        events: {
            'click a': '_handleLinkClick'
        },

        initialize: function (options) {
            this.model.bind('destroy', function () {
                var deleteSuccessView = new Views.DeleteSuccess();
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
            return _.map(this.model.clazz.toJSON().properties, function (property) {
                return {
                    property: property,
                    value: this.model.get(property.name)
                };
            }, this);
        }
    });

    Views.Edit = Backbone.Marionette.Layout.extend({
        template: 'instance/edit',
        className: 'edit-instance',

        regions: {
            errors: '.errors'
        },

        serializeData: function () {
            var props = this.model.clazz.get('properties');
            props = _.reject(props, function (property) {
                return property.view == 'associationMany'; // || _.include(['id', 'version', 'dateCreated', 'lastUpdated'], property.name) ;
            });
            return _.map(props, function (property) {
                return {
                    property: property,
                    value: this.model.get(property.name)
                };
            }, this);
        },

        serialize: function () {
            var data = {};
            _.each(this.formViews, function (view) {
                _.extend(data, view.serialize());
            });
            return data;
        },

        onRender: function () {
            this.formViews = [];
            var props = this.model.clazz.get('properties');
            props = _.reject(props, function (property) {
                return property.view == 'associationMany';// || _.include(['id', 'version', 'dateCreated', 'lastUpdated'], property.name) ;
            });
            var $form = this.$('form');
            _.each(props, function (property) {
                if (property.view == 'embedded') {
                    var $fieldset = $(Handlebars.templates['instance/form/embedded']({property: property}));
                    $form.append($fieldset);
                    var embeddedModel = this.model.get(property.name);
                    _.each(property.clazz.properties, function(embeddedProp){
                        this._createFormView(embeddedProp, embeddedModel, $fieldset);
                    }, this);
                } else {
                    this._createFormView(property, this.model, $form);
                }
            }, this);
        },

        _createFormView: function (property, model, $appendTo) {
            var View = this.getView(property);
            if (View) {
                var view = new View({
                    property: property,
                    model: model
                });
                var $wrapper = $(Handlebars.templates['instance/form/controlGroup']({property: property}));
                view.render();
                $appendTo.append($wrapper);
                $wrapper.find('.controls').html(view.el);
                this.formViews.push(view);
            }
        },

        getView: function (property) {
            if (_.include(['id', 'version', 'dateCreated', 'lastUpdated'], property.name)) {
                return ReadOnlyView;
            }
            switch (property.view) {
                case 'string':
                case 'number':
                    return StringView;
                case 'date':
                    return DateView;
                case 'boolean':
                    return BooleanView;
                case 'embedded':
                    return EmbeddedView;
                case 'associationOne':
                    return AssociationOneView;
                default:
                    return NotSupportedView;
            }
        },

        setSaving: function (isSaving) {
            this.$el.toggleClass('saving', isSaving);
        },

        showErrors: function (errors) {
            this.errors.show(new Views.Errors({errors: errors}));
        }
    });

    Views.DeleteSuccess = Dex.ItemView.extend({
        template: 'domain/deleteSuccess',
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

    Views.ControlGroup = Dex.ItemView.extend({
        template: 'instance/form/controlGroup'
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
        } else if (property.view == 'date') {
            valueHtml = moment(value).format('DD MMM YYYY');
        } else {
            valueHtml = value;
        }
        return new Handlebars.SafeString(valueHtml);
    });

    var DateView = Dex.ItemView.extend({
        template: 'instance/form/date',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            var value = this.model.get(this.property.name);
            var mnt = moment(value);
            return {
                name: this.property.name,
                value: this.model.get(this.property.name),
                date: mnt.date(),
                month: mnt.month(),
                year: mnt.year()
            };
        },

        onRender: function () {
            var value = this.model.get(this.property.name);
            var mnt = moment(value);
            this.$('[name=year]').val(mnt.year());
            this.$('[name=month]').val(mnt.month());
            this.$('[name=day]').val(mnt.date());
        },

        serialize: function () {
            var year = this.$('[name=year]').val();
            var month = this.$('[name=month]').val();
            var day = this.$('[name=day]').val();
            var date = new Date(year, month, day);
            var data = {};
            data[this.property.name] = moment(date).format('YYYY-MM-DDTHH:mm:ss.SSSZZ');
            return data;
        }
    });

    var StringView = Dex.ItemView.extend({
        template: 'instance/form/string',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            return {
                name: this.property.name,
                value: this.model ? this.model.get(this.property.name) : null
            };
        },

        serialize: function () {
            var data = {};
            data[this.property.name] = this.$el.find('input').val();
            return data;
        }
    });

    var ReadOnlyView = Dex.ItemView.extend({
        template: 'instance/form/readOnly',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            return {
                name: this.property.name,
                value: this.model ? this.model.get(this.property.name) : null
            };
        },

        serialize: function () { return {}; }
    });

    var BooleanView = Dex.ItemView.extend({
        template: 'instance/form/boolean',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            return {
                name: this.property.name,
                value: this.model ? this.model.get(this.property.name) : null
            };
        },

        serialize: function () {
            var data = {};
            data[this.property.name] = this.$el.find('input').val();
            return data;
        }
    });

    var AssociationOneView = Dex.ItemView.extend({
        template: 'instance/form/associationOne',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            return {
                property: this.property,
                value: this.model ? this.model.get(this.property.name) : null
            };
        },

        serialize: function () {
            var data = {};
            data[this.property.name + '.id'] = this.$el.find('input').val();
            return data;
        }
    });

    var NotSupportedView = Dex.ItemView.extend({
        template: 'instance/form/notSupported',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            return {
                property: this.property,
                value: this.model ? this.model.get(this.property.name) : null
            };
        },

        serialize: function () { return {}; }
    });

    var EmbeddedView = Dex.ItemView.extend({
        template: 'instance/form/embedded',

        initialize: function (options) {
            this.property = options.property;
        },

        serializeData: function () {
            return {
                property: this.property,
                value: this.model.get(this.property.name).toJSON()
            };
        },

        serialize: function () { return {}; }
    });
});


