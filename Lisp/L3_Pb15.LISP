; 15. Write a function that reverses a list together with all its sublists elements, at any level.

; reverseList(l1...ln) = { l, if l atom
;                        { reverseList(reverse(l1)) U ... U reverseList(reverse(ln)), otherwise

(defun reverseList(L)
  (cond
      ((atom L) L)
      (T (mapcar #'reverseList (reverse L)))
  )
)