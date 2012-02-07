module teg.lexeme;

import teg.sequence;
import beard.meta.fold_left;

import teg.store;
import teg.store : StoreRange;
import teg.stores : storesCharOrRange, storesChar, storesRange;
import std.typetuple;

private template collapseTextInRange(R, T...) {
    alias TypeTuple!(T, R) types;

    template add(U) {
        static if (storesCharOrRange!U)
            alias collapseTextInRange!(R.add!U, T) add;
        else
            alias collapseText!(T, R, U) add;
    }
}

private template collapseText(T...) {
    alias T types;

    template add(U) {
        static if (storesRange!U)
            alias collapseTextInRange!(StoreRange!U, T) add;
        else static if (storesChar!U)
            alias collapseTextInRange!(StoreChar!U, T) add;
        else
            alias collapseText!(T, U) add;
    }
}

class Lexeme(T...) if (T.length > 1)
    : Sequence!(false, foldLeft2!(collapseText!(), T).types) {}

class Lexeme(T) : T {}
