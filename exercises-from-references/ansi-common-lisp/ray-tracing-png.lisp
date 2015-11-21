(ql:quickload 'zpng)

(defpackage :ray-tracer
	(:use :common-lisp :zpng)
	(:export :ray-trace))

(in-package :ray-tracer)

(declaim (optimize (safety 3) (debug 3)))

;; --------------------Math Utils--------------------

(defun magnitude-of-vector (x y z)
  (sqrt (+ (expt x 2) (expt y 2) (expt z 2))))

(defun unit-vector (x y z)
  (let ((d (magnitude-of-vector x y z)))
    (values (/ x d) (/ y d) (/ z d))))

(defstruct (point (:conc-name nil))  
  x y z)

(defun distance (p1 p2)
  (magnitude-of-vector (- (x p1) (x p2))
       (- (y p1) (y p2))
       (- (z p1) (z p2))))

(defun smallest-root (a b c)
  (if (zerop a)
      (/ (- c) b)
      (let ((disc (- (expt b 2) (* 4 a c))))
        (unless (minusp disc)
          (let ((discrt (sqrt disc)))
            (min (/ (+ (- b) discrt) (* 2 a))
                 (/ (- (- b) discrt) (* 2 a))))))))

;; --------------------Math Utils--------------------

(defstruct surface color)

(defparameter *ray-trace-world* nil)
(defparameter eye (make-point :x 0 :y 0 :z 200))

(defun tracer (pathname &optional (res 1))
  (let* ((inc (/ res))
         (square-side-length (* 100 res))
         (bitmap (make-array (list square-side-length square-side-length) :element-type :fixnum)))
    (do ((y -50 (+ y inc))
         (image-row 0 (1+ image-row)))
        ((< (- 50 y) inc))
      (do ((x -50 (+ x inc))
           (image-column 0 (1+ image-column)))
          ((< (- 50 x) inc))
        (setf (aref bitmap image-column image-row) (color-at x y))))
    (write-grayscale-png pathname bitmap)))

(defun color-at (x y)
  (multiple-value-bind (xr yr zr) 
                       (unit-vector (- x (x eye))
                                    (- y (y eye))
                                    (- 0 (z eye)))
    (round (* (sendray eye xr yr zr) 255))))

(defun sendray (pt xr yr zr)
  (multiple-value-bind (s int) (first-hit pt xr yr zr)
    (if s
        (* (lambert s int xr yr zr) (surface-color s))
        0)))

(defun first-hit (pt xr yr zr)
  (let (surface hit dist)
    (dolist (s *ray-trace-world*)
      (let ((h (intersect s pt xr yr zr)))
        (when h
          (let ((d (distance h pt)))
            (when (or (null dist) (< d dist))
              (setf surface s hit h dist d))))))
    (values surface hit)))

(defun lambert (s int xr yr zr)
  (multiple-value-bind (xn yn zn) (normal s int)
    (max 0 (+ (* xr xn) (* yr yn) (* zr zn)))))

(defstruct (sphere (:include surface))  
  radius center)

(defun defsphere (x y z r c)
  (let ((s (make-sphere 
             :radius r
             :center (make-point :x x :y y :z z)
             :color c)))
    (push s *ray-trace-world*)
    s))

(defun intersect (s pt xr yr zr)
  (funcall (typecase s (sphere #'sphere-intersect))
           s pt xr yr zr))

(defun sphere-intersect (s pt xr yr zr)
  (let* ((c (sphere-center s))
         (n (smallest-root (+ (expt xr 2) (expt yr 2) (expt zr 2))
                     (* 2 (+ (* (- (x pt) (x c)) xr)
                             (* (- (y pt) (y c)) yr)
                             (* (- (z pt) (z c)) zr)))
                     (+ (expt (- (x pt) (x c)) 2)
                        (expt (- (y pt) (y c)) 2)
                        (expt (- (z pt) (z c)) 2)
                        (- (expt (sphere-radius s) 2))))))
    (if n
        (make-point :x  (+ (x pt) (* n xr))
                    :y  (+ (y pt) (* n yr))
                    :z  (+ (z pt) (* n zr))))))

(defun normal (s pt)
  (funcall (typecase s (sphere #'sphere-normal))
           s pt))

(defun sphere-normal (s pt)
  (let ((c (sphere-center s)))
    (unit-vector (- (x c) (x pt))
                 (- (y c) (y pt))
                 (- (z c) (z pt)))))


;; --------------------PNG Utils--------------------

(defun write-grayscale-png (file-path bitmap)
  (with-open-file (file file-path :direction :output :if-exists :supersede)
    (let* ((image-width (first (array-dimensions bitmap)))
           (image-height (second (array-dimensions bitmap)))
           (png (make-instance 'png
                               :color-type :grayscale
                               :width image-width
                               :height image-height))
           (image-data (data-array png)))
      (dotimes (y image-height (write-png png file))
        (dotimes (x image-width)
          (setf (aref image-data x y 0) (aref bitmap y x)))))))

;; --------------------PNG Utils--------------------


(defun ray-trace (spheres &optional (resolution 1))
  "Spheres come in form (x y z radius color)"
  (setf *ray-trace-world* nil)
  (mapcar (lambda (sphere) (apply #'defsphere sphere)) spheres)
  (tracer #P"/tmp/spheres.png" resolution))

(defun ray-trace-test (&optional (resolution 1))
  (setf *ray-trace-world* nil)
  (defsphere 0 -300 -1200 200 .8)
  (defsphere -80 -100 -1200 200 .8)
  (defsphere 80 -100 -1200 200 .8)
  (do ((x -2 (1+ x)))
      ((> x 2))
    (do ((z 2 (1+ z)))
        ((> z 7))
      (defsphere (* x 200) 300 (* z -400) 40 .75)))
  (tracer #P"/tmp/spheres.png" resolution))