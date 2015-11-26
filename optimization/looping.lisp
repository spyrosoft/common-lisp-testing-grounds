(ql:quickload 'iterate)

(defpackage #:demonstrate-group-functions
  (:use #:cl #:iterate)
  (:export #:demonstrate-each-group-function))

(in-package #:demonstrate-group-functions)

(declaim (inline group-dolist group-iterate firstn group-loop group-recursion))

(defun group-dolist (list-to-unflatten second-dimension)
  "Similar to Paul Graham's `group' - takes a list and pushes n items into sub lists until there are no more items in the list."
  (let ((unflattened-list '()) (current-dimension-list '()) (i 1))
    (dolist (item list-to-unflatten)
            (if (= second-dimension i)
                (progn
                  (setq i 0)
                  (push item current-dimension-list)
                  (push (nreverse current-dimension-list) unflattened-list)
                  (setq current-dimension-list '()))
                (push item current-dimension-list))
            (incf i))
    (when (not (null current-dimension-list))
      (push (nreverse current-dimension-list) unflattened-list))
    (nreverse unflattened-list)))


(defun firstn (n list)
  (let ((new-list '()))
    (do ((i 0 (1+ i))
         (current-list list (rest current-list)))
        ((or (null current-list)
             (= n i)))
      (push (car current-list) new-list))
    (nreverse new-list)))

(defun group-iterate (stuff n)
  (iter (for all :initially stuff :then rest)
        (while all)
        (for rest = (nthcdr n all))
        (collect (if rest (firstn n all) all))))


(defun group-loop (stuff n)
  (loop for all = stuff then rest
     while all
     for rest = (nthcdr n all)
     collect (if rest (firstn n all) all)))


(defun group-recursion (source n)
  (if (zerop n) (error "zero length"))
  (labels ((rec (source acc)
             (let ((rest (nthcdr n source)))
               (if (consp rest)
                   (rec rest (cons (subseq source 0 n) acc))
                   (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))


(defvar *time-function-iterations* 1000000)

(defmacro call-group-function-over-and-over (which-group)
  `(dotimes (i *time-function-iterations*)
     (,which-group '(1 2 3 4 5 6 7 8) 2)
     ))

(print (group-dolist '(1 2 3 4 5) 2))
(print (group-iterate '(1 2 3 4 5) 2))
(print (group-loop '(1 2 3 4 5) 2))
(print (group-recursion '(1 2 3 4 5) 2))

(defun demonstrate-each-group-function ()
  (time (call-group-function-over-and-over group-dolist))
  (time (call-group-function-over-and-over group-iterate))
  (time (call-group-function-over-and-over group-loop))
  (time (call-group-function-over-and-over group-recursion)))