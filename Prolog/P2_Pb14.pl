% 14.
% a. Define a predicate to determine the longest sequences of consecutive even numbers (if exist more maximal 
% sequences one of them).
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to replace 
% every sublist with the longest sequences of even numbers from that sublist.
% Eg.: [1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3] =>
% [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]

% a.
% 
% even(n) = true, if n%2=0
% 		    false, otherwise
%
% even(N-number)
% flow model (i)

even(N):-
   N mod 2 =:= 0.

% listLength(l1l2...ln) = [], if n=0
% 						  1 + listLength(l2...ln), otherwise
% 						  
% listLength(L-list, R-number)
% flow model (i, o) ; (i, i)

listLength([], 0).
listLength([_|T], R):-
    listLength(T, R1),
    R is R1+1.

% appendToList(l1l2...ln, e) = [e], if n=0
% 							   l1 + appendToList(l2...ln, e), otherwise
% 							   
% appendToList(L-list, E-Number, R-list)
% flow model (i, i, o) ; (i, i, i)

appendToList([], E, [E]).
appendToList([H|T], E, [H|R]):-
    appendToList(T, E, R).

% longestSequence(l1l2...ln, t1t2...tm, r1r2...rx) = r1r2...rx, if n=0 and m < 1	% it means that at this moment we haven't found the longest sequence yet
% 													 t1t2...tm, if n=0 and m > 1	% it means that at this moment we have found the longest sequence, and is in t1...tm
% 										longestSequence(l2...ln, t1...tm, l1 U r1...rx), if even(l1) = true		% if the current element is even we append it to the aux list
% 										longestSequence(l2...ln, r1...rx, []), if even(l1) = false and m < 1	% if the current element is odd and we don't have the longest sequence yet
% 										longestSequence(l2...ln, t1...tm, []), if even(l1) = false and m > 1	% if the current element is odd and we have the longest sequence
%
% longestSequence(L-list, LONGEST-List, AUX-List, R-List)
% flow model (i, i, i, o) ; (i, i, i, i)

longestSequence([], LONGEST, AUX, AUX):-
    listLength(LONGEST, RLONGEST),
    listLength(AUX, RAUX),
    RAUX > RLONGEST.
longestSequence([], LONGEST, AUX, LONGEST):-
    listLength(LONGEST, RLONGEST),
    listLength(AUX, RAUX),
    RLONGEST >= RAUX.
longestSequence([H|T], LONGEST, AUX, R):-
    even(H), !,
    appendToList(AUX, H, RAUX),
    longestSequence(T, LONGEST, RAUX, R).
longestSequence([_|T], LONGEST, AUX, R):-
    listLength(LONGEST, RLONGEST),
    listLength(AUX, RAUX),
    RAUX >= RLONGEST, !,
    longestSequence(T, AUX, [], R).
longestSequence([_|T], LONGEST, AUX, R):-
	listLength(LONGEST, RLONGEST),
    listLength(AUX, RAUX),
    RLONGEST > RAUX,
    longestSequence(T, LONGEST, [], R).

% b.
% 
% replace(l1l2...ln) = [], if n=0
%					   longestSequence(l1, [], []) U replace(l2...ln), if is_list(l1)
%					   l1 U replace(l2...ln), otherwise
%
% replace(L-list, R-list)
% flow model (i, o) ; (i, i)

replace([], []).
replace([H|T], [HR|R]):-
    is_list(H), !,
    longestSequence(H, [], [], HR),
    replace(T, R).
replace([H|T], [H|R]):-
    replace(T, R).


% replace([1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3], R).
% longestSequence([1,2,2,2,3,4,4,4,5,6,6], [], [], R).











