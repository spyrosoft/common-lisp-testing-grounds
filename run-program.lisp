;; Run `ls' - output only

(let ((ls-process (run-program "/bin/ls" '()
															 :wait nil
															 :output :stream)))
	(unwind-protect
			 (with-open-stream (ls-process-stream (process-output ls-process))
				 (loop
						:for line := (read-line ls-process-stream nil nil)
						:while line
						:collect line))
		(when ls-process (process-close ls-process))))


;; Run `sort' - input and output

(let ((text-to-sort "bananas
apples
veggies
zebras"))
	(with-input-from-string (input-stream text-to-sort)
		(with-output-to-string (output-stream)
			(run-program "/bin/sort" '()
									 :input input-stream
									 :output output-stream)
      output-stream)))