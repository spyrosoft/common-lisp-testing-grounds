(setq *read-default-float-format* 'double-float)

(ql:quickload :cl-json)
(ql:quickload :iterate)

(defpackage cl-json-demonstration
	(:use :common-lisp :cl-json :iterate))

(in-package cl-json-demonstration)

(defvar input-json "{\"Integer\":100, \"*string\":\"string\", \"float\":1.234567890123456789, \"boolean\": true, \"dimensional-array\": [1,2,3,[1,2,3]]}")

(defvar parsed-input-json (json:decode-json-from-string input-json))

;; Note how case is handled, and how asterisks in the original JSON mess up the mapping
;; *string
(print parsed-input-json)
;; String
(print (json:encode-json-to-string parsed-input-json))

(iterate (for input-json-item in parsed-input-json)
				 (print (first input-json-item)))