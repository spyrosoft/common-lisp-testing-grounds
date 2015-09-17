(load "defmacro-bang.lisp")

(defun defunits-chaining (u units prev)
  (if (member u prev)
      (error "~{ ~a~^ depends on~}"
             (cons u prev)))
  (let ((spec (find u units :key #'car)))
    (if (null spec)
        (error "Unknown unit ~a" u)
        (let ((chain (second spec)))
          (if (listp chain)
              (* (car chain)
                 (defunits-chaining
                     (second chain)
                     units
                   (cons u prev)))
              chain)))))

(defmacro! defunits (quantity base-unit &rest units)
  `(defmacro ,(symb 'unit-of- quantity)
       (g!-unit-value g!-unit)
     `(* ,g!-unit-value
         ,(case g!-unit
                ((,base-unit) 1)
                ,@(mapcar (lambda (x)
                            `((,(car x))
                              ,(defunits-chaining
                                (car x)
                                (cons
                                 `(,base-unit 1)
                                 (group units 2))
                                nil)))
                          (group units 2))))))