;; Source: Let Over Lambda
;; Author: Mike McMahon
(let ((let '`(let ((let ',let))
               ,let)))
  `(let ((let ',let)) ,let))

;; Source: http://www.nyx.net/~gthompso/quine.htm
;; Author: Chris Hruska
((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))

;; Author: Dave Seaman
(let ((p "(let ((p ~s)) (format t p p))")) (format t p p))