module teg.try_;

import teg.detail.parser;

class Try(T...) {
    mixin parser!T;

    static bool skip(S)(S s) {
        static if (__traits(hasMember, subparser, "match")) {
            return subparser.match(s);
        }
        else {
            auto save = s.save();
            auto result = subparser.skip(s);
            if (result) s.restore(save);
            return result;
        }
    }
    static bool skip(S, O)(S s, ref O o) { return skip(s); }
}
