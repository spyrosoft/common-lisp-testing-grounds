;; Chapter 3 Exercises - Lists
;; 2. Write a version of union that preserves the order of the elements in the original lists:

(defmacro while (condition &rest body)
  `(do ()
       ((not ,condition))
     ,@body))

;; Intentionally horribly inefficient
(defun new-union (list1 list2 &key (test #'eql))
  (let ((used-items '())
        (list1-iterator list1)
        (list2-iterator list2)
        (new-list '()))
    (while (or list1-iterator list2-iterator)
      (when list1-iterator
        (if (not (member (first list1-iterator) used-items :test test))
            (progn
              (push (first list1-iterator) new-list)
              (push (first list1-iterator) used-items)))
        (setf list1-iterator (rest list1-iterator)))
      (when list2-iterator
        (if (not (member (first list2-iterator) used-items :test test))
            (progn
              (push (first list2-iterator) new-list)
              (push (first list2-iterator) used-items)))
        (setf list2-iterator (rest list2-iterator))))
    (reverse new-list)))

(new-union '(a b c) '(b a d))
;; (A B C D)



;; 3. Define a function that takes a list and returns a list indicating the number of times each (eql) element appears, sorted from most common element to least common:

(defun occurrences (list)
  (let ((occurrences '()))
    (dolist (item list)
      (if (getf occurrences item)
          (setf (getf occurrences item) (1+ (getf occurrences item)))
          (setf (getf occurrences item) 1)))
    occurrences))

(occurrences '(a b a d a c d e a))
;; (A 4 C 2 D 2 B 1)



;; 5. Suppose the function pos+ takes a list and returns a list of each element plus its position
;; Define this function using (a) recursion, (b) iteration, (c) mapcar.
;; (a)

(defun pos+ (list)
  "Not tail optimized"
  (labels ((recursive-pos+ (list current-position)
             (if (null list)
                 list
                 (cons (+ current-position (first list))
                       (recursive-pos+ (rest list) (1+ current-position))))))
    (recursive-pos+ list 0)))

(defun pos+ (list)
  "Tail optimized"
  (labels ((recursive-pos+ (unprocessed-list processed-list current-position)
             (if (null unprocessed-list)
                 processed-list
                 (progn
                   (push (+ current-position (first unprocessed-list)) processed-list)
                   (recursive-pos+ (rest unprocessed-list) processed-list (1+ current-position))))))
    (reverse (recursive-pos+ list '() 0))))

;; (b)

(defun pos+ (list)
  (let ((new-list '()))
    (do ((position 0 (1+ position))
         (list-iterator list (rest list-iterator)))
        ((null list-iterator))
      (push (+ (first list-iterator) position) new-list))
    (reverse new-list)))

;; (c)

(defun pos+ (list)
  (let ((current-position -1))
    (mapcar #'(lambda (item)
                (incf current-position)
                (+ item current-position)) list)))

(pos+ '(7 5 1 4))
;; (7 6 3 7)


;; 9. Write a program to find the longest finite path through a network represented as in Section 3.15. The network may contain cycles.
(defun longest-path (start goal network)
  (depth-first-search goal (list (list start)) network))

(defun depth-first-search (goal stack network)
  (if (null stack)
      nil
      (let* ((path (first stack))
             (node (car path)))
          (if (eql node goal)
              (reverse path)
              (depth-first-search goal
                                  (append (new-paths path node network)
                                          (cdr stack))
                                  network)))))

(defun new-paths (path node network)
  (mapcar #'(lambda (new-path)
              (cons new-path path))
          (cdr (assoc node network))))