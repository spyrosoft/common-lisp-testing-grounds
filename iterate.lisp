(ql:quickload :iterate)

;; Iterate does not seem to work unless used in conjunction with a package

(defpackage :iterate-demonstration
	(:use :common-lisp :iterate))

(in-package :iterate-demonstration)


(defun repeat-example ()
	(iter (repeat 4)
				(print 'repeat-this)))

(defun for-in-example ()
	(let ((item nil) (example '(5 4 3 2 1)))
		(iter (for item in example)
					(print item))))

(defun from-to-example ()
	(let ((counter 0))
		(iter (for counter from 1 to 10)
					(collect counter))))