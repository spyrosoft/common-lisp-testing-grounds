(defun cantus-firmus (n)
	(cond ((eq n 0) (random 7))
				((eq n 1) (rand-nth #(0 2 3 4 6)))
				((eq n 2) (rand-nth #(0 1 3 5)))
				((eq n 3) (rand-nth #(0 1 4 6)))
				((eq n 4) (rand-nth #(0 5 6)))
				((eq n 5) (rand-nth #(0 1 2 6)))
				((eq n 6) (rand-nth #(0 2 4)))))

(defun rand-nth (array-in-question)
	(aref array-in-question (random (array-total-size array-in-question))))

(defun print-cantus-firmus (i n)
	(print (+ 1 n))
	(if (< i 0)
		nil
		(print-cantus-firmus (- i 1) (cantus-firmus n))))

;(cantus-firmus (random 6))
;(print (rand-nth #(44 45 46 47 48)))

(print-cantus-firmus 100 4)
