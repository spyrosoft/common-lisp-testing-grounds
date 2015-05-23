;; Run `ls' - output only

(with-output-to-string (output-stream)
	(run-program "/bin/ls" '()
							 :output output-stream))

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

;; Run `ls' and pipe to `grep' - output only

(let ((ls-process (run-program "/bin/ls" '()
															 ;; Must run in background to work in tandem with the additional `grep' process - :wait nil
															 :wait nil
															 :output :stream)))
	(unwind-protect
			 (with-open-stream (ls-process-output (process-output ls-process))
				 (let ((grep-process (run-program "/usr/bin/grep" '("a")
																					:input ls-process-output
																					:output :stream)))
					 (when grep-process
						 (unwind-protect
									(with-open-stream (grep-process-output (process-output grep-process))
										(loop
											 :for line := (read-line grep-process-output nil nil)
											 :while line
											 :collect line))
							 (process-close grep-process)))))
		(when ls-process (process-close ls-process))))