(defun sum-from-zero (number)
  ;; Note that multiple iterators can be instantiated
	;; Set `counter' to 1
  ;; For each subsequent iteration set `counter' to itself plus 1
	(do ((counter 1 (1+ counter))
			 ;; Set `sum' to 0
       ;; For each subsequent iteration set `sum' to itself plus `counter'
			 (sum 0 (+ counter sum)))
			;; At the end of each iteration, check to see if `counter' > `number'
      ;; Until the test returns true continue to iterate
      ;; When it returns true, return `sum'
			((> counter number) sum)))


;; From ANSI Common Lisp by Paul Graham
;; Demonstrating the difference between do and do*
(let ((x 'a))
  (do ((x 1 (+ x 1))
       (y x x))
      ((> x 5))
    (format t "(~A ~A) " x . y)))
;(1 A) (2 1) (3 2) (4 3) (5 4)
;NIL

(do* ((x 1 (+ x 1))
      (y x x))
     ((> x 5))
  (format t "(~A ~A) " x y))
;(1 1) (2 2) (3 3) (4 4) (5 5)
;NIL