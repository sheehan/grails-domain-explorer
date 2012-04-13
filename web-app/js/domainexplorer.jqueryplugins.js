jQuery.widget('domapp.sizeToFit', {
    _create: function() {
        _.bindAll(this, '_resizeListener');
        $(window).resize(this._resizeListener);
    },

    resize: function() {
        var $target = this.el;
        var $parent = this.$el.parent();
        var parentHeight = $parent.height();
        var childrenHeight = 0;
        $parent.children().each(function() {
            childrenHeight += $(this).outerHeight();
        });
        $target.height($target.height() - childrenHeight + parentHeight).css({'overflow': 'auto'});
    },

    _resizeListener: _.debounce(function() {
        this.resize();
    }, 500),

    destroy: function() {
        $(window).off('resize', this._resizeListener);
        $.Widget.prototype.destroy.call(this);
    }
});