module teg.tree_joined;

import teg.joined;
import teg.detail.tree;

class TreeJoined(NodeT, bool SkipWs, J, T...) {
    mixin parser!T;

    private alias subparser                   ShortParser;
    private alias Joined!(SkipWs, true, J, T) LongParser;

    mixin TreeParser!NodeT;

    static bool skip(S, O)(S s, ref O o) {
        static if (! isVariant!ShortStores)
            o = ShortStores.init;

        if (! subparser.parse(s, getShortStorage(o))) {
            o.reset();
            return false;
        }

        skip_whitespace(s);
        if (s.empty()) return true;
        auto save = s.save();

        static if (LongParser.JoinStores) {
            stores!J joinValue;
            if (! J.parse(s, joinValue)) return true;
        }
        else
            if (! J.skip(s))  return true;

        skip_whitespace(s);

        ShortStores second;
        if (s.empty() || ! subparser.parse(s, second)) {
            s.restore(save);
            return true;
        }

        LongStores v;
        create(v);
        LongParser.getSplit(getLongStorage(v))
            .push_back(getShortStorage(o)).push_back(second);

        static if (LongParser.JoinStores)
            getLongStorage(v).join.push_back(joinValue);
        o = v;

        LongParser.skipTail(s, getLongStorage(v));
        return true;
    }
}

class TreeJoined(J, T...) : TreeJoined!(void, true, J, T) {}
class TreeJoinedTight(J, T...) : TreeJoined!(void, false, J, T) {}
