; 14. Determine the list of nodes accessed in postorder (left, right, root) in a tree of type (1).
; Ex.: (A 2 B 2 C 1 I 0 F 1 G 0 D 2 E 0 H 0) -> Postorder: I, C, G, F, B, E, H, D, A
;             A
;        B          D
;      C   F      E   H
;     I   G


; nv - number of vertices
; ne - number of edges
; parse_left(l1...ln, nv, ne) = { nil, if n=0
;                               { nil, if nv = 1+ne
;                               { l1 U l2 U parcurg_st(l3...ln, nv+1, ne + l2), otherwise
; parse_left will go through the list starting with the 3rd element and will return the left subtrees

(defun parse_left(tree nv ne)
  (cond
      ((null tree) nil)
      ((= nv (+ 1 ne)) nil)
      (T (cons (car tree) (cons (cadr tree) (parse_left (cddr tree) (+ 1 nv) (+ (cadr tree) ne)))))
  )
)

; aux function to determine the left subtree of a tree represented in V1
; left_subtree = parse_left(tree, 0, 0)

(defun left_subtree(tree)
  (parse_left(cddr tree) 0 0)
)

; nv - number of vertices
; ne - number of edges
; parse_right(l1...ln, nv, ne) = { nil, if n=0
;                                { l1...ln, if nv = 1+ne
;                                { parse_right(l3...ln, nv+1, ne + l2), otherwise
; parse_right will go through the list starting with the 3rd element and will return the right subtrees

(defun parse_right(tree nv ne)
  (cond
      ((null tree) nil)
      ((= nv (+ 1 ne)) tree)
      (T (parse_right (cddr tree) (+ 1 nv) (+ (cadr tree) ne)))
  )
)

; aux function to determine the right subtree of a tree represented in V1
; right_subtree = parse_right(tree, 0, 0)
(defun right_subtree(tree)
  (parse_right(cddr tree) 0 0)
)

; postorder(l1l2...ln) = { [], if n=0
;                        { postorder(left_subtree(l1l2...ln)) U postorder(riht_subtree(l1l2...ln)) U l1, otherwise

(defun postorder(tree)
  (cond
      ((null tree) nil)
      (T (append (postorder (left_subtree tree)) (postorder (right_subtree tree)) (list (car tree))))
  )
)