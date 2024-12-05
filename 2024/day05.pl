:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).
:- use_module(library(yall)).
:- initialization(main, main).

main :-
    load_file('input5', Tests),
    part1(Tests, Result1), write("Part 1: "), writeln(Result1),
    part2(Tests, Result2), write("Part 2: "), writeln(Result2).

part1(Tests, Result) :-
    convlist([X, R]>>(psort(X, X), middle(X, R)), Tests, Rs),
    sum_list(Rs, Result).

part2(Tests, Result) :-
    convlist([X, R]>>(psort(X, X2), X \== X2, middle(X2, R)), Tests, Rs),
    sum_list(Rs, Result).

load_file(File, Tests) :-
    phrase_from_file(format(Rules, Tests), File),
    forall(member(X | Y, Rules), assert(before(X, Y))).

format(Rules, Tests) --> sequence(rule, Rules), "\n", sequence(test, Tests).
rule(X | Y) --> integer(X), "|", integer(Y), "\n".
test(Pages) --> sequence("", integer, ",", "\n", Pages).

psort(Pages, Out) :- predsort(cmp_page, Pages, Out).
cmp_page('<', L, R) :- before(L, R).
cmp_page('>', L, R) :- before(R, L).

middle(L, X) :- same_length(L1, L2), append(L1, [X|L2], L).
