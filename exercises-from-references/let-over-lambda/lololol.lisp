;; Let Over Lambda

(defun odometer-instance ()
  (let ((odometer 0))
    (lambda () (incf odometer))))

(setf (symbol-function 'odometer) (odometer-instance))


(defun lap-counter-instance ()
  (let ((laps 0))
    (lambda (increment-or-reset)
      (case increment-or-reset
        (:inc (incf laps))
        (:reset (setq laps 0))))))

(setf (symbol-function 'lap-counter) (lap-counter-instance))