module teg.not;

import teg.try_;

class Not(T...) : Try!T {
    alias Try!T  base;
    static bool skip(S)(S s) { return ! base.skip(s); }
    static bool skip(S, O)(S s, ref O o) { return skip(s); }
}
