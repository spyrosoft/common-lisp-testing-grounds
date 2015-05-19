(defpackage :try-out-zpng
	(:use :common-lisp :zpng)
	(:export :generate-png))

(in-package :try-out-zpng)

(declaim (optimize safety))
(declaim (optimize debug))

(defun generate-png ()
	(with-open-file (file "test.png" :direction :output :if-exists :supersede)
		(let* ((image-width 200)
					 (image-height 200)
					 (png (make-instance 'png
															 :color-type :truecolor
															 :width image-width
															 :height image-height))
					 (image-data (data-array png)))
			(dotimes (x image-height (write-png png file))
				(dotimes (y image-width)
					(cond ((= (mod x 10) 0)
								 (setf (aref image-data y x 1) 255))))))))