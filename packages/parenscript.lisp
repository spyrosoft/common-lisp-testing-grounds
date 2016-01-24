(ql:quickload 'parenscript)

(defpackage :try-out-parenscript
  (:use #:cl #:parenscript)
  (:export :demo))

(in-package :try-out-parenscript)

(print (ps (encode-U-R-I-Component "yes")))