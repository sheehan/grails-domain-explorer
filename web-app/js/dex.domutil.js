Dex.DomUtil = (function (Dex, $) {
    var DomUtil = {};

    DomUtil.sizeHeightToFillParent = function($target) {
        var $parent = $target.parent();
        if ($parent.length) {
            var parentHeight = $parent.height();
            var childrenHeight = _.reduce($parent.children(), function (memo, val) { return memo + $(val).outerHeight()}, 0);
            $target.height($target.height() - childrenHeight + parentHeight).css({'overflow': 'auto'});
        }
    }

    return DomUtil;
})(Dex, jQuery);