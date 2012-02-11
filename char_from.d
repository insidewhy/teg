module teg.char_from;

import std.string : indexOf;
// d compiler bug enforces this despite public import in storeOneChar
import teg.detail.parser : storingParser;
import teg.detail.store_one_char : storeOneChar;

class CharFrom(string T) {
    mixin storeOneChar;

    static bool match(S)(S s) {
        return indexOf(T, s.front()) != -1;
    }
}

class CharNotFrom(string T) {
    mixin storeOneChar;

    static bool match(S)(S s) {
        return indexOf(T, s.front()) == -1;
    }
}
