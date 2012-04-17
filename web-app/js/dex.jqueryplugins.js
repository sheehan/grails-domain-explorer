jQuery.widget('domapp.sizeToFit', {
    _create: function () {
        this.resize();
    },

    resize: function () {
        this.sizeElement(this.element);
    },

    sizeElement: function ($target) {
        var $parent = $target.parent();
        if ($parent.length) {
            var parentHeight = $parent.height();
            var childrenHeight = _.reduce($parent.children(), function (memo, val) { return memo + $(val).outerHeight()}, 0);
            $target.height($target.height() - childrenHeight + parentHeight).css({'overflow': 'auto'});
        }
    },

    destroy: function () {
        $.Widget.prototype.destroy.call(this);
    }
});