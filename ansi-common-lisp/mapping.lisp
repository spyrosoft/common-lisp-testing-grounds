(defun when-even-make-list (number)
  (when (evenp number) (list number)))

(defvar example-list '(1 2 3 4 5 6 7 8 9))


(mapcar #'when-even-make-list example-list)

;; Caution Destructive - uses `nconc'
(mapcan #'when-even-make-list example-list)

(mapc #'when-even-make-list example-list)