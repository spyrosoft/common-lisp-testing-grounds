;; Source:
;; http://compgroups.net/comp.lang.lisp/redirecting-program-output-with-sbcl-s-run-pro/109338

(defun piping-demonstration ()
  (let ((ls-process (run-program "/bin/ls" '()
           :wait nil
           :output :stream)))
    (unwind-protect
   (with-open-stream (s (process-output ls-process))
     (let ((grep-process (run-program "/usr/bin/grep" '("a")
            :input s
            :output :stream)))
       (when grep-process
         (unwind-protect
        (with-open-stream (o (process-output grep-process))
          (loop
       :for line := (read-line o nil nil)
       :while line
       :collect line))
     (process-close grep-process)))))
      (when ls-process (process-close ls-process)))))