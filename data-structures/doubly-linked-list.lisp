;; Conceptual origin: http://stackoverflow.com/questions/5764394/data-structures-in-lisp/5764901?s=3%7C0.6456#5764901
(defpackage #:doubly-linked-list
  (:use #:cl))

(in-package #:doubly-linked-list)

(setf *print-circle* t)

(defun new (list-item-value)
  (cons list-item-value (cons nil nil)))

(defun convert-singly-linked-list (singly-linked-list)
  (let ((dl-list-head (new-dl-item)))
    (dolist (item singly-linked-list)
      (if (car dl-list-head)
        (setf (car dl-list-head) item)))))

(defun insert (list-item-value doubly-linked-list)
  (let ((new-list (new list-item-value)))
    (setf (cddr new-list) doubly-linked-list)
    (setf (cadr doubly-linked-list) new-list)
    new-list))


;; Origin ANSI Common Lisp by Paul Graham
(defstruct (dl (:print-function print-dl))
  prev data next)

(defun print-dl (dl stream depth)
  (declare (ignore depth))
  (format stream "#<DL ~A>" (dl->list dl)))

(defun dl->list (lst)
  (if (dl-p lst)
      (cons (dl-data lst) (dl->list (dl-next lst)))
      lst))

(defun dl-insert (x lst)
  (let ((elt (make-dl :data x :next lst)))
    (when (dl-p lst)
      (if (dl-prev lst)
          (setf (dl-next (dl-prev lst)) elt
                (dl-prev elt) (dl-prev lst)))
      (setf (dl-prev lst) elt))
    elt))

(defun dl-list (&rest args)
  (reduce #'dl-insert args
          :from-end t :initial-value nil))

(defun dl-remove (lst)
  (if (dl-prev lst)
      (setf (dl-next (dl-prev lst)) (dl-next lst)))
  (if (dl-next lst)
      (setf (dl-prev (dl-next lst)) (dl-prev lst)))
  (dl-next lst))