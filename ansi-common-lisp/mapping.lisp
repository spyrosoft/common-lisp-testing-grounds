(defun when-even-make-list (number)
  (when (evenp number) (list number)))

(defvar example-list '(1 2 3 4 5 6 7 8 9))


;; Accumulates the results of the specified function on each element of the specified list into a new list
(mapcar #'when-even-make-list example-list)

;; Caution Destructive
;; Same as mapcar except that it uses `nconc' to accumulate items effectively ignoring nil and atoms
(mapcan #'when-even-make-list example-list)

(mapc #'when-even-make-list example-list)

;; Destructive function to replace each item of a sequence with the result of the specified function on said element
(defvar example-map-into-vector
  (make-array '(8)
              :element-type 'fixnum
              :initial-contents '(1 2 3 4 5 6 7 8)))
(setq example-map-into-vector
      (map-into example-map-into-vector #'1+ example-map-into-vector))