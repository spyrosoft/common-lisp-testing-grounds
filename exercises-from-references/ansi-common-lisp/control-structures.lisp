;; Chapter 5 - Control Structures
;; 1. Translate the following expressions into equivalent expressions that don't use let or let*, and don't cause the same expression to be evaluated twice.
;; (a) (let ((x (car y)))
;;       (cons x x))

((lambda (x) (cons x x) (car y)))

;; (b) (let* ((w (car x))
;;        (y (+ v z)))
;;       (cons w y))

((lambda ()))