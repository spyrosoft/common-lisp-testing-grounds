;; Handle ANY error
(defun divide-by-zero-handler ()
	(handler-case (/ 2 0)
		(error nil "yes")))