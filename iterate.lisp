(ql:quickload :iterate)

(iter (repeat 100)
			(print 'yes))

(defvar example '(5 4 3 2 1))

(let ((item))
	(iter (for item in example)
				(print item)))

(let ((counter 0))
	 (iter (for counter from 1 to 10)
				 (collect counter)))