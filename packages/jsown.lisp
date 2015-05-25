(ql:quickload :jsown)

(defvar input-json "{\"integer\":100, \"string\":\"string\", \"double-float\":1.234567890123456789, \"boolean\": false, \"dimensional-array\": [1,2,3,[1,2,3]]}")

(defvar parsed-input-json (jsown:parse input-json))
(print parsed-input-json)

(setq *read-default-float-format* 'double-float)
;; Note that despite setting the default float format, the ratio is converted to single float
(print (jsown:to-json parsed-input-json))

;; To get around that, coerce the ratio to a double float in the JSON object itself
(setf (jsown:val parsed-input-json "float") (coerce (jsown:val parsed-input-json "float") 'double-float))
(print (jsown:to-json parsed-input-json))

;; Limit which fields are parsed into the resulting object
(print (jsown:parse input-json "integer" "boolean"))

;; Encode to string
;; Note that boolean false is converted to '(), then back to []
(jsown:to-json parsed-input-json)

;; Iterate through the keys and values
(jsown:do-json-keys (example-key example-value)
		parsed-input-json
	(print example-key)
	(print (typep example-value 'integer)))

;; Add additional items to an existing JSON object
(jsown:extend-js parsed-input-json
	("negative-integer" -200))

;; Create a new object from scratch
(jsown:new-js
	("pizza" "pepperoni")
	("pie" "apple")
	("one-hundred" (+ 99 1)))