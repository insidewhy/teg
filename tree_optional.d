module teg.tree_optional;

import teg.detail.parser;
import teg.detail.tree;
import teg.stores;

import beard.meta.find : filter;
import beard.meta.map : map;

// Like optional but split storage of including parser in a variant.
class TreeOptional(T...) {
    mixin hasSubparser!T;
    alias void __IsTreeOptional;
}

template isTreeOptional(T) {
    enum isTreeOptional = is(T.__IsTreeOptional);
}

////////////////////////////////////////////////////////////////////////////
private template removeTreeOptional(T) {
    static if (isTreeOptional!T)
        alias T.subparser removeTreeOptional;
    else
        alias T removeTreeOptional;
}

// Parse a sequence of T where at least one T is a TreeOptional
class TreeOptionalSequence(alias SeqT, NodeT, T...) {
    mixin storingParser;

    alias SeqT!(filter!(isTreeOptional, T))  ShortParser;
    alias SeqT!(map!(removeTreeOptional, T)) LongParser;

    mixin TreeParser!NodeT;

    static bool skip(S, O)(S s, ref O o) {
        LongStores longMatch;
        create(longMatch);
        if (LongParser.parse(s, getLongStorage(longMatch))) {
            o = longMatch;
            return true;
        }
        else if (ShortParser.parse(s, getShortStorage(o))) {
            return true;
        }
        else {
            o.reset();
            return false;
        }
    }
}
