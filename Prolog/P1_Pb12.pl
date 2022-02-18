% 12. 
% a. Write a predicate to substitute in a list a value with all the elements of another list.
% b. Remove the k-th element of a list.
%
% a.
% insertListEnd(l1l2...ln, list) = list, if n=0
% 				   				   l1 U insert(l2...ln, list), otherwise
% 									 
% insertListEnd(L-list, List-list, R-list)
% flow model (i, i, o) ; (i, i, i)
% 

insertListEnd([], L, L).
insertListEnd([H|T], L, [H|R]) :-
    insertListEnd(T, L, R).

% substitute(l1l2...ln, v, list) = [], if n=0
%								   substitute(insertListEnd(list, l2...ln), v, list), if l1=v
%								   l1 U substitute(l2...ln, v, list), otherwise
%								   		 
% substitute(L-list, V-number, List-list, R-list)
% flow model (i, i, i, o) ; (i, i, i, i)

substitute([], _, _, []).
substitute([H|T], V, List, R) :-
    H =:= V, !,							% for char ==
    insertListEnd(List, T, RI),
    substitute(RI, V, List, R).
substitute([H|T], V, List, [H|R]) :-			% [H|T] and [H|R], same heads
    H =\= V,						% for char \==
    substitute(T, V, List, R).

% b.
% delete(l1l2...ln, k) = [], if n=0
%						 l2...ln, if k=1
%						 l1 U delete(l2...ln, k-1), otherwise
%						 
% delete(L-list, K-position, R-list)
% flow model (i, i, o) ; (i, i, i)

delete([], _, []).
delete([_|T], K, R):-
    K=:=1, !,
    R=T.
delete([H|T], K, R):-		% OR the third argument is [H|RT] and we don't have line 48
    K=\=1,
    delete(T, K-1, RT),
    R=[H|RT].