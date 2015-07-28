;; Tic is like single-quote in that it prevents evaluation of its expression, except in that comma and comma-at turns evaluation back on:
(defvar a 'yes)
`(a has a value of ,a)



;; Example of how comma-at is useful
;; Let's make a macro that will evaluate its body while the test evaluates to false
;; Accomplishing the following:
(let ((x 0))
  (while (< x 10)
    (princ x)
    (incf x)))

;; Here it is:
(defmacro while (test &rest body)
  `(do ()
       ((not ,test))
     ,@body))



;; Make a macro which does something n times:
(defmacro ntimes (n &rest body)
  `(do ((iterator 0 (1+ iterator)))
       ((>= iterator ,n))
     ,@body))

(ntimes 10 (princ "."))

;; This breaks if someone uses the variable x in the body:
(let ((x 10))
  (ntimes (princ x)))

;; To resolve the issue we use gensym:
(defmacro ntimes (n &rest body)
  (let ((iterator (gensym)))
    `(do ((,iterator 0 (1+ ,iterator)))
         ((>= ,iterator ,n))
       ,@body)))

;; This now works:
(let ((x 10))
  (ntimes (princ x)))

;; However, it still breaks if someone uses something that changes when it is evaluated for n:
(let ((v 10))
  (ntimes (setf v (- v 1))
          (princ ".")))

;; One more gensym:
(defmacro ntimes (n &rest body)
  (let ((iterator (gensym))
        (limit (gensym)))
    `(let ((,limit ,n))
       (do ((,iterator 0 (1+ ,iterator)))
           ((>= ,iterator ,limit))
         ,@body))))

