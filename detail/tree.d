module teg.detail.tree;

// must use public imports as necessary due to mixin
public import teg.detail.parser;
public import teg.stores;
public import beard.variant;
public import beard.vector;

// T... is the storing part of the parser
// must define ShortParser and LongParser in mixin class.
template TreeParser(NodeT) {
  private:
    alias stores!ShortParser           ShortStores;

    // getLongStorage returns the storage of the node if there is one.
    static if (is(NodeT : void)) {
        alias LongParser.value_type    LongStores;
        static ref getLongStorage(O)(ref O o) { return o; }
    }
    else {
        alias NodeT                    LongStores;
        alias LongParser.value_type    NodeStores;

        static ref getLongStorage(O)(ref O o) { return o.value_; }
    }

  public:
    static if (isVariant!ShortStores) {
        static auto ref getShortStorage(O)(ref O o) { return o; }
        alias Variant!(LongStores, ShortStores.types) value_type;
    }
    else {
        static auto ref getShortStorage(O)(ref O o) { return o.as!ShortStores; }
        alias Variant!(LongStores, ShortStores) value_type;
    }

    static bool skip(S)(S s) {
        return LongParser.skip(s) || ShortParser.skip(s);
    }
}
