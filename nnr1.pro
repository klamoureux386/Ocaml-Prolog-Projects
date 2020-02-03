%Kyle Lamoureux - CPSC 3520 - SDE2 - 7/25/19


/* sample data */
simpleH([[5,5,1],[5,-5,2],[-5,-5,3],[-5,5,4]]).

/* some test vectors */
t1([3,3,0]).
t2([-1,-1,0]).
t3([0,0,0]).
t4([-1,1,0]).
t5([0,-1,0]).

/* larger dataset for testing */
wcdata([[3.26495e+02, 6.00000e+00, 2.82447e+02, 1.10000e+01, -3.61804e+01, -1.17557e+01, 1],[5.19186e+02, 1.00000e+00, 4.57228e+01, 4.70000e+01, -3.61804e+01, -1.17557e+01, 1],[7.03244e+01, 5.00000e+00, 2.15593e+01, 2.80000e+01, -2.23607e+01, 3.07768e+01, 1],[1.87247e+02, 1.00000e+00, 7.03097e+01, 1.80000e+01, -2.23607e+01, 3.07768e+01, 1],[4.26179e+02, 6.00000e+00, 1.33301e+02, 2.20000e+01, 3.61804e+01, 1.17557e+01, 7],[1.97036e+03, 5.00000e+00, 7.51209e+02, 1.90000e+01, 3.11803e+01, 1.90212e+01, 7],[1.28191e+03, 1.00000e+00, 6.08078e+02, 2.20000e+01, 1.78214e+01, 1.08487e+01, 7],[4.82068e+02, 4.00000e+00, 4.71010e+02, 2.00000e+01, -2.23607e+01, 3.07768e+01, 1],[9.24921e+02, 7.00000e+00, 3.40959e+02, 1.60000e+01, 3.61804e+01, 1.17557e+01, 1],[4.85993e+02, 7.00000e+00, 3.91866e+02, 2.10000e+01, -2.23607e+01, 3.07768e+01, 1],[1.85204e+02, 4.00000e+00, 5.22527e+01, 2.40000e+01, -2.23607e+01, 3.07768e+01, 5],[2.54153e+02, 2.40000e+01, 1.86337e+02, 1.00000e+00, 1.40018e+01, 2.98699e+01, 5],[3.08718e+02, 1.00000e+01, 1.56700e+02, 2.00000e+01, -2.23607e+01, -3.07768e+01, 5],[1.28083e+02, 8.00000e+00, 1.33937e+01, 5.40000e+01, 0.00000e+00, -1.00000e+01, 4],[1.44025e+02, 6.00000e+00, 2.34110e+01, 1.60000e+01, -2.23607e+01, 3.07768e+01, 4],[1.90704e+02, 6.00000e+00, 2.35136e+01, 1.80000e+01, 1.40018e+01, -2.98699e+01, 4],[1.74306e+02, 1.20000e+01, 5.55195e+01, 2.20000e+01, -1.40018e+01, -2.98699e+01, 5],[2.01648e+02, 1.00000e+00, 1.35576e+02, 4.90000e+01, 3.61804e+01, -1.17557e+01, 5],[5.38501e+01, 6.00000e+00, 4.88364e+01, 2.50000e+01, 0.00000e+00, -1.00000e+01, 5],[1.50294e+02, 7.00000e+00, 2.42179e+01, 2.40000e+01, 0.00000e+00, -1.00000e+01, 5]]).

tvc([98.641683, 17.0, 75.387416, 9.0, -36.18035, 11.7557, 0]).
tv2c([1869.2331, 5.0, 184.885, 27.0, 17.82145, 10.8487, 0]).


%predicate: printList(+H).

printList([]).
printList([H|T]) :-
write('['),
printSingleList(H),
write(']'), nl,
printList(T).


%helper predicate: printSingleList(+H).

printSingleList([]).
printSingleList([H|T]) :-
T = [] -> write(H), printSingleList(T);
write(H), write(","),
printSingleList(T).


%predicate: theClass(+Avect,-C).

theClass([H], H).
theClass([_|T], C) :- theClass(T, C).


%predicate: distanceAllVectors(+V, +Vset, -Dlist)

distanceAllVectors2([_|_],[], []).
distanceAllVectors2([HV|TV], [HVset|TVset], [S1|T1]) :-
distanceR2([HV|TV], HVset, X), S1 is X,
distanceAllVectors2([HV|TV], TVset, T1).


%predicate: distanceR2(+V1, +V2, -DistSq).

%Since the last element in each list is the class, we do not add it to the sum.
distanceR2([_], [_], 0 ).
distanceR2([H1|T1], [H2|T2], DistSq) :-
distanceR2(T1, T2, NextSum), DistSq is ((H1-H2)*(H1-H2))+NextSum.


%predicate: nnr1(+Test, +H, -Class).

nnr1([H1|T1], [H2|T2], Class) :-
distanceR2([H1|T1], H2, Dist),
theClass(H2, Nnr1Class),
nnr1_helper([H1|T1], [H2|T2], Dist, Nnr1Class),
Class is Nnr1Class.


%helper predicate: nnr1_helper(+Test, +H, +bestDistance, -Class).
nnr1_helper([_|_], [], _, _).
nnr1_helper([H1|T1], [H2|T2], Best, C) :-

distanceR2([H1|T1], H2, Dist),
theClass(H2, Class),

%If distance is closer, re-call with new best distance, and new class.
%Something to the effect of [C is Class] is needed after this call, but it causes an error I do not know how to fix.
%adding: [write("(first print should be nnr1 class): "), write(Class), nl,] after this helper call will print the correct class as the first print.
Dist < Best -> nnr1_helper([H1|T1], T2, Dist, Class);
%Else if distance is not closer, call with same best distance and class.
nnr1_helper([H1|T1], T2, Best, C).


