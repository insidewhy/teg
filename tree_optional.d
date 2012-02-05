module teg.tree_optional;

import teg.detail.parser;

// Like optional but split storage of including parser in a variant.
class TreeOptional(T...) {
    mixin hasSubparser!T;
    alias void __IsTreeOptional;
}

template isTreeOptional(T) {
    enum isTreeOptional = is(T.__IsTreeOptional);
}
