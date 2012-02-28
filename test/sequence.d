module teg.test.choice;

import teg.test.common;

int main() {
    auto s = new Stream!Whitespace;

    alias Lexeme!(
        Choice!(Char!"_",
                CharRange!"azAZ"),
        Many!(Choice!(CharRange!"azAZ09", Char!"_")))     Identifier;

    // nested sequence after position 0 is currently super mess up!
    alias Sequence!(
        Identifier,
        Sequence!(Identifier, Identifier),
    ) SeqParser1;

    s.set("public mewmew friend");
    parseTest!(SeqParser1)("sequence 1", s);

    return nFailures;
}

