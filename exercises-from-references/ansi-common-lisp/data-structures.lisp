;; Chapter 4 - Specialized Data Structures
;; 1. Define a function to take a square array (an array whose dimensions are (n n)) and rotate it 90° clockwise:

(defun quarter-turn (array-to-turn)
  (let* ((square-dimensions (first (array-dimensions array-to-turn)))
         (turned-array (make-array (list square-dimensions square-dimensions))))
    (dotimes (row square-dimensions)
      (dotimes (column square-dimensions)
        (setf (aref turned-array row column)
              (aref array-to-turn (- square-dimensions column 1) row))))
    turned-array))

(quarter-turn #2A((a b) (c d)))
;; #2A((C A) (D B))
(quarter-turn #2A((a b) (c d)))
;; #2A((D A B) (D E F) (G H I))


;; 2. Use the reduce function to achieve the following:
;; (a) copy-list

(defun reduce-copy-list (list-to-copy)
  (reduce #'cons list-to-copy :from-end t :initial-value '()))

;; (b) reverse (lists only)

(defun reduce-reverse (list-to-reverse)
  (reduce #'(lambda (item1 item2) (cons item2 item1)) list-to-reverse :initial-value '()))