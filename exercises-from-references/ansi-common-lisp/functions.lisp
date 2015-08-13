;; Chapter 6 - Functions
;; 3. Define a function that takes any number of arguments and returns the number of arguments passed to it.

(defun how-many-arguments (&rest arguments)
  (length arguments))

(how-many-arguments 'a 'b 'c 'd 'e 'f)
;; 6

;; There was mention of using macros to remove the necessity of consing here to the end of identifying how many &rest arguments were passed. Is this true???? How the what?


;; 4. Modify most to return, as two values, the two highest-scoring elements of a list.
;; (defun most (fn lst)
;;   (if (null lst)
;;       (values nil nil)
;;       (let* ((wins (car lst))
;;              (max (funcall fn wins)))
;;         (dolist (obj (cdr lst))
;;           (let ((score (funcall fn obj)))
;;             (when (> score max)
;;               (setf wins obj
;;                     max  score))))
;;         (values wins max))))

;; What are these variables for? wins? obj?
;; I have no idea what most is supposed to do. The following errors out:
(most #'> '(1 2 3 4))

;; So I am going to interpret this question as expecting a comparison function and a list of things to compare
(defun two-most (comparison-function list)
  (let ((two-most '(nil nil)))
    (dolist (item list)
      (cond ((null (first two-most))
             (setf (first two-most) item)
             (print two-most))
            (t
             (if (funcall comparison-function item (first two-most))
                 (progn
                   (setf (second two-most) (first two-most))
                   (setf (first two-most) item))
                 (if (null (second two-most))
                     (setf (second two-most) item)
                     (when (funcall comparison-function item (second two-most))
                       (setf (second two-most) item)))))))
    (print two-most)
    (apply #'values two-most)))

(two-most #'> '(2 8 3 7 4 6 5))


;; 6. Define a function that takes one argument, a number, and returns the greatest argument passed to it so far.

(defun greatest-so-far ()
  (let ((greatest-so-far nil))
    (lambda (number)
      (if (null greatest-so-far)
          (setf greatest-so-far number)
          (when (> number greatest-so-far)
            (setf greatest-so-far number)))
      greatest-so-far)))

(defvar example-greatest-so-far (greatest-so-far))
(funcall example-greatest-so-far -1)

;; That is beautiful! Yay.


;; 7. Define a function that takes one argument, a number, and returns true if it is greater than the argument passed to the function the last time it was called. The function should return n i l the first time it is called.

(defun greater-than-last-time ()
  (let ((last-number nil))
    (lambda (number)
      (let ((current-last-number last-number))
        (setf last-number number)
        (if (null current-last-number)
            nil
            (if (> number current-last-number)
                t
                current-last-number))))))

(defvar example-greater-than-last-time (greater-than-last-time))
(funcall example-greater-than-last-time -1)
(funcall example-greater-than-last-time -1)
(funcall example-greater-than-last-time 1)
(funcall example-greater-than-last-time 1)


;; 8. Suppose expensive is a function of one argument, an integer between 0 and 100 inclusive, that returns the result of a time-consuming computation. Define a function frugal that returns the same answer, but only calls expensive when given an argument it has not seen before.

(defun expensive (input-number)
  (sin input-number))

(defun frugal ()
  (let ((expensive-lookup (make-hash-table :test 'eq)))
    (lambda (input-number)
      (let ((existing-expensive-answer (gethash input-number expensive-lookup)))
        (if existing-expensive-answer
            (progn
              (print "Existing expensive exists!")
              existing-expensive-answer)
            (let ((expensive-answer (expensive input-number)))
              (setf (gethash input-number expensive-lookup) expensive-answer)
              expensive-answer)
            )))))

(defvar example-frugal (frugal))
(funcall example-frugal 0)
(funcall example-frugal 0)

;; Cooool!! And useful.


