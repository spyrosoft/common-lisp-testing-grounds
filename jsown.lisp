(ql:quickload :jsown)

(defvar input-json "{\"integer\":100, \"string\":\"string\", \"float\":1.234567890123456789, \"boolean\": true, \"dimensional-array\": [1,2,3,[1,2,3]]}")

(print (jsown:parse input-json))

