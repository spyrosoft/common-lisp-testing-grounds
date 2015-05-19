(defun ^ (a b)
  (do ((x 1 (* x a))
       (y 0 (+ y 1)))
      ((= y b) x)))


(defun sum-from-zero (number)
	;; Set `counter' to 1, and for each iteration after to itself plus 1
	(do ((counter 1 (+ counter 1))
			 ;; Set `sum' to 0, and for each iteration after to itself plus sum
			 (sum 0 (+ counter sum)))
			;; At the end of each iteration, check to see if `counter' > `number', if so, return `sum'
			((> counter number) sum)))