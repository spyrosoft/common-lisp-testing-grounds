(defun test (integer-input string-input)
  (check-type integer-input integer)
  (check-type string-input string)
  t)

(test 4 "yes")
;; Works

(test 4 4)
;; Fails on string-input

(test "yes" 4)
;; Fails on integer-input