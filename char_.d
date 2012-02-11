module teg.char_;

import teg.store;
// d compiler bug enforces this despite public import in storeOneChar
public import teg.detail.parser : storingParser;
import teg.detail.store_one_char : storeOneChar;

class Char(string T) {
    enum length = T.length;

    static if (length > 1)
        alias StoreRange!Char SkippedParser;
    else
        alias StoreChar!Char SkippedParser;

    static bool match(S)(S s) {
        if (s.length < T.length) return false;

        for (auto i = 0u; i < T.length; ++i)
            if (s[i] != T[i]) return false;

        return true;
    }

    static bool skip(S)(S s) {
        if (match(s)) {
            s.advance(T.length);
            return true;
        }
        else return false;
    }
}

// Allow anything to match but the end of the file or char C.
// Stores a char.
class NotChar(char C) {
    mixin storeOneChar;
    static bool match(S)(S s) { return s.front() != C; }
}

// Allow anything to match (but the end of the file) and store it as a char.
class AnyChar {
    mixin storeOneChar;
    static bool match(S)(S s) { return true; }
}
