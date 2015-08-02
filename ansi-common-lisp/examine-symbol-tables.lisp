(defun get-all-symbols (&optional package)
  "List all symbols registered in the specified package's symbol table."
  (let ((lst ())
        (package (find-package package)))
    (do-all-symbols (s lst)
      (when (fboundp s)
        (if package
            (when (eql (symbol-package s) package)
              (push s lst))
            (push s lst))))
    lst))

;; For example, (if you're using SBCL) use 'sb-thread for the specified package
(get-all-symbols 'sb-thread)