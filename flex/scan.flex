

package src;
import java_cup.runtime.*;

%%

%class Lexer
%line
%column
%cup

%{
       
        private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

        private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

LineTerminator = \r|\n|\r\n

WhiteSpace     = {LineTerminator} | [ \t\f]

number = [1-9][0-9]*

addop = p(ppp)*
mulop = pp(ppp)*
expop = ppp(ppp)*
left =  q(qq)*
right = qq(qq)*
%%
/* ------------------------Lexical Rules Section---------------------- */


    {addop}       { System.out.print("+ ");return symbol(sym.PLUS); }
    {expop}        { System.out.print("e ");return symbol(sym.EXPO); }
    {mulop}        { System.out.print("* ");return symbol(sym.TIMES);}
    {left}        { System.out.print("( ");return symbol(sym.LPAREN);}
    {right}        { System.out.print(") ");return symbol(sym.RPAREN);}

    {number}      { System.out.print(yytext() + " ");return symbol(sym.NUMBER, new Double(yytext())); }


    {WhiteSpace}       { /* just skip what was found, do nothing */ }


    [^]                    { throw new Error("Illegal character <"+yytext()+">"); }
