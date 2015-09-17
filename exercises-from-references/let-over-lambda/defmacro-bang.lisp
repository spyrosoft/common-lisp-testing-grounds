(load "paul-graham-utilities.lisp")

(defmacro defmacro/g! (name args &rest body)
  (let ((g!-symbols (remove-duplicates
               (remove-if-not #'g!-symbol-p
                              (flatten body)))))
    `(defmacro ,name ,args
       (let ,(mapcar
              (lambda (g!-symbol)
                `(,g!-symbol (gensym ,(subseq
                                       (symbol-name g!-symbol)
                                       2))))
              g!-symbols)
         ,@body))))

(defun g!-symbol-p (symbol-to-test)
  (and (symbolp symbol-to-test)
       (> (length (symbol-name symbol-to-test)) 2)
       (string= (symbol-name symbol-to-test)
                "G!"
                :start1 0
                :end1 2)))

(defmacro defmacro! (name args &rest body)
  (let* ((o!-symbols (remove-if-not #'o!-symbol-p args))
         (g!-symbols (mapcar #'o!-symbol-to-g!-symbol o!-symbols)))
    `(defmacro/g! ,name ,args
       `(let ,(mapcar #'list (list ,@g!-symbols) (list ,@o!-symbols))
          ,(progn ,@body)))))

(defun o!-symbol-p (symbol-to-test)
  (and (symbolp symbol-to-test)
       (> (length (symbol-name symbol-to-test)) 2)
       (string= (symbol-name symbol-to-test)
                "O!"
                :start1 0
                :end1 2)))

(defun o!-symbol-to-g!-symbol (o!-symbol)
  (symb "G!" (subseq (symbol-name o!-symbol) 2)))

