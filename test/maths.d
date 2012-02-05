module teg.test.maths;

import teg.test.common;

alias ManyPlus!(CharRange!"09") Integer;

// BasicExpression breaks the self-referential node chain.
// Such types must be classes and must appear before referencing classes due
// to how the D compiler works.
class BasicExpression { mixin makeNode!BasicAddition; }
struct BasicAddition {
    mixin makeNode!(JoinedPlus!(Char!"+", BasicMultiplication));
}
struct BasicMultiplication {
    mixin makeNode!(JoinedPlus!(Char!"*", BasicTerm));
}
alias Choice!(
    Integer, Sequence!(Char!"(", Node!BasicExpression, Char!")")) BasicTerm;

class Expression { mixin makeNode!Addition; }
// Tree* parsers must be class rather than struct
class Addition { mixin makeNode!(TreeJoined!(Char!"+", Multiplication)); }
class Multiplication { mixin makeNode!(TreeJoined!(Char!"*", Signed)); }

// todo:
// alias Term Signed;
class Signed {
    mixin makeNode!(
        TreeOptional!(ManyPlusList!(CharFrom!"+-")),
        Term);
}

alias Choice!(
    Integer, Sequence!(Char!"(", Node!Expression, Char!")")) Term;

int main() {
    alias ManyPlus!(CharFrom!"\n\t ") Whitespace;

    string testData = `
        3 + 1 * (2 + 3 * 2) * (1)
        8 * 2 + 3 * 5
    `;

    auto s = new Stream!Whitespace(testData);

    parseTest!(ManyPlus!BasicExpression)("basic maths", s);

    auto s2 = new Stream!Whitespace(testData ~ `
        9 + -9
        4 * - +8
    `);
    parseTest!(ManyPlus!Expression)("maths", s2);

    return nFailures;
}
