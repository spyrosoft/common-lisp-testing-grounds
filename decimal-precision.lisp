(defvar a)
(declaim (type double-float a b c d))

(setq a 1.123456789012345678901d0)
;(setq a (coerce 1.123456789012345678901 'double-float))

(setq b 2.123456789012345678901d0)

(setq c (* a b))

(inspect c)