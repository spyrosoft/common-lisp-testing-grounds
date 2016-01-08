(ql:quickload :cffi)

;;; Nothing special about the "CFFI-USER" package.  Just an example.
(defpackage :cffi-user
	(:use :common-lisp :cffi))

(in-package :cffi-user)

(define-foreign-library libcurl
    (:darwin (:or "libcurl.4.dylib" "libcurl.dylib"))
	(:unix (:or "libcurl.so.4" "libcurl.so"))
	(t (:default "libcurl")))

(use-foreign-library libcurl)