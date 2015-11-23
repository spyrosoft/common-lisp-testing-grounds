(defun expand (list-1 list-2 function)
  "Opposite of reduce"
  (when (= (length list-1) (length list-2))
    (let ((expansion '()))
      (dolist (list-1-item list-1)
              (let ((dimensional-expansion '()))
                (dolist (list-2-item list-2)
                        (push (funcall function list-1-item list-2-item) dimensional-expansion))
                (push dimensional-expansion expansion)))
      expansion
      )))


(defmacro until (test &rest body)
  `(do ()
       (,test)
     ,@body))

(defmacro while (test &rest body)
  `(do ()
       ((not ,test))
     ,@body))


(defun memoize (function-to-memoize)
  (let ((cache (make-hash-table :test #'equalp)))
    (lambda (&rest args)
      (or (gethash args cache)
          (setf (gethash args cache)
                (apply function-to-memoize args))))))

(defmacro defmemoize (name args &body body)
 `(setf (symbol-function ',name) 
        (memoize (lambda ,args ,@body))))