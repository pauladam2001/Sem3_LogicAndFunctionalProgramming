% 1. Write a predicate to generate the list of all subsets with K elements of a given list. 
% Eg: [2, 3, 4], K=2 => [[2,3],[2,4],[3,4]]
% <==> Combinations of K elements from a list L with n elements (1 <= K <= n)

% comb(l1l2...ln, K) = l1, if K=1, n>=1
%					   comb(l2...ln, K), K>=1
%					   l1 U comb(l2...ln, K-1), K>1
%
% comb(L-list, K-number of elements, R-list)
% flow (i,i,o)

comb([H|_], 1, [H]).
comb([_|T], K, R):-
    comb(T, K, R).
comb([H|T], K, [H|R]):-
    K > 1,
    K1 is K-1,
    comb(T, K1, R).

% findall(S, comb([2,3,4], 2, S), RL).