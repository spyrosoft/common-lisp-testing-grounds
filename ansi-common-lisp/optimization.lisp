;; Origin: ANSI Common Lisp by Paul Graham

;; Five parameters control the way your code is compiled:
;; 1) speed refers to the speed of the code produced by the compiler
;; 2) compilation-speed refers to the speed at which your program will be compiled
;; 3) safety refers to the amount of error-checking done in the object code
;; 4) space refers to the size and memory needs of the object code
;; 5) debug refers to the amount of information retained for debugging

;; Optimal for final compilation:
(declaim (optimize (speed 3) (safety 0) (space 0) (debug 0) (compilation-speed 0)))

;; Optimal for debugging:
(declaim (optimize (speed 0) (safety 3) (space 0) (debug 3) (compilation-speed 0)))

;; This statement can be placed anywhere. Placing it at the beginning of the program may be overkill. Play around with profiling and placing it where the bottleneck is to see what difference it makes.


;; Global variables use declaim, local variables use declare:
(defvar *example-fixnum* 0)
(declaim (fixnum *example-fixnum*))

(let ((example-fixnum-1 0) (example-fixnum-2 0))
  (declare (fixnum example-fixnum-1 example-fixnum-2))
  (+ example-fixnum-1 example-fixnum-2))

(defun add-example-fixnums (example-fixnum-1 example-fixnum-2)
  (declare (fixnum example-fixnum-1 example-fixnum-2))
  (+ example-fixnum-1 example-fixnum-2))


;; You can also declare that the value of an expression will be of a certain type, by using `the':
(defun add-example-fixnums (example-fixnum-1 example-fixnum-2)
  (declare (fixnum example-fixnum-1 example-fixnum-2))
  (the fixnum (+ example-fixnum-1 example-fixnum-2)))


;; When using a specialized array as an argument to a function which you know will be the only type of array passed, declaim the type in the function:
(setf example-single-float-array
      (make-array '(1000 1000)
                  :element-type 'single-float
                  :initial-element 1.0s0))

;; Common Lisp stores arrays in row major order - therefore you may see a performance boost by selecting elements from the array as such
(defun sum-elements-of-single-float-array (single-float-array)
  (declare (type (simple-array single-float (1000 1000))
                 single-float-array))
  (let ((sum 0.0s0))
    (declare (type single-float sum))
    (dotimes (rows 1000)
      (dotimes (columns 1000)
        ;; Consider using row-major-aref and a single (dotimes) for speed
        (incf sum (aref single-float-array rows columns))))
    sum))

(sum-elements-of-single-float-array example-single-float-array)


;; When possible use simple vectors as they block out memory in and of themselves as opposed to using pointers
;; Upon doing so, use svref rather than aref for a speed boost


;; Use `map-into' to write a sequence's new value over itself


;; Excerpt from ANSI Common Lisp regarding the affects of cons on efficiency:
;; In Lisp implementations with bad garbage collectors, programs that cons a lot tend to run slowly. Until recently, most Lisp implementations have had bad garbage collectors, and so it has become a tradition that efficient programs should cons as little as possible. Recent developments have turned this conventional wisdom on its head. Some implementations now have such sophisticated garbage collectors that it is faster to cons up new objects and throw them away than it is to recycle them.
;; Whether consing less will make your programs run faster depends on the implementation. Again, the best advice is to try it and see.

;; One way to optimize your code is to use destructive functions in place of safe functions:
;; SAFE -> DESTRUCTIVE
;; append -> nconc
;; reverse -> nreverse
;; remove -> delete
;; remove-if -> delete-if
;; remove-duplicates -> delete-duplicates
;; subst -> nsubst
;; subst-if -> nsubst-if
;; union -> nunion
;; intersection -> nintersection
;; set-difference -> nset-difference


;; Using sparse-arrays in place of lists avoids allocating new memory