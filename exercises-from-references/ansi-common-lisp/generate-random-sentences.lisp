(defparameter *words* (make-hash-table :size 10000))

(defconstant maxword 100)

(defun read-text (pathname)
  (with-open-file (text-input pathname :direction :input)
    (let ((buffer (make-string maxword))
          (text-input-position 0))
      (do ((text-input-character (read-char text-input nil :eof)
              (read-char text-input nil :eof)))
          ((eql text-input-character :eof))
        (if (or (alpha-char-p text-input-character) (char= text-input-character #\') (char= text-input-character #\-))
            (progn
              (setf (aref buffer text-input-position) text-input-character)
              (incf text-input-position))
            (progn
              (unless (zerop text-input-position)
                (see (intern (string-downcase
                              (subseq buffer 0 text-input-position))))
                (setf text-input-position 0))
              (let ((is-punctuation (get-punctuation text-input-character)))
                (if is-punctuation (see is-punctuation)))))))))

(defun get-punctuation (test-character)
  (case test-character
    ;; What happens if the ||s aren't quoted?
    (#\. '|.|) (#\, '|,|) (#\; '|;|) (#\! '|!|) (#\? '|?|)))

(let ((previous-symbol '|.|))
  (defun see (symbol)
    (let ((pair (assoc symbol (gethash previous-symbol *words*))))
      (if (null pair)
          (push (cons symbol 1) (gethash previous-symbol *words*))
          (incf (cdr pair))))
    (setf previous-symbol symbol)))

(defun generate-text (text-length &optional (previous-symbol '|.|))
  (if (zerop text-length)
      (terpri)
      (let ((next-word (random-next previous-symbol)))
        (format t "~A " next-word)
        (generate-text (1- text-length) next-word))))

(defun random-next (previous-symbol)
  (let* ((choices (gethash previous-symbol *words*))
         (random-depth (random (reduce #'+ choices :key #'cdr))))
    (dolist (pair choices)
      (if (minusp (decf random-depth (cdr pair)))
          (return (car pair))))))