;; Modified from Origin: http://lib.store.yahoo.net/lib/paulgraham/acl2.lisp

(defun make-queue () (cons nil nil))

(defun enqueue (item-to-insert q)
  (if (null (car q))
      (setf (cdr q) (setf (car q) (list item-to-insert)))
      (setf (cdr (cdr q)) (list item-to-insert)
            (cdr q) (cdr (cdr q))))
  (car q))

(defun dequeue (q) 
  (pop (car q)))