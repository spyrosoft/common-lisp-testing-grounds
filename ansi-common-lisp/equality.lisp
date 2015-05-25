;; Numeric

(setq *read-default-float-format* 'double-float)

(= 2 2) ;T
(= 2 3) ;NIL
(= 2 2.0) ;T
(= 2 2.1) ;NIL
(= 2 2.0000000000000001) ;T (careful)
(eql 2 2.0000000000000001) ;NIL
(= 2 "2") ;ERROR