;; Chapter 5 - Control Structures
;; 1. Translate the following expressions into equivalent expressions that don't use let or let*, and don't cause the same expression to be evaluated twice.
;; (a)

(defvar y '(y))
(let ((x (car y)))
  (cons x x))

((lambda (x)
   (cons x x))
 (car y))

;; (b) (let* ((w (car x))
;;        (y (+ w z)))
;;       (cons w y))

(defvar x '(1))
(defvar z '2)
;; Equivalent to:
(let ((w (car x)))
  (let ((y (+ w z)))
    (cons w y)))

;; Equivalent to:
((lambda (w)
   ((lambda (y)
      (cons w y))
    (+ w z)))
 (car x))


;; 6. Define iterative and recursive versions of a function that takes an object and a list, and returns a new list in which the object appears between each pair of elements in the original list.

(defun intersperse (join-character list-to-join)
  (let ((joined-list '()))
    (dolist (item list-to-join)
      (push item joined-list)
      (push '- joined-list))
    (pop joined-list)
    (reverse joined-list)))

(intersperse '- '(a b c d))
;; (A - B - C - D)


