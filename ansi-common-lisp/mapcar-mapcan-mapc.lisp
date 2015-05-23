(mapcar #'(lambda (n) (when (evenp n) (list n))) '(1 2 3 4 5 6 7 8 9))

(mapcan #'(lambda (n) (when (evenp n) (list n))) '(1 2 3 4 5 6 7 8 9))

(mapc #'(lambda (n) (when (evenp n) (list n))) '(1 2 3 4 5 6 7 8 9))