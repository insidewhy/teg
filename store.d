module teg.store;

import teg.detail.parser;
import teg.range;
import teg.stores;

private template _StoreChar(T) {
    mixin whitespaceSkipper;
    mixin storingParser;

    static bool skip(S, O)(S s, ref O o) {
        static if (__traits(hasMember, subparser, "match")) {
            if (T.match(s)) {
                o = s.front();
                s.advance();
                return true;
            }
            else return false;
        }
        else return T.skip(s, o);
    }

    static bool skip(S)(S s) {
        if (T.match(s)) {
            s.advance();
            return true;
        }
        return false;
    }

    alias char value_type;
}

private template _StoreRange(T...) {
    mixin whitespaceSkipper;
    mixin storingParser;

    static bool skip(S, O)(S s, ref O o) {
        o.parsing(s);
        foreach(P; T) if (! P.skip(s)) {
            o.clear();
            return false;
        }
        o.parsed();
        return true;
    }

    static bool skip(S)(S s) {
        foreach(P; T) if (! P.skip(s)) {
            return false;
        }
        return true;
    }

    alias Range value_type;
}

// D only allows pulling attributes into the scope of a class from a pure
// template otherwise the forwarders wouldn't be neccesary.
class StoreRange(T...) {
    mixin _StoreRange!T;

    template add(U) { alias StoreRange!(T, U) add; }
}

class StoreChar(T...) {
    mixin hasSubparser!T;
    mixin _StoreChar!subparser;

    template add(U) { alias StoreRange!(T, U) add; }
}

// force parsers to store that don't usually store char/range to store when
// possible.
class Store(T...) {
    mixin hasSubparser!T;

    // template for adding another parser to those being stored
    template add(U) { alias Store!(T, U) add; }
    static bool skip(S)(S s) { return subparser.skip(s); }

    static if (storesChar!subparser)
        mixin _StoreChar!subparser;
    else
        mixin _StoreRange!T;
}

