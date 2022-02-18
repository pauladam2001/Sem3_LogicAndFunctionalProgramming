; 14.
; a) Write a function to return the union of two sets.

; remove_app(l1...ln, e) = { [], if n=0
;                          { l2...ln, if l1=e                            ; removes the elements = e from a list
;                          { l1 U remove_app(l2...ln), otherwise

(defun remove_app(l e)
  (cond
      ((null l) nil)
      ((equal (car l) e) (cdr l))
      (T (cons (car l)(remove_app (cdr l) e)))
  )
)

; sets_union(l1...ln, k1...km) = { [], if n=0, m=0
;                                { k1...kn, if n=0
;                                { l1...ln, if m=0
;                                { l1 U union_sets(l2...ln, remove_app(k1...km, l1)), otherwise

(defun sets_union(l k)
  (cond
      ((and (null l) (null k)) nil)
      ((null l) k)
      ((null k) l)
      (T (cons (car l) (sets_union (cdr l) (remove_app k (car l)))))
  )
)


; b) Write a function to return the product of all numerical atoms in a list, at any level.

; prod(l1...ln) = { 1, if n=0
;                 { prod(l1) * prod(l2...ln), if l1 is a list
;                 { l1 * prod(l2...ln), if l1 is a number
;                 { prod(l2...ln), otherwise

(defun  prod(l)
  (cond
      ((null l) 1)
      ((listp (car l)) (* (prod (car l)) (prod (cdr l))))
      ((numberp (car l)) (* (car l) (prod (cdr l))))
      (T (prod (cdr l)))
  )
)


; c) Write a function to sort a linear list with keeping the double values.

; insert(l1...ln, res) = { list(res), if n=0
;                        { res U l1...ln, if n=1 or res < l1
;                        { l1 U insert(l2...ln, res), otherwise

(defun insert(l res)
  (cond
      ((null l) (list res))
      ((or (equal (car l) l) (< res (car l))) (cons res l))
      (T (cons (car l) (insert (cdr l) res)))
  )
)

; sort_list(l1...ln) = { [], if n=0
;                      { insert(sort_list(l2...ln), l1), otherwise

(defun sort_list(l)
  (cond
      ((null l) nil)
      (T (insert (sort_list (cdr l)) (car l)))
  )
)


; d) Build a list which contains positions of a minimum numeric element from a given linear list.

; minn(l1...ln, c) = { c, if n=0
;                    { minn(l2...ln, l1), if l1<c
;                    { minn(l2...ln, c), otherwise

(defun minn(l c)
  (cond
      ((null l) c)
      ((< (car l) c) (minn (cdr l) (car l)))
      (T (minn (cdr l) c))
  )
)

; mainMin(l1...ln) = { minn(l1...ln, l1), if n>0
;                    { [], otherwise

(defun mainMin(l)
  (cond
      ((not (null l)) (minn l (car l)))
      (T nil)
  )
)

; positions(l1...ln, e, p) = { [], if n=0
;                            { p U positions(l2...ln, e, p+1), if l1=e
;                            { positions(l2...ln, e, p+1), otherwise

(defun positions(l e p)
  (cond
      ((null l) nil)
      ((equal (car l) e) (cons p (positions (cdr l) e (+ p 1))))
      (T (positions (cdr l) e (+ p 1)))
  )
)

; mainPtD(l1...ln) = positions(l1...ln, mainMin(l1...ln), 1)

(defun mainPtD(l)
  (positions l (mainMin l) 1)
)