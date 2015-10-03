(ql:quickload :cl-haml)

(defpackage :cl-haml-demo
	(:use :common-lisp))

(in-package :cl-haml-demo)

(print (cl-haml:execute-haml (merge-pathnames "example.haml" *load-truename*)))