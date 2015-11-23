;; The key to optimization is identifying the bottlenecks
;; The `time' function is very handy
(time (SOME-FUNCTION-CALL))



;; Optimization declarations can be made globally with declare
;; Or locally with declaim
;; Scale of 0 - 3; 0 is least & 3 is most
(declare (optimize
          (speed 3)
          (safety 0)
          (debug 0)
          (space 0)
          (compilation-speed 0)))



;; The compiler treats inlining declamations as fact - it will always do so when requested
;; The declaim statement must come before any code where the function is used
;; Inlining functions shaves quite a bit of overhead off when a function is called many times, for example in a loop. But by doing so, it is less space efficient - that said, this is the 21st century, so space pretty much doesn't matter anymore

(defvar *max-iterations*)
(setq *max-iterations* 100000000)

(defun time-no-inlining (dummy-input)
  (* dummy-input dummy-input))

(time (do ((i 0 (1+ i)))
          ((= i *max-iterations*))
        (time-no-inlining i)))
;; 7.729 seconds

(declaim (inline time-inlining))

(defun time-inlining (dummy-input)
  (* dummy-input dummy-input))

(time (do ((i 0 (1+ i)))
          ((= i *max-iterations*))
        (time-inlining i)))
;; 4.289 seconds



;; Use macros to avoid consing &rest
;; Note that on most implementations, inlining the function effectively accomplishes the same goal
(defmacro recreate-list-macro (&rest list-items)
  `(list ,@list-items))

(defun time-recreate-list-macro ()
  (do ((i 0 (1+ i)))
      ((= i *max-iterations*))
    (recreate-list-macro 1 2 3 4 5 6 7 8)))

(time (time-recreate-list-macro))
;; 0.465 seconds

;; This function is useless and counter-productive
;; But you get the idea
(defun recreate-list-function (&rest list-items)
  (apply #'list list-items))

(defun time-recreate-list-function ()
  (do ((i 0 (1+ i)))
      ((= i *max-iterations*))
    (recreate-list-function 1 2 3 4 5 6 7 8)))

(time (time-recreate-list-function))
;; 9.909 seconds