;; Chapter 7 - IO
;; 1. Define a function that takes a filename and returns a list of strings representing each line in the file.

(defun file-line-by-line-string-list (file-path)
  (let ((string-list '()))
    (with-open-file (stream file-path)
      (do ((line (read-line stream nil)
                 (read-line stream nil)))
          ((null line))
        (push line string-list)))
    (reverse string-list)))


;; 2. Define a function that takes a filename and returns a list of the expressions in the file.
;; This sounds awesome, but what's the best way to do this?


;; 3. Suppose that in some format for text files, comments are indicated by a % character. Everything from this character to the end of the line is ignored. Define a function that takes two filenames, and writes to the second file a copy of the first, minus comments.

