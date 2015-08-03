;; Origin: ANSI Common Lisp by Paul Graham:
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