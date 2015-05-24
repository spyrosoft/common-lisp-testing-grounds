(ql:quickload :jsown)

(defvar input-json "{\"integer\":100, \"string\":\"string\", \"float\":1.234567890123456789, \"boolean\": true, \"dimensional-array\": [1,2,3,[1,2,3]]}")

(print (jsown:parse input-json))

;; Limit which fields are parsed into the resulting object
(print (jsown:parse input-json "integer" "boolean"))

;; Create a new object
(jsown:new-js
	("pizza" "pepperoni")
	("pie" "apple")
	("one-hundred" (+ 99 1)))