module teg.test.choice;

import teg.test.common;

alias Lexeme!(
    Choice!(Char!"_", CharRange!"azAZ"),
    Many!(Choice!(CharRange!"azAZ09", Char!"_"))) Identity;

alias CharFrom!"@*" Suffix;

alias Lexeme!(Identity, Suffix) Suffixed;

int main() {
    auto s = new Stream!Whitespace;

    // collapsing lexemes together
    // oh dear, currently a space is allowed after the c :(
    s.set("first@  s ond@");
    parseTest!(ManyPlus!Suffixed)("lexeme 1", s);

    // test Lexeme char + char = range
    s.set("az");
    parseTest!(Lexeme!(CharRange!"az", CharRange!"az"))("lexeme 2", s);

    return nFailures;
}

