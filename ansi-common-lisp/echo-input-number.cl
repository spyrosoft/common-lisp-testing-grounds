(defun ask-number()
	(print "Please enter a number.")
	(let ((val (read)))
		(if (numberp val)
				(print val)
				(ask-number))))
