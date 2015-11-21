(load "/home/path/programming/common-lisp/testing-grounds/exercises-from-references/ansi-common-lisp/ray-tracing-png.lisp")

(defpackage :point-distances
  (:use :common-lisp :ray-tracer))

(in-package :point-distances)

(defstruct point x y z)

(defvar center)
(defvar h1)
(defvar h2)
(defvar h3)
(defvar h4)
(defvar h5)
(defvar h6)

(defvar v1)
(defvar v2)
(defvar v3)
(defvar v4)
(defvar v5)
(defvar v6)

(defvar points)

(setq center (make-point :x 0 :y 0 :z 0))
(setq h1 (make-point :x 1 :y 0 :z 0))
(setq h2 (make-point :x 0.5 :y 0.8660254 :z 0))
(setq h3 (make-point :x -0.5 :y 0.8660254 :z 0))
(setq h4 (make-point :x -1 :y 0 :z 0))
(setq h5 (make-point :x -0.5 :y -0.8660254 :z 0))
(setq h6 (make-point :x 0.5 :y -0.8660254 :z 0))

(setq v1 (make-point :x 0.5 :y 0.4330127 :z 1.4142135))
(setq v2 (make-point :x 0 :y -0.4330127 :z 1.4142135))
(setq v3 (make-point :x -0.5 :y 0.4330127 :z 1.4142135))
(setq v4 (make-point :x 0.5 :y -0.4330127 :z -1.4142135))
(setq v5 (make-point :x 0 :y 0.4330127 :z -1.4142135))
(setq v6 (make-point :x -0.5 :y -0.4330127 :z -1.4142135))

(setq points (list center h1 h2 h3 h4 h5 h6 v1 v2 v3 v4 v5 v6))

(defun calculate-distance (point-1 point-2)
  (let ((distance (sqrt (+ (expt (- (point-x point-1)
                                    (point-x point-2)) 2)
                           (expt (- (point-y point-1)
                                    (point-y point-2)) 2)
                           (expt (- (point-z point-1)
                                    (point-z point-2)) 2)))))
    (when (and (> distance 0) (< distance 1))
      (print "These points are less than 1 unit apart.")
      (print point-1)
      (print point-2)
      (print distance))
    distance
    ))

(defun expand (list-1 list-2 function)
  (when (= (length list-1) (length list-2))
    (let ((expansion '()))
      (dolist (list-1-item list-1)
              (let ((dimensional-expansion '()))
                (dolist (list-2-item list-2)
                        (push (funcall function list-1-item list-2-item) dimensional-expansion))
                (push dimensional-expansion expansion)))
      expansion
      )))

(expand points points #'calculate-distance)

(defvar spheres '())
(dolist (point points)
  (let ((sphere '()))
    (push (* 30 (point-x point)) sphere)
    (push (* 30 (point-y point)) sphere)
    (push (* 30 (point-z point)) sphere)
    (push 5 sphere)
    (push 0.9 sphere)
    (push (reverse sphere) spheres)
    ))

(ray-trace spheres 4)