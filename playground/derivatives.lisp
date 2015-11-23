(defun deriv (expression x)
	(cond ((numberp expression) 0)
				((equal expression x) 1)
				((symbolp expression) 0)
				(t (let ((op (first expression))
								(u (second expression))
								(v (third expression)))
						(cond ((equal op '+) (list '+ (deriv u x) (deriv v x)))
									((equal op '*) (list '+
																				(list '* u (deriv v x))
																				(list '* v (deriv u x))))
									((equal op 'expt) (list '* v (expt u (- v 1))))
									((equal op 'cos) (list 'sin (deriv u x))))))))

(defun simplify (expression)
	())

(deriv 'x 'x)
;(deriv '(+ (* 7 (expt x 2)) (* 9 x) 2 (cos (* 3 x))) 'x)
