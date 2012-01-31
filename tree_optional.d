module teg.tree_optional;

import teg.detail.parser;

// Like optional but split storage of including parser in a variant.
class TreeOptional(T...) {
    mixin parser!T;
}
