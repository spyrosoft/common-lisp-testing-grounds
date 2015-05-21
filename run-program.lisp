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