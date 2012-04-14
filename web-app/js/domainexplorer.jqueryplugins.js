jQuery.widget('domapp.sizeToFit', {
    _create: function() {
        _.bindAll(this, '_resizeListener');
        this.resize();
        $(window).resize(this._resizeListener);
        console.log('hi');
    },

    resize: function() {
        var $target = this.element;
        var $parent = this.element.parent();
        var parentHeight = $parent.height();
        var childrenHeight = 0;
        $parent.children().each(function() {
            childrenHeight += $(this).outerHeight();
        });
        console.log($target.height());
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